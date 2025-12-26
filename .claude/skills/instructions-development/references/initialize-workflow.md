# Initialize Workflow - Detailed Guide

Complete process for creating new CLAUDE.md from scratch.

## Overview

Initialize workflow creates opinionated baseline CLAUDE.md for projects without documentation. Provides quick setup with industry best practices.

**When to use**: New projects or codebases without existing CLAUDE.md

## Step-by-Step Process

### Step 1: Detect Stack or Ask

**If code exists**, detect stack automatically:

```bash
# Check for package.json (Node.js/TypeScript)
cat package.json 2>/dev/null

# Check for requirements.txt (Python)
cat requirements.txt 2>/dev/null | head -5

# Check for go.mod (Go)
cat go.mod 2>/dev/null | head -3

# Check for pom.xml/build.gradle (Java)
cat pom.xml 2>/dev/null | head -5
cat build.gradle 2>/dev/null | head -5
```

**If no code exists**, ask user about planned stack.

### Step 2: Ask User Preferences

Use AskUserQuestion tool to gather preferences:

```json
{
  "questions": [
    {
      "question": "How do you want to organize documentation?",
      "header": "Approach",
      "multiSelect": false,
      "options": [
        {
          "label": "Single file (CLAUDE.md only) - Recommended for small projects",
          "description": "Everything in one file (~200-250 lines). Simpler. Good for projects under 10k lines."
        },
        {
          "label": "Modular (CLAUDE.md + .claude/rules/) - Recommended for large projects",
          "description": "Core in CLAUDE.md (~100-150 lines), details in .claude/rules/. Better for complex projects."
        }
      ]
    },
    {
      "question": "Which architecture pattern fits your project?",
      "header": "Architecture",
      "multiSelect": false,
      "options": [
        {
          "label": "Feature-Sliced Design (Recommended for React/Vue SPAs)",
          "description": "Strict layered architecture. Best for React/Vue/Next.js. Prevents spaghetti code."
        },
        {
          "label": "Feature-First (Recommended for APIs/backends)",
          "description": "Organize by product features. Simpler than FSD. Good for Express, Flask, FastAPI."
        },
        {
          "label": "Package by Feature (Simple, for Go/Java/C#)",
          "description": "Group by business domain. Simple vertical slicing. Best for Go, Spring Boot, .NET."
        },
        {
          "label": "MVC (Framework convention)",
          "description": "Traditional layered architecture. Use for Django, Rails, or framework-enforced patterns."
        }
      ]
    }
  ]
}
```

### Step 3: Think Through Design

Before generating, think step-by-step:

**1. Minimum viable CLAUDE.md?**
- Focus on essentials: overview, core standards, architecture, git
- Avoid over-engineering
- Each section must be immediately useful
- Challenge: "Will Claude need this now?"

**2. Similar projects/patterns?**
- Research stack best practices
- Check framework official recommendations
- Consider ecosystem conventions

**3. Architectural trade-offs?**
- Why this pattern over alternatives?
- What problems does it solve?
- When should it NOT be used?

**4. Common pitfalls in this stack?**
- What mistakes do developers make?
- What should Core Standards prevent?
- What conventions are often violated?

### Step 4: Preview Content

Show detailed preview with estimated line count:

```markdown
I'll generate CLAUDE.md with this structure:

# [Project Name]
> Baseline CLAUDE.md - Customize as project evolves

## Tech Stack
- **Language**: [language]
- **Framework**: [framework]
- **Architecture**: [selected pattern]

## Core Standards
### Before ANY Task
[5-point checklist]

### Verify Before Referencing (CRITICAL)
[Detailed verification rules]

### [Language] Rules
- **NEVER use `any` type** (TypeScript)
[Language-specific critical rules]

## Architecture: [Pattern Name]
[Why this pattern, key principles]

[If Single File approach:]
## Coding Standards
[Naming, import order, quality]

## Git Conventions
[Conventional Commits format]

---

**Estimated length**: ~[X] lines
**Language**: English
**Architecture**: [Pattern] because [reasoning]

Does this work? Any sections to add/remove?
```

Wait for explicit confirmation.

### Step 5: Generate Content

**Template structure** (all in English):

#### Core Sections (Always Include)

1. **Project Header**
   - Project name
   - Brief tagline
   - Baseline notice

2. **Tech Stack**
   - Language
   - Framework/library
   - Architecture pattern
   - Key tools

3. **Core Standards**
   - Before ANY Task (5-point checklist)
   - Verify Before Referencing (detailed)
   - Language-specific critical rules (no `any`, etc.)

4. **Architecture**
   - Pattern name
   - Why chosen
   - Key principles (3-5 enduring principles, not specific paths)

5. **Git Conventions**
   - Conventional Commits format
   - Types, rules, example

#### Conditional Sections (Based on Approach)

**If Single File**:
- Coding Standards (naming, imports, quality)
- Testing (if tests exist)
- API Conventions (if backend)

**If Modular**:
- Note about .claude/rules/ structure
- References to rule files
- Suggest running organize workflow next

### Step 6: Write File

Only after user confirmation:

```bash
# Use Write tool (not bash)
# Content in English, ~150-250 lines (single) or ~100-150 (modular)
```

### Step 7: Inform User

```markdown
✅ CLAUDE.md created successfully

📋 Included:
- Core Standards (verify-before-referencing, no any)
- Architecture: [Pattern]
- [Other sections based on scope]
- Git Conventions (Conventional Commits)

💡 Next Steps:
[If Single File]
1. Review and customize CLAUDE.md as needed
2. For existing code: Use sync operation to extract real patterns

[If Modular]
1. Review CLAUDE.md
2. Run organize operation to create .claude/rules/ structure
3. For existing code: Use sync to extract patterns

📝 Language: English (industry standard)
🎯 Focus: [Concise overview / Modular with rules]
```

## Architecture Selection Guide

### Recommendation Matrix

| Stack | Default Pattern | Alternatives |
|-------|----------------|--------------|
| React/Vue SPA | FSD | Feature-First |
| Next.js | FSD | Feature-First |
| Express/Fastify | Feature-First | Package by Feature |
| NestJS | Feature-First | Modular Monolith |
| Django/Flask | MVC | Feature-First |
| Rails | MVC | - |
| Spring Boot | Package by Feature | DDD |
| Go API | Package by Feature | Feature-First |

### Pattern Templates

See `references/architecture-patterns.md` for complete templates.

## Content Guidelines

### What to Include

✅ **Timeless patterns and principles**
- Architectural principles that endure
- Language-specific critical rules
- Non-negotiable standards
- Git conventions

✅ **Concrete, actionable rules**
- "NEVER use `any` type"
- "Validate task before starting"
- "Use Conventional Commits"

### What to Exclude

❌ **Dynamic data**
- Line counts, file counts
- "Analyzed X files"
- Dates, timestamps
- "Current status"

❌ **Concrete folder structures**
- Specific file paths change
- List principles instead
- "Dependency flow is unidirectional" (good)
- "`src/components/Button.tsx`" (bad)

❌ **Next steps sections**
- Becomes outdated immediately
- Belongs in completion message, not file

## Common Mistakes

### Over-Engineering

❌ **Bad**: 500+ line CLAUDE.md with every possible section
```markdown
Too detailed for initial setup
```

✅ **Good**: Focused ~200 lines with essentials
```markdown
Room to grow, not overwhelming
```

### Mixing Languages

❌ **Bad**: CLAUDE.md in Portuguese with English code examples
```markdown
Confuses AI, reduces portability
```

✅ **Good**: 100% English
```markdown
Industry standard, AI-friendly
```

### Dynamic Content

❌ **Bad**: "Analyzed 150 files, found 3 patterns, created on 2024-01-15"
```markdown
Outdated immediately
```

✅ **Good**: "Use Feature-First pattern for vertical slicing"
```markdown
Timeless, stable
```

### Skipping Confirmation

❌ **Bad**: Generate and write immediately
```markdown
No user input, might not match expectations
```

✅ **Good**: Show preview, get confirmation
```markdown
User approves before file creation
```

## Best Practices

1. ✅ **Ask questions first** - Understand user needs
2. ✅ **Show preview** - Detailed structure with reasoning
3. ✅ **English only** - 100% English content
4. ✅ **No dynamic data** - Only stable patterns
5. ✅ **Opinionated defaults** - But let user choose
6. ✅ **Explain choices** - Why this architecture/approach?
7. ✅ **Keep concise** - 150-250 lines (single) or 100-150 (modular)
8. ✅ **Non-negotiables included** - Core standards + Git always
9. ✅ **Think step-by-step** - Before generating
10. ✅ **Room to grow** - Don't over-document initially
