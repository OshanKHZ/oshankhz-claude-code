# Sync Workflow - Detailed Guide

Complete process for analyzing codebase and updating documentation with detected patterns.

## Overview

Sync workflow analyzes existing code to extract real patterns and updates CLAUDE.md or .claude/rules/ to match.

**When to use**: Existing projects with outdated docs or codebases without documentation

## Step-by-Step Process

### Step 1: Detect Current Setup

Check what documentation exists:

```bash
# Check for CLAUDE.md
ls CLAUDE.md 2>/dev/null

# Check for modular structure
ls -la .claude/rules/ 2>/dev/null
```

**Determine mode**:
- **CREATE**: No CLAUDE.md → analyze and create from scratch
- **UPDATE Single**: CLAUDE.md exists, no .claude/rules/
- **UPDATE Modular**: CLAUDE.md + .claude/rules/ exist

### Step 2: Analyze Codebase Structure

**Use Task tool with subagent_type='Explore'**:

```
Analyze this codebase:
1. Main source directory (src/, app/, lib/)
2. Tech stack (package.json, requirements.txt, go.mod)
3. Folder organization pattern
4. Test location and patterns
5. Most common file types
```

**Extract key information**:
- Primary language and framework
- Source code location
- Test location (if any)
- Build/config files
- Architectural pattern in use

### Step 3: Extract Naming Conventions

**Use Glob and Read tools** to sample files:

```bash
# Frontend: Sample React/Vue components
# Backend: Sample controllers/services/models
# General: Sample main source files
```

**Analyze patterns in**:
- **File naming**: PascalCase, kebab-case, snake_case, camelCase
- **Function naming**: camelCase, PascalCase
- **Variable naming**: camelCase, snake_case
- **Class/component naming**: PascalCase
- **Boolean naming**: is/has/can/should prefixes

**Think step-by-step**:
1. What pattern appears >80%? (= established convention)
2. Are there exceptions? Why?
3. Does it match framework conventions?
4. Should this be documented?

**Example findings**:
- Files: 95% use PascalCase for components → document
- Functions: 90% use camelCase → document
- Booleans: 85% use is/has prefix → document
- Some legacy snake_case: <10% → don't document (not dominant)

### Step 4: Analyze Architectural Patterns

Compare actual structure vs documented architecture (if exists):

**Questions to answer**:
1. Does actual folder structure match documented pattern?
2. What's the dependency flow? (analyze imports)
3. Are there clear layers/boundaries?
4. What's colocated? What's separated?
5. Is it FSD, Feature-First, Package by Feature, MVC, or custom?

**Use Grep to analyze imports**:

```bash
# TypeScript/JavaScript
# Look for import patterns to understand dependencies

# Python
# Analyze import and from...import statements

# Go
# Check package imports
```

**Findings to document**:
- Actual architectural pattern used
- Import conventions (absolute vs relative)
- Module boundaries
- Feature organization

**Example mismatch**:
- Documented: "Feature-Sliced Design"
- Actual: Feature-First with colocation
- Action: Update architecture section

### Step 5: Detect Testing Patterns

**If tests exist**, analyze:

```bash
# Find test files
# Common patterns: *.test.*, *.spec.*, *_test.*, test_*.*
```

**Extract**:
- Test file naming convention
- Test location (colocated vs separate `__tests__/` folder)
- Testing framework used (Jest, Vitest, pytest, etc.)
- Test structure patterns (Arrange-Act-Assert, Given-When-Then)
- Coverage approach

**Example findings**:
- Framework: Jest + React Testing Library
- Location: Colocated with source
- Naming: *.test.tsx pattern
- Coverage: ~60% of components tested

### Step 6: Identify API/Component Patterns

**Backend projects** - Look for API patterns:
- RESTful conventions
- Error response format
- Validation patterns
- Authentication patterns
- Endpoint naming

**Frontend projects** - Look for component patterns:
- Component composition style
- State management approach
- Props patterns
- Hook patterns (if React)
- Component file structure

### Step 7: Think Through Findings

Before suggesting changes, think step-by-step:

**1. Stable vs emerging patterns?**
- **Stable**: >80% consistency, used across codebase → document
- **Emerging**: Growing but not dominant yet → note but don't enforce
- **Outliers**: <20% → don't document

**2. Implicit vs explicit?**
- **Implicit**: Everyone follows but not written → make explicit
- **Explicit**: Already documented → verify accuracy
- Focus on making implicit conventions explicit

**3. Single file vs modular?**
- **Single file**: If findings fit in ~50 lines of additions
- **Modular**: If findings need >100 lines or multiple topics
- Consider project size (>10k lines → suggest modular)

**4. What to document vs leave implicit?**
- **Document**: Non-obvious, easy to violate, critical for consistency
- **Leave implicit**: Obvious, framework-enforced, self-evident

### Step 8: Show Findings to User

Present findings before suggesting changes:

```markdown
## Codebase Analysis Results

**Current setup**: [Single file / Modular / None]
**Project size**: ~[X]k lines across [Y] files

### Naming Conventions Detected
- **Files**: PascalCase for components (95%), kebab-case for utilities (90%)
- **Functions**: camelCase (98% consistency)
- **Components**: PascalCase with descriptive names
- **Booleans**: is/has prefixes (85% consistent)

### Architecture Patterns
- **Actual pattern**: Feature-First with colocation
- **Documented pattern**: FSD (MISMATCH DETECTED!)
- **Import style**: Absolute imports via @ alias (98%)
- **Module organization**: Features are self-contained

### Testing Conventions
- **Framework**: Jest + React Testing Library
- **Location**: Colocated with source files
- **Naming**: *.test.tsx pattern
- **Coverage**: ~60% of components have tests

### API/Component Patterns
- **Component style**: Composition over inheritance
- **State**: Zustand for global, local state in components
- **Props**: TypeScript interfaces, destructured

### Recommendations
Based on these findings, I suggest:
[Specific recommendations]

Does this analysis look correct? Any patterns I missed?
```

Wait for user confirmation.

### Step 9: Ask User About Approach

**Use AskUserQuestion tool**:

```json
{
  "questions": [
    {
      "question": "How should I update your documentation?",
      "header": "Approach",
      "multiSelect": false,
      "options": [
        {
          "label": "Update CLAUDE.md with findings (keep single file)",
          "description": "Add detected patterns to existing CLAUDE.md. Good if additions are small (<50 lines)."
        },
        {
          "label": "Create modular .claude/rules/ structure",
          "description": "Keep CLAUDE.md minimal, create .claude/rules/ with focused files. Recommended if many findings or large project."
        },
        {
          "label": "Show me the changes first, I'll decide",
          "description": "Generate both options and let me choose after seeing previews."
        }
      ]
    },
    {
      "question": "Which patterns should I document?",
      "header": "Scope",
      "multiSelect": true,
      "options": [
        {
          "label": "Naming conventions",
          "description": "File, function, variable, component naming patterns detected."
        },
        {
          "label": "Architecture corrections",
          "description": "Update architecture section to match actual code structure."
        },
        {
          "label": "Testing standards",
          "description": "Document testing framework, patterns, and conventions."
        },
        {
          "label": "Import/module patterns",
          "description": "Document import style, path aliases, module organization."
        }
      ]
    }
  ]
}
```

### Step 10: Generate Updates

Based on user's choice:

#### Option A: Update CLAUDE.md (Single File)

1. **Read existing CLAUDE.md**
2. **Identify sections to update**:
   - Naming Conventions → add detected patterns
   - Architecture → correct mismatches
   - Add new sections if needed (Testing, Import Order)

3. **Show preview** with diff-style format:

```markdown
I'll update CLAUDE.md by:

### In "Naming Conventions" section (line ~45):
+ **Components**: PascalCase with descriptive names (e.g., UserProfileCard, not Card)
+ **Utility files**: kebab-case (e.g., date-utils.ts, not dateUtils.ts)
+ **Booleans**: Always use is/has/can/should prefix (detected in 85% of codebase)

### In "Architecture" section (line ~78):
- Current says: "Feature-Sliced Design"
+ Update to: "Feature-First with colocation"
+ Add explanation: "Features are self-contained with components, hooks, and tests colocated."

### New "Testing" section (after line ~120):
+ ## Testing
+ - **Framework**: Jest + React Testing Library
+ - **Location**: Colocated (*.test.tsx next to source)
+ - **Coverage**: Aim for >70% on business logic
+ - **Pattern**: Arrange-Act-Assert

Approve these changes?
```

4. **After approval**, use Edit tool to update CLAUDE.md

#### Option B: Create Modular Rules

If .claude/rules/ doesn't exist, create it.

**Generate focused rule files**:

1. **coding-standards.md**:
   - Naming conventions detected
   - Import order observed
   - Quality patterns used
   - Path: `src/**/*.{ts,tsx}`

2. **testing.md** (if tests exist):
   - Framework and conventions
   - Location and naming patterns
   - Coverage expectations
   - Path: `**/*.{test,spec}.*`

3. **architecture.md**:
   - Detected pattern explanation
   - Actual folder structure
   - Guidelines from import analysis
   - No path (global)

See `references/modular-organization.md` for templates.

**Show preview of all files** before creating.

#### Option C: Update Existing Rules

If .claude/rules/ already exists:

1. Read each rule file
2. Identify outdated information
3. Show diff-style preview
4. Get confirmation
5. Update files

### Step 11: Write Files

Only after user confirmation:

- **Single file**: Use Edit tool to update CLAUDE.md
- **Modular**: Use Write tool to create/update .claude/rules/*.md files

### Step 12: Inform User

```markdown
✅ Documentation updated with codebase patterns

📋 Changes made:
- [List updates/additions]

🎯 Detected patterns:
- [X] naming conventions documented
- [X] architecture updated to match code
- [X] testing standards added
- [X] import patterns documented

💡 Recommendations:
1. Review changes and adjust if needed
2. Run sync periodically (monthly) to catch drift
3. Consider path-specific rules for different codebase sections

📝 Files modified:
- [List of files changed]
```

## Pattern Detection Thresholds

| Consistency | Action |
|------------|--------|
| >80% | Document as standard convention |
| 60-80% | Note as emerging pattern |
| 40-60% | Mixed usage, don't document |
| <40% | Outlier, ignore |

## Best Practices

1. ✅ **Detect, don't dictate** - Document what exists, don't impose new patterns
2. ✅ **Stable patterns only** - Only document patterns with >80% consistency
3. ✅ **No dynamic data** - Never include counts, dates, or timestamps
4. ✅ **Show before changing** - Always preview changes before writing
5. ✅ **Respect setup** - Don't force modular if user prefers single file
6. ✅ **Think critically** - Not everything needs documentation
7. ✅ **Be specific** - "PascalCase for components" not "use good names"

## Anti-Patterns

- ❌ Suggesting patterns that don't exist in code
- ❌ Documenting framework conventions (already known)
- ❌ Including line counts or file statistics
- ❌ Forcing modular structure on small projects
- ❌ Changing documentation without user approval
- ❌ Over-documenting obvious patterns
- ❌ Suggesting refactoring (this skill documents, not refactors)

## Common Findings

### Naming Mismatches

**Example**: Documented says kebab-case for components, but code uses PascalCase
**Action**: Update documentation to match PascalCase

### Architecture Drift

**Example**: Documented says FSD, but actual code is Feature-First
**Action**: Update architecture section with correct pattern

### Missing Testing Standards

**Example**: Tests exist but no testing section in CLAUDE.md
**Action**: Add testing section with detected conventions

### Import Inconsistencies

**Example**: Mix of absolute and relative imports
**Action**: Document dominant pattern (>80%), note drift if needed
