#!/bin/bash
# Command Validator
# Validates slash command .md files for structure and syntax

set -euo pipefail

# Usage
if [ $# -eq 0 ]; then
  echo "Usage: $0 <command.md> [command2.md ...]"
  echo ""
  echo "Validates command files for:"
  echo "  - Valid Markdown format"
  echo "  - YAML frontmatter syntax"
  echo "  - Known frontmatter fields"
  echo "  - Field value validity"
  echo "  - Content presence"
  exit 1
fi

# Valid frontmatter fields
VALID_FIELDS=("description" "allowed-tools" "model" "argument-hint" "disable-model-invocation")
VALID_MODELS=("sonnet" "opus" "haiku")

validate_file() {
  local file="$1"
  local errors=0
  local warnings=0

  echo "🔍 Validating: $file"

  # Check file exists
  if [ ! -f "$file" ]; then
    echo "  ❌ File not found"
    return 1
  fi

  # Check .md extension
  if [[ "$file" != *.md ]]; then
    echo "  ⚠️  File doesn't have .md extension"
    ((warnings++))
  fi

  # Read file content
  content=$(cat "$file")

  # Check if file has content
  if [ -z "$content" ]; then
    echo "  ❌ File is empty"
    return 1
  fi

  # Check for frontmatter
  has_frontmatter=false
  if [[ "$content" == ---* ]]; then
    has_frontmatter=true

    # Extract frontmatter
    frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')

    if [ -z "$frontmatter" ]; then
      echo "  ❌ Frontmatter delimiters found but no content"
      ((errors++))
    else
      echo "  ✅ Has frontmatter"

      # Validate YAML syntax (basic check)
      if ! echo "$frontmatter" | grep -qE '^[a-zA-Z-]+:' ; then
        echo "  ❌ Invalid YAML syntax in frontmatter"
        ((errors++))
      fi

      # Check each field
      while IFS= read -r line; do
        [ -z "$line" ] && continue

        # Extract field name
        field=$(echo "$line" | cut -d: -f1 | tr -d ' ')

        # Check if field is known
        found=false
        for valid_field in "${VALID_FIELDS[@]}"; do
          if [ "$field" = "$valid_field" ]; then
            found=true
            break
          fi
        done

        if [ "$found" = false ] && [ -n "$field" ]; then
          echo "  ⚠️  Unknown frontmatter field: $field"
          ((warnings++))
        fi

        # Validate specific fields
        case "$field" in
          description)
            desc_value=$(echo "$line" | cut -d: -f2- | sed 's/^ *//')
            desc_len=${#desc_value}
            if [ "$desc_len" -gt 80 ]; then
              echo "  ⚠️  Description is long ($desc_len chars, recommended <60)"
              ((warnings++))
            elif [ "$desc_len" -eq 0 ]; then
              echo "  ⚠️  Description is empty"
              ((warnings++))
            else
              echo "  ✅ Description: \"$desc_value\""
            fi
            ;;
          model)
            model_value=$(echo "$line" | cut -d: -f2- | sed 's/^ *//')
            model_valid=false
            for valid_model in "${VALID_MODELS[@]}"; do
              if [ "$model_value" = "$valid_model" ]; then
                model_valid=true
                break
              fi
            done
            if [ "$model_valid" = false ]; then
              echo "  ❌ Invalid model: $model_value (must be: sonnet, opus, haiku)"
              ((errors++))
            else
              echo "  ✅ Model: $model_value"
            fi
            ;;
          allowed-tools)
            tools_value=$(echo "$line" | cut -d: -f2- | sed 's/^ *//')
            if [[ "$tools_value" == *"Bash(*)"* ]] || [[ "$tools_value" == "*" ]]; then
              echo "  ⚠️  Broad tool access: $tools_value (consider restricting)"
              ((warnings++))
            fi
            ;;
          disable-model-invocation)
            bool_value=$(echo "$line" | cut -d: -f2- | sed 's/^ *//')
            if [ "$bool_value" != "true" ] && [ "$bool_value" != "false" ]; then
              echo "  ❌ disable-model-invocation must be true or false"
              ((errors++))
            fi
            ;;
        esac

      done <<< "$frontmatter"
    fi
  else
    echo "  ℹ️  No frontmatter (optional)"
  fi

  # Get prompt content (after frontmatter)
  if [ "$has_frontmatter" = true ]; then
    prompt=$(echo "$content" | sed -n '/^---$/,/^---$/d; p' | sed '/^$/d')
  else
    prompt="$content"
  fi

  # Check for prompt content
  if [ -z "$prompt" ]; then
    echo "  ❌ No prompt content after frontmatter"
    ((errors++))
  else
    prompt_lines=$(echo "$prompt" | wc -l)
    echo "  ✅ Prompt content: $prompt_lines lines"
  fi

  # Check for argument usage without hint
  if echo "$content" | grep -qE '\$[1-9]|\$ARGUMENTS'; then
    if ! echo "$frontmatter" | grep -q 'argument-hint'; then
      echo "  ⚠️  Uses \$1/\$ARGUMENTS but no argument-hint defined"
      ((warnings++))
    fi
  fi

  # Check for bash execution
  if echo "$content" | grep -qE '!\`[^`]+\`'; then
    echo "  ℹ️  Contains bash execution blocks"
    if ! echo "$frontmatter" | grep -q 'allowed-tools'; then
      echo "  ⚠️  Uses bash execution but no allowed-tools defined"
      ((warnings++))
    fi
  fi

  # Check for file references
  if echo "$content" | grep -qE '@[a-zA-Z$]'; then
    echo "  ℹ️  Contains file references (@)"
  fi

  # Summary
  echo ""
  if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo "  ✅ All checks passed"
    return 0
  elif [ $errors -eq 0 ]; then
    echo "  ⚠️  Passed with $warnings warning(s)"
    return 0
  else
    echo "  ❌ Failed with $errors error(s), $warnings warning(s)"
    return 1
  fi
}

# Main
total_errors=0

for file in "$@"; do
  echo ""
  if ! validate_file "$file"; then
    ((total_errors++))
  fi
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
done

echo ""
if [ $total_errors -eq 0 ]; then
  echo "✅ All files validated successfully"
  exit 0
else
  echo "❌ $total_errors file(s) failed validation"
  exit 1
fi
