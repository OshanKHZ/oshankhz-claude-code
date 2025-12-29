# Editing Skills: Detailed Process

This reference provides the complete skill editing process with refactoring patterns, validation, and optimization techniques.

## Step-by-Step Editing Process

### Step 1: Read and Analyze Current Skill

**The user already said which skill to edit.** Read the SKILL.md and analyze:

**Extract key information:**
- Frontmatter (name, description, allowed-tools if present)
- Main sections (Quick start, Instructions, Examples, etc.)
- Line count (must stay under 500, ideally 300-400)
- Supporting files (references/, examples/, scripts/)

### Step 2: Determine Edit Type

**Ask what to adjust** using `AskUserQuestion`:

```json
{
  "questions": [
    {
      "question": "O que quer ajustar na skill?",
      "header": "Tipo de edição",
      "multiSelect": true,
      "options": [
        {
          "label": "Description/triggers",
          "description": "Melhorar ativação da skill"
        },
        {
          "label": "Instruções",
          "description": "Ajustar o workflow principal"
        },
        {
          "label": "Adicionar conteúdo",
          "description": "Novos examples, references, scripts"
        },
        {
          "label": "Refatorar",
          "description": "Skill grande demais, reorganizar"
        }
      ]
    }
  ]
}
```

**Note:** multiSelect=true because user may want multiple adjustments at once.

### Step 3: Edit Based on Type

#### Edit Type: Description

**Current description validation:**
- Check if under 1024 chars
- Verify third person voice ("This skill should be used when...")
- Check for specific trigger words
- Ensure it mentions what AND when

**Ask for improvements:**
```
Current description:
"[current description]"

Issues found (if any):
- [ ] Too vague (missing specific triggers)
- [ ] Wrong person (first/second instead of third)
- [ ] Too long (>1024 chars)
- [ ] Missing file types or operations
- [ ] Missing "when to use" clause

What should the new description be? Or should I suggest improvements?
```

**If user asks for suggestions:**

Analyze current description and propose:
- Add specific trigger words (file types, verbs, domain terms)
- Convert to third person if needed
- Add "This skill should be used when..." clause if missing
- Make more specific and concrete

**Example improvement:**

```yaml
# Before (vague)
description: Helps with code review

# After (specific, third person, triggers)
description: This skill should be used when the user asks to "review code", "check code quality", "analyze pull request", or works with TypeScript/JavaScript files. Reviews code for best practices, security issues, and performance.
```

#### Edit Type: Instructions

**Show current structure:**
```
Current instruction sections:
1. [Section 1 name] - [brief summary]
2. [Section 2 name] - [brief summary]
...

What changes do you want to make?
- Modify existing section
- Add new step
- Remove step
- Reorder steps
- Clarify ambiguous instructions
```

**Make changes:**
- Use Edit tool to update specific sections
- Maintain step-by-step clarity
- Keep instructions concise (challenge: "Does Claude really need this?")
- Preserve formatting and structure
- Use imperative form (NOT "you should...")

**Example clarification:**

```markdown
# Before (ambiguous)
Process the files and handle errors appropriately.

# After (clear, imperative form)
1. Use Glob to find all .ts files: `**/*.ts`
2. For each file:
   - Read file content
   - If file is empty, skip to next
   - Parse TypeScript AST
   - If parse fails, log error and continue
3. Report summary of processed files
```

#### Edit Type: Add New Section

**Suggest common sections** if user is unsure:
```
Common sections to add:
- **Quick start**: Simple example to get started immediately
- **Examples**: Concrete usage examples with code
- **Best practices**: Key conventions and common pitfalls
- **Requirements**: Dependencies or prerequisites
- **Troubleshooting**: Common issues and solutions
- **Advanced usage**: Reference to additional files

Which section would you like to add?
```

**When adding section:**
1. Read current file to understand structure
2. Determine best placement (logical flow)
3. Use Edit tool to insert new section
4. Verify line count stays under 500 (ideally 300-400)
5. If approaching limit, suggest moving content to references/

#### Edit Type: Refactor for Progressive Disclosure

**If approaching or exceeding limits:**
```
Current line count: X / 500 (Y%)

Refactoring options:
1. Extract detailed content to references/
2. Extract examples to examples/
3. Remove redundant explanations
4. Consolidate similar sections
5. Move advanced content to references/advanced.md

Recommended approach: [suggest best option based on content analysis]
```

**Refactoring process:**
1. Identify content that can be moved to reference files
2. Create supporting file (references/patterns.md, references/advanced.md, etc.)
3. Update SKILL.md with reference links
4. Verify main file is under 500 lines (ideally 300-400)
5. Ensure one-level deep references (no nested references)

**Example refactoring:**

**Before (500+ lines, everything in SKILL.md):**
```
skill-name/
└── SKILL.md  (520 lines)
```

**After (progressive disclosure):**
```
skill-name/
├── SKILL.md  (350 lines - core essentials)
└── references/
    ├── patterns.md (120 lines - common patterns)
    └── advanced.md (150 lines - advanced techniques)
```

**Update SKILL.md to reference:**
```markdown
## Common Patterns

For detailed patterns, see [references/patterns.md](references/patterns.md).

## Advanced Usage

For advanced techniques, see [references/advanced.md](references/advanced.md).
```

### Step 4: Validate Changes

**Run validation checklist:**

✅ **YAML frontmatter**:
- [ ] Opening `---` on line 1
- [ ] Closing `---` before content
- [ ] Valid YAML syntax (no tabs)
- [ ] `name` is lowercase, hyphens only, max 64 chars, gerund form
- [ ] `description` is third person, specific, <1024 chars
- [ ] `allowed-tools` valid if present (comma-separated)

✅ **Content quality**:
- [ ] Clear instructions for Claude in imperative form
- [ ] Concrete examples (if applicable)
- [ ] Under 500 lines (ideally 300-400)
- [ ] Supporting files referenced correctly (forward slashes)
- [ ] No deeply nested references
- [ ] No second person ("you should...")

✅ **Formatting**:
- [ ] Proper Markdown syntax
- [ ] Code blocks have language specifiers
- [ ] Consistent heading hierarchy

**If validation fails:**
- Report specific issues
- Offer to fix automatically
- Ask user for clarification if needed

### Step 5: Show Changes Summary

**Present diff-style summary:**
```
## Changes Made to [skill-name]

### Frontmatter
- Description: [old] → [new]
- [Other changes if any]

### Content
- Line count: X → Y (Z% change)
- Sections added: [list]
- Sections modified: [list]
- Sections removed: [list]

### Supporting Files
- Created: [list new files]
- Modified: [list modified files]

**Status:** ✅ All validations passed
```

### Step 6: Test Recommendations

**Suggest testing steps:**
```
To test the updated skill:

1. Restart Claude Code (if running) to reload the skill

2. Try these trigger phrases:
   - "[suggested phrase based on description]"
   - "[another trigger phrase]"

3. Verify the skill activates and follows new instructions

4. If skill doesn't activate:
   - Check description has specific trigger words
   - Verify YAML frontmatter is valid
   - Use `claude --debug` for detailed logs
```

## Common Edit Patterns

### Improve Skill Discovery

**Problem:** Skill doesn't activate when expected

**Solution:**
1. Read current description
2. Identify missing trigger words
3. Add specific file types, operations, or domain terms
4. Add "This skill should be used when..." clause with user phrases
5. Verify third person voice

**Example:**
```yaml
# Before (vague)
description: Helps with code review

# After (specific, third person, triggers)
description: This skill should be used when the user asks to "review code", "check TypeScript", "analyze pull request", or works with .ts/.js files. Reviews code for best practices, security issues, and performance.
```

### Split Large Skill

**Problem:** Skill approaching or exceeding 500 lines

**Solution:**
1. Identify content categories:
   - Detailed reference material → references/patterns.md or references/advanced.md
   - Extended examples → examples/
   - Scripts/utilities → scripts/
2. Create supporting files
3. Update SKILL.md with links
4. Keep core instructions in SKILL.md

**Example structure after split:**
```
skill-name/
├── SKILL.md (350 lines - core instructions)
├── references/
│   ├── patterns.md (120 lines - detailed patterns)
│   └── advanced.md (150 lines - advanced techniques)
└── examples/
    └── complete-example.sh (working example)
```

### Refactor Instructions for Clarity

**Problem:** Instructions are ambiguous or too complex

**Solution:**
1. Break into clear steps (Step 1, Step 2, etc.)
2. Use imperative voice ("Do X", not "You should do X")
3. Show concrete examples inline
4. Remove Claude's existing knowledge (don't explain basics)
5. Add decision points ("If X, then Y")

**Example:**
```markdown
# Before (ambiguous, second person)
You should process the files and make sure to handle errors appropriately.

# After (clear, imperative, specific)
1. Use Glob to find all .ts files: `**/*.ts`
2. For each file:
   - Read file content
   - If file is empty, skip to next
   - Parse TypeScript AST
   - If parse fails, log error and continue
3. Report summary: total files, successful, failed
```

### Update Allowed Tools

**Problem:** Skill needs tool restrictions or modifications

**Solution:**
1. Determine required tools for skill
2. Add or update `allowed-tools` in frontmatter
3. Common restrictions:
   - Read-only: `Read, Grep, Glob`
   - No file changes: `Read, Grep, Glob, Bash` (no Edit/Write)
   - Limited scope: Specify exact tools needed

**Example:**
```yaml
# Add tool restrictions for read-only skill
---
name: analyzing-code
description: This skill should be used when the user asks to "analyze code", "review codebase", or works with code analysis. Analyzes code patterns without making changes.
allowed-tools: Read, Grep, Glob
---
```

### Migrate Skill Location

**Problem:** Need to move skill between personal, project, or plugin

**Solution:**
1. Read current skill at source location
2. Create directory at destination
3. Copy SKILL.md and supporting files (references/, examples/, scripts/)
4. Validate at new location
5. Optionally delete from old location (ask user first)

**Example:**
```bash
# Personal to project
cp -r ~/.claude/skills/skill-name ./.claude/skills/skill-name

# Project to personal
cp -r ./.claude/skills/skill-name ~/.claude/skills/skill-name

# To plugin
cp -r ~/.claude/skills/skill-name ./plugin-name/skills/skill-name
```

## Validation Rules Reference

### Frontmatter Validation

**Name field:**
- Lowercase letters, numbers, hyphens only
- Max 64 characters
- Prefer gerund form: `analyzing-code` not `code-analyzer`
- Must match directory name

**Description field:**
- Max 1024 characters
- Third person voice ("This skill should be used when...")
- Include what it does AND when to use it
- Specific trigger words (file types, operations, domains)

**Allowed-tools field (optional):**
- Comma-separated list
- Valid tool names: Read, Write, Edit, Grep, Glob, Bash, Task, etc.
- Case-sensitive

### Content Validation

**Line count:**
- SKILL.md must be under 500 lines
- Ideally 300-400 lines for core content
- Supporting files have no limit

**Writing style:**
- Imperative/infinitive form (verb-first instructions)
- NOT second person ("You should...")
- Objective, instructional language

**Markdown formatting:**
- Proper heading hierarchy (# → ## → ###)
- Code blocks with language specifiers
- Forward slashes in paths (not backslashes)
- No deeply nested file references

**Clarity:**
- Instructions written for Claude (not humans)
- Step-by-step format
- Concrete examples (not pseudocode)
- No unnecessary explanations of basics

## Troubleshooting Edits

**YAML parse errors:**
- Check for tabs (use spaces only)
- Verify closing `---` is present
- Ensure proper indentation
- Quote values with special characters

**Skill not activating after edit:**
- Restart Claude Code to reload
- Verify description has specific triggers
- Check frontmatter is valid YAML
- Use `claude --debug` to see skill loading

**Line count exceeds 500:**
- Extract to references/ or examples/
- Remove redundant explanations
- Consolidate similar sections
- Challenge each paragraph: "Does Claude need this?"

**Edit breaks skill functionality:**
- Review validation checklist
- Test with trigger phrases
- Compare with working version
- Check for typos in tool names or file paths

## Best Practices for Editing

1. **Preserve working functionality**: Don't change what works
2. **Test after edits**: Verify skill still activates correctly
3. **Keep incremental**: Make one change at a time, validate, repeat
4. **Document major changes**: Add version comment if significant refactor
5. **Maintain consistency**: Follow existing skill's style and structure
6. **Optimize descriptions**: Most important for discoverability
7. **Challenge verbosity**: Remove unnecessary explanations
8. **Use supporting files**: Don't let SKILL.md exceed 500 lines (aim for 300-400)
9. **Use imperative form**: Never second person
10. **Reference resources**: Always link to references/, examples/, scripts/

## Progressive Disclosure Refactoring

### When to Refactor

Refactor when:
- SKILL.md approaching 400 lines (don't wait until 500)
- Content has distinct categories (patterns, advanced, examples)
- Detailed explanations could be separate
- Multiple levels of complexity (basic → advanced)

### What to Extract

**To references/**:
- Detailed patterns and techniques
- Advanced use cases
- Migration guides
- Comprehensive API documentation
- Edge case handling

**To examples/**:
- Complete working scripts
- Configuration file templates
- Real-world usage examples
- Before/after comparisons

**To scripts/**:
- Validation utilities
- Testing helpers
- Automation tools
- Parsing scripts

### How to Reference

**In SKILL.md:**
```markdown
## Additional Resources

### Reference Files
- **`references/patterns.md`** - Common patterns (15+ proven patterns)
- **`references/advanced.md`** - Advanced techniques and edge cases

### Examples
- **`examples/basic-example.sh`** - Simple working example
- **`examples/complex-workflow.sh`** - Multi-step workflow

### Scripts
- **`scripts/validate.sh`** - Validate configuration
```

**Keep one level deep** - Don't nest references:
```markdown
# Good
See references/patterns.md for details.

# Bad (nested)
See references/index.md which links to references/patterns.md
```

## Output Format

When editing a Skill, follow this flow:

1. Read and analyze current skill structure
2. Present summary with current state
3. Ask what to edit (using AskUserQuestion)
4. Make requested changes using Edit tool
5. Validate all changes against requirements
6. Create supporting files if needed (references/, examples/, scripts/)
7. Show summary of changes made
8. Provide testing recommendations

The result will be an improved Skill that maintains all validation requirements and follows best practices.
