#!/bin/bash
# Command Tester
# Tests a slash command with sample arguments and shows expanded prompt

set -euo pipefail

show_usage() {
  echo "Usage: $0 [options] <command.md> [arg1] [arg2] ..."
  echo ""
  echo "Options:"
  echo "  -h, --help       Show this help"
  echo "  -v, --verbose    Show detailed parsing info"
  echo "  -b, --run-bash   Actually execute bash blocks (careful!)"
  echo ""
  echo "Examples:"
  echo "  $0 commands/review.md"
  echo "  $0 commands/review-pr.md 123 high"
  echo "  $0 -v commands/deploy.md staging v1.0.0"
  echo ""
  echo "Shows:"
  echo "  - Parsed frontmatter"
  echo "  - Expanded prompt with \$1, \$2, \$ARGUMENTS substituted"
  echo "  - Bash blocks that would execute"
  exit 0
}

# Parse options
VERBOSE=false
RUN_BASH=false

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      show_usage
      ;;
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    -b|--run-bash)
      RUN_BASH=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

if [ $# -lt 1 ]; then
  echo "Error: Missing command file"
  show_usage
fi

COMMAND_FILE="$1"
shift
ARGS=("$@")

# Validate file
if [ ! -f "$COMMAND_FILE" ]; then
  echo "❌ Error: File not found: $COMMAND_FILE"
  exit 1
fi

echo "🧪 Testing command: $COMMAND_FILE"
echo "📝 Arguments: ${ARGS[*]:-"(none)"}"
echo ""

# Read file
content=$(cat "$COMMAND_FILE")

# Parse frontmatter
has_frontmatter=false
frontmatter=""
prompt=""

if [[ "$content" == ---* ]]; then
  has_frontmatter=true
  frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')
  prompt=$(echo "$content" | sed '1,/^---$/d' | sed '1,/^---$/d')
else
  prompt="$content"
fi

# Show frontmatter
if [ "$has_frontmatter" = true ]; then
  echo "━━━━ Frontmatter ━━━━"
  echo "$frontmatter"
  echo ""
fi

# Show verbose parsing
if [ "$VERBOSE" = true ]; then
  echo "━━━━ Parsing Info ━━━━"
  echo "Arguments count: ${#ARGS[@]}"
  for i in "${!ARGS[@]}"; do
    echo "  \$$(($i + 1)) = ${ARGS[$i]}"
  done
  echo "  \$ARGUMENTS = ${ARGS[*]:-}"
  echo ""
fi

# Expand variables
expanded="$prompt"

# Replace $1, $2, $3, etc.
for i in "${!ARGS[@]}"; do
  arg_num=$(($i + 1))
  arg_value="${ARGS[$i]}"
  expanded=$(echo "$expanded" | sed "s/\\\$$arg_num/$arg_value/g")
done

# Replace $ARGUMENTS with all args
all_args="${ARGS[*]:-}"
expanded=$(echo "$expanded" | sed "s/\\\$ARGUMENTS/$all_args/g")

# Show expanded prompt
echo "━━━━ Expanded Prompt ━━━━"
echo "$expanded"
echo ""

# Find and show bash blocks
bash_blocks=$(echo "$expanded" | grep -oE '!\`[^`]+\`' || true)

if [ -n "$bash_blocks" ]; then
  echo "━━━━ Bash Blocks ━━━━"

  while IFS= read -r block; do
    [ -z "$block" ] && continue

    # Extract command from !`command`
    cmd=$(echo "$block" | sed 's/^!\`//' | sed 's/\`$//')

    echo "Command: $cmd"

    if [ "$RUN_BASH" = true ]; then
      echo "Output:"
      eval "$cmd" 2>&1 | sed 's/^/  /'
    else
      echo "  (use -b to execute)"
    fi
    echo ""
  done <<< "$bash_blocks"
fi

# Find file references
file_refs=$(echo "$expanded" | grep -oE '@[a-zA-Z0-9_./${}/-]+' || true)

if [ -n "$file_refs" ]; then
  echo "━━━━ File References ━━━━"
  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    file_path="${ref#@}"
    echo "Reference: $ref"

    # Expand CLAUDE_PLUGIN_ROOT if present
    if [[ "$file_path" == *'${CLAUDE_PLUGIN_ROOT}'* ]]; then
      expanded_path="${file_path//\$\{CLAUDE_PLUGIN_ROOT\}/${CLAUDE_PLUGIN_ROOT:-/path/to/plugin}}"
      echo "  Expands to: $expanded_path"
    fi

    # Check if file exists (if not a variable)
    if [[ "$file_path" != *'$'* ]] && [ -f "$file_path" ]; then
      echo "  ✅ File exists"
    elif [[ "$file_path" != *'$'* ]]; then
      echo "  ⚠️  File not found"
    fi
  done <<< "$file_refs"
  echo ""
fi

# Show what Claude would receive
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Test complete"
echo ""
echo "Claude would receive this prompt after expansion."
if [ -n "$bash_blocks" ]; then
  echo "Bash blocks would execute and inject their output."
fi
if [ -n "$file_refs" ]; then
  echo "File references would load file contents."
fi
