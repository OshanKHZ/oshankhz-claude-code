#!/bin/bash
# Validate skill structure and content
# Usage: bash scripts/validate-skill.sh path/to/skill-name

set -euo pipefail

SKILL_DIR="${1:-.}"
ERRORS=0

echo "Validating skill at: $SKILL_DIR"
echo "================================"

# Check 1: SKILL.md exists
echo -n "✓ Checking SKILL.md exists... "
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
  echo "❌ FAILED"
  echo "  ERROR: SKILL.md not found"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ PASSED"
fi

# Check 2: YAML frontmatter
echo -n "✓ Checking YAML frontmatter... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  if ! head -n 1 "$SKILL_DIR/SKILL.md" | grep -q "^---$"; then
    echo "❌ FAILED"
    echo "  ERROR: Frontmatter must start with '---' on line 1"
    ERRORS=$((ERRORS + 1))
  elif ! head -n 20 "$SKILL_DIR/SKILL.md" | tail -n +2 | grep -q "^---$"; then
    echo "❌ FAILED"
    echo "  ERROR: Frontmatter must end with '---'"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 3: Required fields
echo -n "✓ Checking required fields... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  MISSING_FIELDS=""
  if ! grep -q "^name:" "$SKILL_DIR/SKILL.md"; then
    MISSING_FIELDS="${MISSING_FIELDS}name, "
  fi
  if ! grep -q "^description:" "$SKILL_DIR/SKILL.md"; then
    MISSING_FIELDS="${MISSING_FIELDS}description, "
  fi

  if [ -n "$MISSING_FIELDS" ]; then
    echo "❌ FAILED"
    echo "  ERROR: Missing fields: ${MISSING_FIELDS%, }"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 4: Name format
echo -n "✓ Checking name format... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  NAME=$(grep "^name:" "$SKILL_DIR/SKILL.md" | head -n 1 | cut -d: -f2- | xargs)
  if [ -z "$NAME" ]; then
    echo "❌ FAILED"
    echo "  ERROR: name field is empty"
    ERRORS=$((ERRORS + 1))
  elif ! echo "$NAME" | grep -qE "^[a-z0-9-]+$"; then
    echo "❌ FAILED"
    echo "  ERROR: name must be lowercase letters, numbers, and hyphens only"
    echo "  FOUND: '$NAME'"
    ERRORS=$((ERRORS + 1))
  elif [ ${#NAME} -gt 64 ]; then
    echo "❌ FAILED"
    echo "  ERROR: name must be max 64 characters (found: ${#NAME})"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 5: Description format
echo -n "✓ Checking description... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  DESC=$(grep "^description:" "$SKILL_DIR/SKILL.md" | head -n 1 | cut -d: -f2- | xargs)
  if [ -z "$DESC" ]; then
    echo "❌ FAILED"
    echo "  ERROR: description field is empty"
    ERRORS=$((ERRORS + 1))
  elif [ ${#DESC} -gt 1024 ]; then
    echo "❌ FAILED"
    echo "  ERROR: description must be max 1024 characters (found: ${#DESC})"
    ERRORS=$((ERRORS + 1))
  elif ! echo "$DESC" | grep -qi "this skill should be used when"; then
    echo "⚠️  WARNING"
    echo "  SUGGESTION: description should use third person: 'This skill should be used when...'"
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 6: Line count
echo -n "✓ Checking line count... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  LINE_COUNT=$(wc -l < "$SKILL_DIR/SKILL.md")
  if [ "$LINE_COUNT" -gt 500 ]; then
    echo "❌ FAILED"
    echo "  ERROR: SKILL.md has $LINE_COUNT lines (max 500)"
    echo "  SUGGESTION: Move detailed content to references/"
    ERRORS=$((ERRORS + 1))
  elif [ "$LINE_COUNT" -gt 400 ]; then
    echo "⚠️  WARNING"
    echo "  INFO: SKILL.md has $LINE_COUNT lines (recommend <400)"
    echo "  SUGGESTION: Consider using references/ for detailed content"
  else
    echo "✅ PASSED ($LINE_COUNT lines)"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 7: Referenced files exist
echo -n "✓ Checking referenced files... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  MISSING_REFS=""
  while IFS= read -r ref; do
    ref_file="$SKILL_DIR/$ref"
    if [ ! -f "$ref_file" ]; then
      MISSING_REFS="${MISSING_REFS}$ref, "
    fi
  done < <(grep -oP '(?<=\]\()[^)]*\.md(?=\))' "$SKILL_DIR/SKILL.md" 2>/dev/null || true)

  if [ -n "$MISSING_REFS" ]; then
    echo "❌ FAILED"
    echo "  ERROR: Referenced files not found: ${MISSING_REFS%, }"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 8: Second person usage
echo -n "✓ Checking for second person... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  # Skip frontmatter, check body
  if tail -n +10 "$SKILL_DIR/SKILL.md" | grep -qE "\b[Yy]ou (should|need|must|can|will)\b"; then
    echo "⚠️  WARNING"
    echo "  SUGGESTION: Avoid second person ('you should', 'you need')"
    echo "  USE: Imperative form ('Do X', 'Configure Y')"
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 9: Trigger phrases in description
echo -n "✓ Checking trigger phrases... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  DESC=$(grep "^description:" "$SKILL_DIR/SKILL.md" | head -n 1 | cut -d: -f2-)
  # Check for quoted phrases like "create a hook", "add something"
  if echo "$DESC" | grep -qE '"[^"]+"|'"'"'[^'"'"']+'"'"; then
    echo "✅ PASSED"
  else
    echo "⚠️  WARNING"
    echo "  SUGGESTION: Add specific trigger phrases in quotes"
    echo "  EXAMPLE: '...asks to \"create X\", \"configure Y\"...'"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 10: YAML has no tabs
echo -n "✓ Checking YAML for tabs... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  # Get frontmatter (lines between first and second ---)
  FRONTMATTER=$(sed -n '2,/^---$/p' "$SKILL_DIR/SKILL.md" | head -n -1)
  if echo "$FRONTMATTER" | grep -q $'\t'; then
    echo "❌ FAILED"
    echo "  ERROR: YAML frontmatter contains tabs (use spaces only)"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 11: allowed-tools validation (only check frontmatter, not examples in content)
echo -n "✓ Checking allowed-tools... "
if [ -f "$SKILL_DIR/SKILL.md" ]; then
  # Extract only frontmatter (between first two ---) and check for allowed-tools
  ALLOWED_TOOLS=$(sed -n '2,/^---$/p' "$SKILL_DIR/SKILL.md" | head -n -1 | grep "^allowed-tools:" | head -n 1 | cut -d: -f2- | xargs || true)
  if [ -z "$ALLOWED_TOOLS" ]; then
    echo "✅ PASSED (not specified)"
  else
    # Valid tool names
    VALID_TOOLS="Read|Write|Edit|Grep|Glob|Bash|Task|WebFetch|WebSearch|NotebookEdit|TodoWrite|AskUserQuestion"
    INVALID_TOOLS=""
    # Split by comma and check each (POSIX compatible)
    echo "$ALLOWED_TOOLS" | tr ',' '\n' | while read -r tool; do
      tool=$(echo "$tool" | xargs)  # trim whitespace
      if [ -n "$tool" ] && ! echo "$tool" | grep -qE "^($VALID_TOOLS)$"; then
        echo "$tool" >> /tmp/invalid_tools_$$
      fi
    done
    if [ -f /tmp/invalid_tools_$$ ]; then
      INVALID_TOOLS=$(cat /tmp/invalid_tools_$$ | tr '\n' ', ' | sed 's/, $//')
      rm -f /tmp/invalid_tools_$$
      echo "❌ FAILED"
      echo "  ERROR: Invalid tool names: $INVALID_TOOLS"
      echo "  VALID: Read, Write, Edit, Grep, Glob, Bash, Task, WebFetch, WebSearch, etc."
      ERRORS=$((ERRORS + 1))
    else
      echo "✅ PASSED"
    fi
  fi
else
  echo "⏭️  SKIPPED (no SKILL.md)"
fi

# Check 12: Empty subdirectories warning
echo -n "✓ Checking for empty subdirectories... "
if [ -d "$SKILL_DIR" ]; then
  EMPTY_DIRS=""
  for subdir in "references" "examples" "scripts"; do
    if [ -d "$SKILL_DIR/$subdir" ]; then
      # Check if directory is empty (no files)
      if [ -z "$(ls -A "$SKILL_DIR/$subdir" 2>/dev/null)" ]; then
        EMPTY_DIRS="${EMPTY_DIRS}$subdir/, "
      fi
    fi
  done
  if [ -n "$EMPTY_DIRS" ]; then
    echo "⚠️  WARNING"
    echo "  INFO: Empty directories found: ${EMPTY_DIRS%, }"
    echo "  SUGGESTION: Remove empty directories or add content"
  else
    echo "✅ PASSED"
  fi
else
  echo "⏭️  SKIPPED (no skill directory)"
fi

echo ""
echo "================================"
if [ $ERRORS -eq 0 ]; then
  echo "✅ Validation PASSED (0 errors)"
  exit 0
else
  echo "❌ Validation FAILED ($ERRORS errors)"
  exit 1
fi
