#!/bin/bash
# Command Linter
# Checks slash commands for best practices and common issues

set -euo pipefail

show_usage() {
  echo "Usage: $0 <command.md|directory>"
  echo ""
  echo "Checks command files for:"
  echo "  - Missing description"
  echo "  - Arguments without hints"
  echo "  - Overly broad tool access"
  echo "  - User-facing language (should be agent instructions)"
  echo "  - Long descriptions"
  echo "  - Best practice violations"
  echo ""
  echo "Examples:"
  echo "  $0 commands/review.md"
  echo "  $0 commands/"
  echo "  $0 .claude/commands/"
  exit 0
}

if [ $# -eq 0 ]; then
  show_usage
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  show_usage
fi

# Patterns that suggest user-facing language instead of agent instructions
USER_FACING_PATTERNS=(
  "This command will"
  "You will receive"
  "This will help you"
  "Click here"
  "Please wait"
  "Loading..."
)

# Collect files to lint
files=()

for arg in "$@"; do
  if [ -d "$arg" ]; then
    while IFS= read -r -d '' file; do
      files+=("$file")
    done < <(find "$arg" -name "*.md" -type f -print0)
  elif [ -f "$arg" ]; then
    files+=("$arg")
  else
    echo "⚠️  Skipping: $arg (not found)"
  fi
done

if [ ${#files[@]} -eq 0 ]; then
  echo "❌ No .md files found"
  exit 1
fi

echo "🔍 Linting ${#files[@]} command file(s)..."
echo ""

total_errors=0
total_warnings=0

lint_file() {
  local file="$1"
  local errors=0
  local warnings=0
  local issues=()

  # Read content
  content=$(cat "$file")

  # Extract frontmatter
  has_frontmatter=false
  frontmatter=""

  if [[ "$content" == ---* ]]; then
    has_frontmatter=true
    frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')
  fi

  # Get prompt content
  if [ "$has_frontmatter" = true ]; then
    prompt=$(echo "$content" | sed '1,/^---$/d' | sed '1,/^---$/d')
  else
    prompt="$content"
  fi

  # === CHECKS ===

  # 1. Check for description
  if [ "$has_frontmatter" = true ]; then
    if ! echo "$frontmatter" | grep -q '^description:'; then
      issues+=("⚠️  Missing description in frontmatter")
      ((warnings++))
    else
      desc=$(echo "$frontmatter" | grep '^description:' | cut -d: -f2- | sed 's/^ *//')
      desc_len=${#desc}

      if [ "$desc_len" -gt 60 ]; then
        issues+=("⚠️  Description too long ($desc_len chars, recommend <60)")
        ((warnings++))
      fi

      if [ "$desc_len" -eq 0 ]; then
        issues+=("⚠️  Empty description")
        ((warnings++))
      fi
    fi
  else
    # No frontmatter - check if first line could be description
    first_line=$(echo "$prompt" | head -1)
    if [ ${#first_line} -gt 80 ]; then
      issues+=("ℹ️  Consider adding frontmatter with description")
    fi
  fi

  # 2. Check for argument usage without hint
  if echo "$content" | grep -qE '\$[1-9]'; then
    if ! echo "$frontmatter" | grep -q 'argument-hint'; then
      issues+=("⚠️  Uses \$1/\$2/etc. but no argument-hint defined")
      ((warnings++))
    fi
  fi

  if echo "$content" | grep -qE '\$ARGUMENTS'; then
    if ! echo "$frontmatter" | grep -q 'argument-hint'; then
      issues+=("⚠️  Uses \$ARGUMENTS but no argument-hint defined")
      ((warnings++))
    fi
  fi

  # 3. Check for overly broad tool access
  if echo "$frontmatter" | grep -qE 'allowed-tools:.*\*'; then
    issues+=("⚠️  Uses wildcard '*' for allowed-tools (consider restricting)")
    ((warnings++))
  fi

  if echo "$frontmatter" | grep -qE 'Bash\(\*\)'; then
    issues+=("⚠️  Uses Bash(*) - consider Bash(git:*) or specific commands")
    ((warnings++))
  fi

  # 4. Check for user-facing language
  for pattern in "${USER_FACING_PATTERNS[@]}"; do
    if echo "$content" | grep -qi "$pattern"; then
      issues+=("⚠️  Contains user-facing language: \"$pattern\" (commands should be agent instructions)")
      ((warnings++))
      break
    fi
  done

  # 5. Check for empty prompt
  if [ -z "$(echo "$prompt" | tr -d '[:space:]')" ]; then
    issues+=("❌ No prompt content")
    ((errors++))
  fi

  # 6. Check for bash execution without allowed-tools
  if echo "$content" | grep -qE '!\`'; then
    if ! echo "$frontmatter" | grep -q 'allowed-tools'; then
      issues+=("⚠️  Uses bash execution but no allowed-tools specified")
      ((warnings++))
    fi
  fi

  # 7. Check for hardcoded paths
  if echo "$content" | grep -qE '!\`[^`]*/home/|!\`[^`]*/Users/|!\`[^`]*C:\\'; then
    issues+=("⚠️  Contains hardcoded paths (use \${CLAUDE_PLUGIN_ROOT} for portability)")
    ((warnings++))
  fi

  # 8. Check filename convention
  filename=$(basename "$file" .md)
  if [[ "$filename" =~ [A-Z] ]]; then
    issues+=("ℹ️  Filename has uppercase (convention: lowercase-with-dashes)")
  fi

  if [[ "$filename" =~ _ ]]; then
    issues+=("ℹ️  Filename uses underscores (convention: use dashes)")
  fi

  # 9. Check for very long frontmatter
  if [ "$has_frontmatter" = true ]; then
    fm_lines=$(echo "$frontmatter" | wc -l)
    if [ "$fm_lines" -gt 15 ]; then
      issues+=("ℹ️  Frontmatter is long ($fm_lines lines)")
    fi
  fi

  # === OUTPUT ===

  echo "📄 $file"

  if [ ${#issues[@]} -eq 0 ]; then
    echo "  ✅ All checks passed"
  else
    for issue in "${issues[@]}"; do
      echo "  $issue"
    done
  fi

  echo ""

  # Return counts via global vars (bash limitation)
  FILE_ERRORS=$errors
  FILE_WARNINGS=$warnings
}

# Lint all files
for file in "${files[@]}"; do
  lint_file "$file"
  ((total_errors += FILE_ERRORS)) || true
  ((total_warnings += FILE_WARNINGS)) || true
done

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary: ${#files[@]} files, $total_warnings warning(s), $total_errors error(s)"

if [ $total_errors -gt 0 ]; then
  exit 1
elif [ $total_warnings -gt 0 ]; then
  echo "⚠️  Review warnings above"
  exit 0
else
  echo "✅ All files passed linting"
  exit 0
fi
