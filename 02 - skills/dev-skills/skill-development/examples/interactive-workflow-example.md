# Interactive Workflow Example

This example shows how to use `AskUserQuestion` tool to create interactive skill development workflows.

## Overview

The `AskUserQuestion` tool allows Claude to ask users questions during skill creation or editing, making the process interactive and user-friendly.

## Basic Usage Pattern

```json
{
  "questions": [
    {
      "question": "What would you like to do?",
      "header": "Task Type",
      "multiSelect": false,
      "options": [
        {
          "label": "Option 1",
          "description": "What this option does"
        },
        {
          "label": "Option 2",
          "description": "What this option does"
        }
      ]
    }
  ]
}
```

## Field Descriptions

- **question**: The complete question to ask (with question mark)
- **header**: Short label (max 12 chars) shown as chip/tag
- **multiSelect**: `true` for multiple selections, `false` for single
- **options**: Array of 2-4 options
  - **label**: Display text (1-5 words, concise)
  - **description**: Explanation of what this option means

## Example 1: Determine Create vs Edit

```json
{
  "questions": [
    {
      "question": "What would you like to do?",
      "header": "Task Type",
      "multiSelect": false,
      "options": [
        {
          "label": "Create a new skill",
          "description": "Start from scratch with new skill structure"
        },
        {
          "label": "Edit an existing skill",
          "description": "Update frontmatter, description, or content"
        }
      ]
    }
  ]
}
```

**When to use:** At the start of skill-development to route to creation vs editing workflow

## Example 2: Gather Skill Information

```json
{
  "questions": [
    {
      "question": "What specific capability should this Skill provide?",
      "header": "Capability",
      "multiSelect": false,
      "options": [
        {
          "label": "Process/transform files (e.g., PDF, Excel, CSV)",
          "description": "Extract data, convert formats, manipulate documents"
        },
        {
          "label": "Analyze/review code or documentation",
          "description": "Code review, pattern detection, quality checks"
        },
        {
          "label": "Generate/create content (e.g., docs, commits, reports)",
          "description": "Create new files, messages, or structured output"
        },
        {
          "label": "Automate workflow/task",
          "description": "Execute scripts, orchestrate multiple steps, integrate tools"
        }
      ]
    },
    {
      "question": "When should Claude automatically use this Skill?",
      "header": "Triggers",
      "multiSelect": true,
      "options": [
        {
          "label": "User mentions specific file types (e.g., .pdf, .xlsx)",
          "description": "Trigger on file extensions or format names"
        },
        {
          "label": "User uses specific verbs (e.g., analyze, extract, generate)",
          "description": "Trigger on action words related to this capability"
        },
        {
          "label": "User works in specific domain (e.g., git, testing, API design)",
          "description": "Trigger on domain-specific terminology"
        }
      ]
    }
  ]
}
```

**When to use:** During skill creation to understand scope and triggers

**Note:** This asks 2 questions at once. Keep to 1-3 questions maximum to avoid overwhelming user.

## Example 3: Determine Skill Location

```json
{
  "questions": [
    {
      "question": "Where should this Skill be created?",
      "header": "Location",
      "multiSelect": false,
      "options": [
        {
          "label": "Personal (~/.claude/skills/) - Recommended",
          "description": "Your personal workflows, experiments, productivity tools"
        },
        {
          "label": "Project (.claude/skills/) - For team sharing",
          "description": "Team workflows, project-specific patterns, shared utilities"
        },
        {
          "label": "Plugin (plugin-name/skills/)",
          "description": "Bundle with plugin for distribution"
        }
      ]
    }
  ]
}
```

**When to use:** After understanding scope, before creating directory structure

## Example 4: Determine Edit Type

```json
{
  "questions": [
    {
      "question": "What do you want to edit in this skill?",
      "header": "Edit Type",
      "multiSelect": true,
      "options": [
        {
          "label": "Description (trigger words, discovery)",
          "description": "Update frontmatter description to improve skill activation"
        },
        {
          "label": "Instructions (main workflow)",
          "description": "Modify step-by-step instructions or add/remove steps"
        },
        {
          "label": "Add new section",
          "description": "Add Examples, Best practices, Requirements, etc."
        },
        {
          "label": "Refactor for progressive disclosure",
          "description": "Split into references/ or optimize for better token usage"
        }
      ]
    }
  ]
}
```

**When to use:** After reading current skill, to determine what changes to make

**Note:** `multiSelect: true` allows user to select multiple edit types

## Example 5: Confirm Before Proceeding

```json
{
  "questions": [
    {
      "question": "Does this structure work for you?",
      "header": "Confirm",
      "multiSelect": false,
      "options": [
        {
          "label": "Yes, proceed",
          "description": "Create the skill with this structure"
        },
        {
          "label": "No, let me adjust",
          "description": "I want to change something first"
        }
      ]
    }
  ]
}
```

**When to use:** After showing preview, before creating files

## Interactive Workflow Pattern

### Full Creation Flow

```
1. AskUserQuestion: Create or Edit?
   ↓
2. [IF CREATE] AskUserQuestion: Capability + Triggers
   ↓
3. AskUserQuestion: Location
   ↓
4. Propose name based on answers
   ↓
5. Show preview of structure
   ↓
6. AskUserQuestion: Confirm?
   ↓
7. [IF CONFIRMED] Create skill
```

### Full Editing Flow

```
1. AskUserQuestion: Which skill?
   ↓
2. Read and analyze skill
   ↓
3. Show current state
   ↓
4. AskUserQuestion: What to edit?
   ↓
5. Make changes
   ↓
6. Show summary of changes
```

## Best Practices

### DO

- ✅ Ask 1-3 questions at a time (avoid overwhelming)
- ✅ Use clear, specific question text
- ✅ Provide 2-4 options (not too many)
- ✅ Write concise labels (1-5 words)
- ✅ Write helpful descriptions
- ✅ Use multiSelect when choices aren't mutually exclusive
- ✅ Keep header short (max 12 chars)

### DON'T

- ❌ Ask too many questions at once (>4)
- ❌ Use vague option labels
- ❌ Forget to add descriptions
- ❌ Use multiSelect when only one choice makes sense
- ❌ Ask questions that could be inferred from context

## Progressive Questioning

Break complex workflows into stages:

**Stage 1: High-level decisions**
```json
{
  "questions": [
    {
      "question": "What would you like to do?",
      "header": "Task",
      "multiSelect": false,
      "options": [...]
    }
  ]
}
```

**Stage 2: Detailed scope** (only if creating)
```json
{
  "questions": [
    {
      "question": "What capability?",
      "header": "Capability",
      "multiSelect": false,
      "options": [...]
    },
    {
      "question": "When to trigger?",
      "header": "Triggers",
      "multiSelect": true,
      "options": [...]
    }
  ]
}
```

**Stage 3: Confirmation** (after showing preview)
```json
{
  "questions": [
    {
      "question": "Proceed with this structure?",
      "header": "Confirm",
      "multiSelect": false,
      "options": [...]
    }
  ]
}
```

## Handling User Responses

After asking questions, Claude receives answers in the tool result. Process answers to:

1. **Route workflow**: Create vs Edit
2. **Gather requirements**: Capability, triggers, location
3. **Make decisions**: Structure complexity, file organization
4. **Confirm actions**: Show preview, ask for confirmation

## Example: Complete Interactive Creation

```markdown
**Step 1: Ask what to do**

Use AskUserQuestion:
{
  "questions": [{"question": "Create or Edit?", ...}]
}

User selects: "Create a new skill"

**Step 2: Gather scope**

Use AskUserQuestion:
{
  "questions": [
    {"question": "What capability?", ...},
    {"question": "When to trigger?", ...}
  ]
}

User selects:
- Capability: "Process/transform files"
- Triggers: ["File types", "Action verbs"]

**Step 3: Determine location**

Use AskUserQuestion:
{
  "questions": [{"question": "Where to create?", ...}]
}

User selects: "Personal (~/.claude/skills/)"

**Step 4: Propose name**

Based on answers, propose: `processing-spreadsheets`
Ask user to confirm or provide alternative

**Step 5: Show preview**

```
I'll create a Skill with this structure:

**Name**: `processing-spreadsheets`
**Location**: `~/.claude/skills/`

**Description**:
"This skill should be used when the user asks to 'process spreadsheet',
'analyze Excel file', 'extract CSV data', or works with .xlsx, .csv files."

**Structure**:
- SKILL.md (core workflow)
- references/ (detailed patterns if needed)
- examples/ (working examples)

Does this work for you?
```

**Step 6: Confirm**

Use AskUserQuestion:
{
  "questions": [{"question": "Proceed?", ...}]
}

User selects: "Yes, proceed"

**Step 7: Create skill**

Create directory structure, write SKILL.md, validate
```

## Benefits of Interactive Workflows

1. **User-friendly**: Guides user through complex process
2. **Reduces errors**: Validates choices early
3. **Gathers context**: Understands user intent clearly
4. **Flexible**: Adapts based on user selections
5. **Transparent**: Shows preview before proceeding

## When to Use AskUserQuestion

Use when:
- Multiple valid approaches exist
- User preferences matter
- Gathering requirements
- Routing between workflows
- Confirming before major changes
- Offering choices with trade-offs

Don't use when:
- Answer is obvious from context
- Single correct approach exists
- Adds unnecessary friction
- User already provided information

## Integration with Skill Development

The skill-development skill uses `AskUserQuestion` to:

1. **Route**: Create vs Edit
2. **Gather**: Capability, triggers, location
3. **Determine**: Edit type, structure complexity
4. **Confirm**: Preview before proceeding

This makes skill development interactive, user-friendly, and less error-prone.

## Reference Implementation

See `references/creating-skills.md` and `references/editing-skills.md` for complete examples of interactive workflows using `AskUserQuestion` throughout the skill development process.
