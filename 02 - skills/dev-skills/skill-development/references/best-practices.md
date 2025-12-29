# Best Practices: Validation, Optimization, and Common Mistakes

This reference consolidates validation rules, common mistakes to avoid, and optimization techniques for creating effective skills.

## Complete Validation Checklist

Use this checklist before finalizing any skill.

### Structure Validation

- [ ] SKILL.md file exists with uppercase filename
- [ ] SKILL.md is in correct directory: `skills/skill-name/SKILL.md`
- [ ] Directory name matches frontmatter `name` field
- [ ] Frontmatter has valid YAML syntax
- [ ] Referenced files actually exist (references/, examples/, scripts/)
- [ ] Only necessary subdirectories created (delete empty ones)

### Frontmatter Validation

- [ ] Opening `---` on line 1
- [ ] Closing `---` before markdown content
- [ ] No tabs in YAML (use spaces only)
- [ ] `name` field present and valid
- [ ] `description` field present and valid
- [ ] `allowed-tools` valid if present (comma-separated)
- [ ] `version` field present if tracking versions

**Name field requirements:**
- Lowercase letters, numbers, hyphens only
- Max 64 characters
- No underscores, spaces, or special characters
- Preferably gerund form (verb+ing): `analyzing-code`, `writing-docs`
- Specific, not generic: `processing-pdfs` not `document-helper`

**Description field requirements:**
- Max 1024 characters
- Third person: "This skill should be used when..."
- NOT first person: "I help you..."
- NOT second person: "You should use this..."
- NOT imperative: "Use this skill when..."
- Include BOTH what it does AND when to use it
- Specific trigger words users would say
- Mention file types, operations, domains

### Content Validation

- [ ] SKILL.md body under 500 lines (ideally 300-400)
- [ ] All instructions in imperative/infinitive form
- [ ] NO second person ("you should", "you need")
- [ ] Clear step-by-step instructions
- [ ] Concrete examples provided
- [ ] Code blocks have language specifiers
- [ ] Forward slashes in paths (not backslashes)
- [ ] Proper heading hierarchy (# → ## → ###)
- [ ] No unnecessary explanations of basics
- [ ] Supporting files clearly referenced

### Progressive Disclosure Validation

- [ ] Core concepts in SKILL.md
- [ ] Detailed content in references/
- [ ] Working examples in examples/
- [ ] Utility scripts in scripts/
- [ ] SKILL.md references supporting files
- [ ] No deeply nested references (keep one level)
- [ ] References have clear descriptions

### Testing Validation

- [ ] Skill activates on expected trigger phrases
- [ ] Content is helpful for intended tasks
- [ ] No duplicated information across files
- [ ] References load when Claude determines needed
- [ ] Instructions are clear and actionable
- [ ] Examples are complete and correct

## Common Mistakes and How to Fix Them

### Mistake 1: Weak Trigger Description

❌ **Bad:**
```yaml
description: Provides guidance for working with hooks.
```

**Why bad:** Vague, no specific trigger phrases, not third person, missing "when"

✅ **Good:**
```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", or mentions hook events (PreToolUse, PostToolUse, Stop). Provides comprehensive hooks API guidance.
```

**Why good:** Third person, specific phrases, concrete scenarios, includes "when"

**How to fix:**
1. Add "This skill should be used when the user asks to..." prefix
2. Include 3-5 specific trigger phrases in quotes
3. Mention file types, operations, or domains
4. Add brief explanation of what it provides

### Mistake 2: Too Much in SKILL.md

❌ **Bad:**
```
skill-name/
└── SKILL.md  (650 lines - everything in one file)
```

**Why bad:** Bloats context when skill loads, exceeds 500 line limit

✅ **Good:**
```
skill-name/
├── SKILL.md  (350 lines - core essentials)
└── references/
    ├── patterns.md (150 lines - common patterns)
    └── advanced.md (200 lines - advanced techniques)
```

**Why good:** Progressive disclosure, detailed content loaded only when needed

**How to fix:**
1. Identify content that can be extracted:
   - Detailed patterns → references/patterns.md
   - Advanced techniques → references/advanced.md
   - Comprehensive examples → examples/
   - Utility scripts → scripts/
2. Create supporting files
3. Update SKILL.md with clear references
4. Verify SKILL.md under 500 lines (ideally 300-400)

### Mistake 3: Second Person Writing

❌ **Bad:**
```markdown
You should start by reading the configuration file.
You need to validate the input before processing.
You can use the grep tool to search for patterns.
```

**Why bad:** Second person, not imperative form, wrong voice for AI instructions

✅ **Good:**
```markdown
Start by reading the configuration file.
Validate the input before processing.
Use the grep tool to search for patterns.
```

**Why good:** Imperative form, direct instructions, proper voice for AI

**How to fix:**
1. Search for "you should", "you need", "you can", "you must"
2. Remove "you" and start with verb
3. Use imperative form: "Do X" not "You should do X"
4. Rewrite in objective, instructional language

### Mistake 4: Missing Resource References

❌ **Bad:**
```markdown
# SKILL.md

[Core content]

[No mention of references/ or examples/]
```

**Why bad:** Claude doesn't know references exist, can't access additional resources

✅ **Good:**
```markdown
# SKILL.md

[Core content]

## Additional Resources

### Reference Files
- **`references/patterns.md`** - Detailed patterns (20+ proven patterns)
- **`references/advanced.md`** - Advanced techniques and edge cases

### Examples
- **`examples/basic-example.sh`** - Simple working example
- **`examples/complete-workflow.sh`** - Multi-step workflow
```

**Why good:** Claude knows where to find additional information, can load as needed

**How to fix:**
1. Add "Additional Resources" section at end of SKILL.md
2. List all references/ files with descriptions
3. List all examples/ files with descriptions
4. List all scripts/ files with descriptions
5. Use consistent format: `**filename**` - description

### Mistake 5: Vague Naming

❌ **Bad names:**
```yaml
name: helper
name: utils
name: tools
name: code-processor
name: data-handler
```

**Why bad:** Too generic, doesn't indicate specific purpose

✅ **Good names:**
```yaml
name: analyzing-spreadsheets
name: reviewing-pull-requests
name: generating-commit-messages
name: validating-api-schemas
name: extracting-pdf-text
```

**Why good:** Specific, indicates action and target, uses gerund form

**How to fix:**
1. Use formula: `[action-gerund]-[specific-target]`
2. Be specific: `processing-pdfs` not `document-processor`
3. Use gerund form (verb+ing)
4. Lowercase with hyphens only
5. Max 64 characters

### Mistake 6: No Examples

❌ **Bad:**
```markdown
## Instructions

1. Process the data
2. Generate the report
3. Validate the output
```

**Why bad:** Too abstract, no concrete examples

✅ **Good:**
```markdown
## Instructions

1. Process the data:
\`\`\`python
import pandas as pd
df = pd.read_csv("data.csv")
df_processed = df.dropna()
\`\`\`

2. Generate the report:
\`\`\`python
report = df_processed.describe()
report.to_html("report.html")
\`\`\`

3. Validate the output:
\`\`\`bash
python scripts/validate.py report.html
\`\`\`
```

**Why good:** Concrete code examples, specific commands, actionable

**How to fix:**
1. Add code examples for each major step
2. Use real-world examples, not toy examples
3. Show complete code, not pseudocode
4. Include expected outputs
5. Add edge case examples if common

## Writing Style Guidelines

### Imperative/Infinitive Form

Write using verb-first instructions, not second person:

**Correct (imperative):**
```
To create a hook, define the event type.
Configure the MCP server with authentication.
Validate settings before use.
Run the validation script.
```

**Incorrect (second person):**
```
You should create a hook by defining the event type.
You need to configure the MCP server.
You must validate settings before use.
You can run the validation script.
```

### Third-Person in Description

The frontmatter description must use third person:

**Correct:**
```yaml
description: This skill should be used when the user asks to "create X", "configure Y"...
```

**Incorrect:**
```yaml
description: Use this skill when you want to create X...
description: I help you create X...
description: Load this skill when user asks...
```

### Objective, Instructional Language

Focus on what to do, not who should do it:

**Correct:**
```
Parse the frontmatter using sed.
Extract fields with grep.
Validate values before use.
```

**Incorrect:**
```
You can parse the frontmatter...
Claude should extract fields...
The user might validate values...
```

## Token Budget Optimization

### Progressive Disclosure Strategy

**Level 1: Metadata (always loaded)**
- ~100 words
- Name + description
- Critical for discovery

**Level 2: SKILL.md body (loaded when triggered)**
- <5k words (ideally 1,500-2,000 words)
- 300-400 lines ideal
- Core concepts and workflows only

**Level 3: Supporting files (loaded as needed)**
- Unlimited
- Detailed patterns, examples, scripts
- Claude loads when determined necessary

### What Goes Where

**SKILL.md (always loaded when triggered):**
- ✅ Overview and purpose
- ✅ Essential procedures
- ✅ Quick reference tables
- ✅ Pointers to resources
- ✅ Most common use cases
- ❌ Detailed patterns (move to references/)
- ❌ Comprehensive examples (move to examples/)
- ❌ Edge cases (move to references/)

**references/ (loaded as needed):**
- ✅ Detailed patterns
- ✅ Advanced techniques
- ✅ Migration guides
- ✅ Edge cases
- ✅ Comprehensive documentation
- ❌ Core concepts (keep in SKILL.md)
- ❌ Basic workflows (keep in SKILL.md)

**examples/ (loaded as needed):**
- ✅ Complete working scripts
- ✅ Configuration templates
- ✅ Real-world usage examples
- ✅ Before/after comparisons
- ❌ Inline code snippets (keep in SKILL.md)
- ❌ Basic syntax examples (keep in SKILL.md)

**scripts/ (executed, not loaded):**
- ✅ Validation utilities
- ✅ Testing helpers
- ✅ Automation tools
- ✅ Parsing scripts
- ❌ Documentation (put in references/)
- ❌ Examples (put in examples/)

### Token Reduction Techniques

**1. Remove redundancy:**
```markdown
# Bad (redundant)
PDF files are a common file format. To work with PDF files, you need to
use a PDF library. There are many PDF libraries available. We recommend
using pdfplumber for PDF text extraction.

# Good (concise)
Use pdfplumber for PDF text extraction:
\`\`\`python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
\`\`\`
```

**2. Skip common knowledge:**
```markdown
# Bad (explaining basics)
Git is a version control system that tracks changes to files. To use git,
you need to initialize a repository. A repository is where git stores all
the version history...

# Good (assumes knowledge)
Initialize git repository:
\`\`\`bash
git init
git add .
git commit -m "Initial commit"
\`\`\`
```

**3. Use tables for reference:**
```markdown
# Bad (verbose)
The PreToolUse event executes before any tool runs. You can use it to
approve, deny, or modify tool calls. The PostToolUse event executes after
a tool completes. You can use it to react to results...

# Good (concise table)
| Event | When | Use For |
|-------|------|---------|
| PreToolUse | Before tool | Validation, modification |
| PostToolUse | After tool | Feedback, logging |
```

**4. Extract to references:**
```markdown
# SKILL.md (lean)
For common patterns, see references/patterns.md.
For advanced techniques, see references/advanced.md.

# references/patterns.md (detailed)
[15+ detailed patterns with full code examples]

# references/advanced.md (detailed)
[Advanced techniques, edge cases, troubleshooting]
```

## Performance Best Practices

### Skill Discovery Optimization

**Strong descriptions trigger reliably:**

```yaml
# Weak (may not trigger)
description: Helps with APIs

# Strong (triggers reliably)
description: This skill should be used when the user asks to "design API", "create REST endpoint", "plan API architecture", "document API", or works with API specifications. Designs REST APIs following best practices.
```

**Include multiple trigger types:**
- File types: .pdf, .xlsx, .json
- Action verbs: analyze, extract, generate
- Domain terms: API, database, authentication
- User phrases: "review code", "fix issue"

### Load Time Optimization

**Keep SKILL.md lean:**
- Target: 300-400 lines
- Maximum: 500 lines
- Use references/ for detailed content

**One-level references:**
```markdown
# Good (one level)
See references/patterns.md for details.

# Bad (nested, adds lookup time)
See references/index.md → which links to → references/patterns.md
```

### Context Efficiency

**Avoid duplication:**
```markdown
# Bad (same info in multiple places)
# SKILL.md
[Pattern explanation]

# references/patterns.md
[Same pattern explanation repeated]

# Good (single source of truth)
# SKILL.md
For common patterns, see references/patterns.md.

# references/patterns.md
[Detailed pattern explanation - only here]
```

## Advanced Patterns

### Configuration-Driven Skills

Allow users to customize behavior via configuration:

```markdown
## Configuration

Create `.claude/skill-config.json`:
\`\`\`json
{
  "strictMode": true,
  "maxFileSize": 500000,
  "allowedExtensions": [".ts", ".tsx"]
}
\`\`\`

Scripts in scripts/ read this configuration to customize validation.
```

### Conditional Workflows

Provide different workflows for different scenarios:

```markdown
## Instructions

**For new projects:**
1. Initialize structure
2. Set up configuration
3. Create boilerplate

**For existing projects:**
1. Analyze current structure
2. Suggest improvements
3. Migrate incrementally
```

### Tool-Restricted Skills

Use `allowed-tools` for read-only or limited-scope skills:

```yaml
---
name: analyzing-codebase
description: This skill should be used when the user asks to "analyze codebase", "review architecture", "understand code structure", or works with code analysis. Analyzes code without making changes.
allowed-tools: Read, Grep, Glob
---
```

### Multi-Language Skills

Support multiple languages or frameworks:

```markdown
## Language Detection

Detect project language:
\`\`\`bash
# Check for package.json (Node.js)
# Check for Cargo.toml (Rust)
# Check for requirements.txt (Python)
\`\`\`

Apply language-specific patterns from references/[language]-patterns.md.
```

## Testing and Validation

### Manual Testing

**Test trigger activation:**
1. Restart Claude Code
2. Try trigger phrases from description
3. Verify skill activates automatically
4. Check Claude follows instructions

**Test progressive disclosure:**
1. Trigger skill
2. Verify SKILL.md loads
3. Check if Claude loads references when needed
4. Confirm examples accessible

### Debug Mode

```bash
claude --debug
```

Look for:
- Skill registration at startup
- Skill activation on triggers
- File loading (SKILL.md, references/)
- Errors or warnings

### Common Test Cases

**Test edge cases:**
- Empty input
- Missing files
- Invalid configuration
- Large datasets
- Multiple concurrent operations

**Test documentation:**
- All references/ files load correctly
- All examples/ scripts execute
- All scripts/ utilities work
- Links are not broken

## Skill Maintenance

### Versioning

Add version to frontmatter:
```yaml
---
name: skill-name
description: ...
version: 1.2.0
---
```

### Change Log

Document significant changes in SKILL.md:
```markdown
## Version History

### 1.2.0
- Added support for TypeScript 5.0
- Improved error handling in validation
- Added references/migration-guide.md

### 1.1.0
- Split into references/ for progressive disclosure
- Added examples/advanced-workflow.sh
```

### Deprecation

When deprecating features:
```markdown
<details>
<summary>Legacy Pattern (deprecated)</summary>

This pattern is deprecated. Use the new pattern in references/patterns.md instead.

[Old pattern kept for reference]
</details>
```

### Migration Guides

Create references/migration.md for breaking changes:
```markdown
# Migration Guide

## Upgrading from 1.x to 2.0

### Breaking Changes
- Configuration format changed from JSON to YAML
- `process()` function renamed to `analyze()`

### Migration Steps
1. Convert config.json to config.yaml
2. Update function calls: `process()` → `analyze()`
3. Test with `scripts/validate.sh`
```

## Quick Reference

### DO

- ✅ Use third-person in description
- ✅ Include specific trigger phrases
- ✅ Keep SKILL.md under 500 lines (aim for 300-400)
- ✅ Use progressive disclosure
- ✅ Write in imperative form
- ✅ Reference supporting files clearly
- ✅ Provide working examples
- ✅ Use gerund naming
- ✅ Test thoroughly
- ✅ Validate before finalizing

### DON'T

- ❌ Use second person ("you should")
- ❌ Have vague triggers
- ❌ Put everything in SKILL.md
- ❌ Leave resources unreferenced
- ❌ Include broken examples
- ❌ Skip validation
- ❌ Use generic names
- ❌ Duplicate information
- ❌ Nest references deeply
- ❌ Explain common knowledge

## Validation Tools

### YAML Validation

```bash
# Check YAML syntax
cat SKILL.md | head -n 10 | yaml-validator

# Or use Python
python -c "import yaml; yaml.safe_load(open('SKILL.md').read().split('---')[1])"
```

### Line Count Check

```bash
wc -l SKILL.md
# Should be < 500, ideally 300-400
```

### Trigger Word Analysis

Check description has:
- "This skill should be used when"
- At least 3 specific trigger phrases in quotes
- File types or domain terms
- Action verbs

### Link Validation

```bash
# Check all referenced files exist
grep -o 'references/[^)]*\.md' SKILL.md | while read f; do
  test -f "$f" && echo "✓ $f" || echo "✗ $f MISSING"
done
```

This comprehensive best practices guide ensures skills are well-structured, performant, discoverable, and maintainable.
