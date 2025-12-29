# Organize and Split Workflows - Detailed Guide

Complete processes for creating modular .claude/rules/ structure and splitting large CLAUDE.md files.

## Organize Workflow

Create new .claude/rules/ structure from scratch.

### When to Use

- User chose "Modular" in initialize workflow
- Large project (>10k lines) needing organized documentation
- Different rules for different file types

### Process

#### Step 1: Detect Stack

Same as initialize workflow - detect or ask about tech stack.

#### Step 2: Ask Which Rules to Create

```json
{
  "questions": [
    {
      "question": "Which rule files should I create?",
      "header": "Rules",
      "multiSelect": true,
      "options": [
        {
          "label": "coding-standards.md (Recommended)",
          "description": "Naming conventions, import order, quality rules. Essential for all projects."
        },
        {
          "label": "architecture.md (Recommended)",
          "description": "Pattern details, structure, dependency rules. Core architectural guidance."
        },
        {
          "label": "testing.md",
          "description": "Framework, conventions, patterns. Include if tests exist or planned."
        },
        {
          "label": "api.md",
          "description": "API patterns, errors, validation. For backend projects only."
        }
      ]
    }
  ]
}
```

#### Step 3: Think Through Design

Before generating:

1. **What in each file vs CLAUDE.md?**
   - CLAUDE.md: Core non-negotiables
   - Rules: Detailed, framework-specific patterns
   - Avoid duplication

2. **What path patterns?**
   - `coding-standards.md`: `src/**/*.{ts,tsx}`
   - `testing.md`: `**/*.{test,spec}.*`
   - `api.md`: `src/{api,routes}/**/*`
   - Based on actual project structure

3. **Key conventions in this stack?**
   - Framework best practices
   - Language idioms
   - Non-obvious patterns

4. **Keep concise?**
   - Each file <200 lines
   - One topic per file
   - Reference, don't duplicate

#### Step 4: Show Preview

```markdown
.claude/rules/
├── coding-standards.md (~150 lines)
│   - Naming (files, code)
│   - Import order
│   - Quality rules
│   - Path: src/**/*.{ts,tsx}
│
├── architecture.md (~100 lines)
│   - Pattern details
│   - Structure examples
│   - Dependency rules
│
└── testing.md (~80 lines)
    - Framework conventions
    - Location, naming
    - Coverage expectations
    - Path: **/*.{test,spec}.*

**Update CLAUDE.md**:
- Keep Core Standards
- Add references to rules/
- Remove detailed sections (moved to rules/)

Approve?
```

#### Step 5: Create Files

After approval:
1. Create `.claude/rules/` directory
2. Create each rule file with YAML frontmatter
3. Add appropriate `paths` patterns
4. Update CLAUDE.md to reference rules

#### Step 6: Inform User

```markdown
✅ .claude/rules/ structure created

📁 Structure:
.claude/
├── CLAUDE.md (~X lines - core standards)
└── rules/
    ├── coding-standards.md (~Y lines)
    ├── architecture.md (~Z lines)
    └── [other files]

💡 How it works:
- CLAUDE.md: Core, always loaded
- rules/*.md: Loaded by path pattern
- More: https://code.claude.com/docs/en/memory

Next:
1. Review and customize each file
2. Add more rules as needed
3. Use sync to keep updated
```

---

## Split Workflow

Break large CLAUDE.md into modular structure.

### When to Use

- CLAUDE.md >500 lines
- Multiple distinct topics in single file
- Want path-specific rules for different areas

### Process

#### Step 1: Read and Analyze CLAUDE.md

```bash
cat CLAUDE.md
```

**Identify**:
- Sections (## headers)
- Core vs detailed sections
- Line counts per section
- Potential duplication
- Topics that could be separated

**Example analysis**:
```
CLAUDE.md (800 lines):
- Overview (50 lines) - CORE
- Core Standards (80 lines) - CORE
- Coding Standards (200 lines) - MOVE TO RULES
- Architecture (150 lines) - MOVE TO RULES
- Testing (100 lines) - MOVE TO RULES
- API Conventions (120 lines) - MOVE TO RULES
- Git (100 lines) - KEEP (brief) or MOVE TO RULES
```

#### Step 2: Think Through Split Strategy

**Think step-by-step**:

1. **What stays in CLAUDE.md?**
   - Project overview
   - Core Standards (verify-before-referencing, no `any`)
   - Git Conventions (brief or reference)
   - References to .claude/rules/ files
   - Target: ~100-150 lines

2. **What moves to rules/?**
   - Detailed Coding Standards → `coding-standards.md`
   - Architecture details → `architecture.md`
   - Testing patterns → `testing.md`
   - API conventions → `api.md`
   - Database patterns → `database.md`

3. **Organize by topic**:
   - Group related sections
   - One file per topic
   - Keep coupled content together

4. **Path patterns**:
   - Based on project structure
   - Specific but stable
   - Match actual file organization

#### Step 3: Show Split Preview

```markdown
## Split Strategy

**Current**: CLAUDE.md (~800 lines)

**After**:

CLAUDE.md (~120 lines):
- Overview, Tech Stack
- Core Standards
- Git Conventions (brief)
- References to rules/

.claude/rules/coding-standards.md (~180 lines):
- Moved: Naming (lines 85-145)
- Moved: Import Order (lines 146-170)
- Moved: Quality Rules (lines 171-210)
- Path: src/**/*.{ts,tsx}

.claude/rules/architecture.md (~150 lines):
- Moved: Architecture (lines 220-350)
- Moved: Structure (lines 351-420)
- No path (global)

.claude/rules/testing.md (~90 lines):
- Moved: Testing (lines 450-530)
- Path: **/*.{test,spec}.*

.claude/rules/api.md (~110 lines):
- Moved: API Conventions (lines 540-650)
- Path: src/{api,routes}/**/*

**Total**: 800 lines → 650 lines across 5 files
**CLAUDE.md reduced**: 800 → 120 lines (85% reduction)

Approve?
```

#### Step 4: Execute Split

After approval:

1. **Create .claude/rules/ directory**
   ```bash
   mkdir -p .claude/rules
   ```

2. **Create rule files** with moved content:
   - Extract relevant sections from CLAUDE.md
   - Add YAML path frontmatter
   - Organize content clearly

3. **Update CLAUDE.md**:
   - Remove moved sections
   - Add "Documentation Structure" section
   - Reference each rule file
   - Keep core standards

Example updated CLAUDE.md:

```markdown
# Project

> Core standards - See .claude/rules/ for detailed guidelines

## Tech Stack
[...]

## Core Standards
[Keep verify-before-referencing, no any, etc.]

## Git Conventions
[Brief overview or reference to rules/git.md]

## Documentation Structure

Detailed guidelines in `.claude/rules/`:
- `coding-standards.md` - Naming, imports, quality (src/**/*.ts)
- `architecture.md` - Pattern details and structure
- `testing.md` - Test conventions (*.test.*)
- `api.md` - API patterns (src/api/**/*)

---

*Rules load automatically based on path patterns*
```

#### Step 5: Inform User

```markdown
✅ CLAUDE.md split into modular structure

📁 Result:
- CLAUDE.md: ~120 lines (core only)
- .claude/rules/: [X] focused files

🎯 Organization:
- Improved context management
- Path-specific rules active
- Easier to maintain

Next:
1. Review split files
2. Adjust path patterns if needed
3. Add more rules as project grows
```

---

## Rule File Templates

### coding-standards.md Template

```yaml
---
paths: src/**/*.{ts,tsx}
---

# Coding Standards

## Naming Conventions
**Files**: [patterns]
**Code**: [patterns]
**Booleans**: [is/has/can/should]

## Import Order
[structure]

## Quality Rules
- Functions < 30 lines
- Max 3-4 parameters
- Single responsibility
```

### architecture.md Template

```yaml
---
# No path - applies globally
---

# Architecture: [Pattern Name]

## Overview
[What and why]

## Key Principles
- [Principle 1]
- [Principle 2]

## Guidelines
[Specific rules]
```

### testing.md Template

```yaml
---
paths: **/*.{test,spec}.*
---

# Testing Standards

## Framework
[Name, command]

## Conventions
- Location: [colocated/separate]
- Naming: [pattern]
- Structure: [AAA/GWT]

## Coverage
[Expectations]
```

### api.md Template

```yaml
---
paths: src/{api,routes}/**/*
---

# API Standards

## Endpoint Patterns
[REST conventions]

## Error Format
[Structure]

## Status Codes
[Common codes]

## Validation
[Approach]
```

---

## Best Practices

### Organize Workflow

1. ✅ Create complete structure from start
2. ✅ Use recommended files (coding-standards, architecture)
3. ✅ Add path patterns where appropriate
4. ✅ Keep files <200 lines each
5. ✅ Update CLAUDE.md to reference rules

### Split Workflow

1. ✅ Analyze before splitting
2. ✅ Keep core in CLAUDE.md (100-150 lines)
3. ✅ Move details to focused files
4. ✅ One topic per file
5. ✅ Use path patterns based on actual structure
6. ✅ Show clear preview before splitting

## Anti-Patterns

### Organize

- ❌ Creating too many files (>10 rule files)
- ❌ Files too small (<50 lines each)
- ❌ Duplicating CLAUDE.md content
- ❌ No path patterns when they'd help

### Split

- ❌ Splitting when CLAUDE.md <500 lines
- ❌ Creating new rules without grouping related content
- ❌ Leaving CLAUDE.md empty (need core standards)
- ❌ Breaking related content across files

## Migration Checklist

**After creating/splitting**:

- [ ] CLAUDE.md has core standards
- [ ] Each rule file has clear topic
- [ ] Path patterns are appropriate
- [ ] No duplicate content
- [ ] Files are <200 lines
- [ ] CLAUDE.md references rules/
- [ ] All content still accessible
