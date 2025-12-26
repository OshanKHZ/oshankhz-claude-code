# Creating Skills: Detailed Process

This reference provides the complete skill creation process with interactive patterns, validation, and best practices.

## Step-by-Step Creation Process

### Step 1: Validate Understanding and Gather Requirements

**Principle: Don't ask what the user already said.** Analyze the conversation context first, then ask only what's missing.

#### 1.1 Analyze Context

Before asking questions, extract from the conversation:
- What the user wants the skill to do
- Any mentioned triggers, file types, or domains
- Implied complexity level

#### 1.2 Core Questions (Always Ask)

Use `AskUserQuestion` with these two questions together:

```json
{
  "questions": [
    {
      "question": "Entendi que você quer uma skill para [RESUMO DO QUE CLAUDE ENTENDEU]. Correto?",
      "header": "Confirmação",
      "multiSelect": false,
      "options": [
        {
          "label": "Sim, é isso!",
          "description": "Prosseguir com a criação"
        },
        {
          "label": "Quase, mas...",
          "description": "Vou explicar melhor o que preciso"
        }
      ]
    },
    {
      "question": "Qual a complexidade da skill?",
      "header": "Estrutura",
      "multiSelect": false,
      "options": [
        {
          "label": "Simples",
          "description": "Só SKILL.md com instruções diretas"
        },
        {
          "label": "Média",
          "description": "SKILL.md + examples ou references"
        },
        {
          "label": "Completa",
          "description": "SKILL.md + references + examples + scripts"
        }
      ]
    }
  ]
}
```

**If user chooses "Quase, mas..."**: Read their explanation and re-validate understanding before proceeding.

#### 1.3 Conditional Questions

**Interactivity** (ask only if complexity >= Média AND context suggests need):

```json
{
  "questions": [
    {
      "question": "A skill precisa interagir com o usuário durante execução?",
      "header": "Interatividade",
      "multiSelect": false,
      "options": [
        {
          "label": "Não",
          "description": "Segue instruções diretas sem coletar informações"
        },
        {
          "label": "Sim",
          "description": "Precisa coletar informações ou preferências do usuário"
        }
      ]
    }
  ]
}
```

**Location** (ask only if not obvious - default is personal):

```json
{
  "questions": [
    {
      "question": "Onde criar a skill?",
      "header": "Location",
      "multiSelect": false,
      "options": [
        {
          "label": "Personal ~/.claude/skills/ (Recomendado)",
          "description": "Seus workflows pessoais, produtividade"
        },
        {
          "label": "Projeto .claude/skills/",
          "description": "Compartilhar com o time, específico do projeto"
        }
      ]
    }
  ]
}
```

**When to ask Location:**
- User mentioned "pro time", "projeto", "compartilhar"
- Working inside a project directory with existing .claude/
- Otherwise, default to `~/.claude/skills/` without asking

#### 1.4 Validate Scope

After receiving answers:
- **Keep it focused**: One Skill = one capability
  - Good: "PDF form filling", "Excel data analysis", "Git commit messages"
  - Too broad: "Document processing", "Data tools", "Version control"
- If scope is too broad, ask user to narrow it down

### Step 2: Generate Skill Name

Based on user's answers, propose a skill name:

**Naming rules:**
- Lowercase letters, numbers, hyphens only
- Max 64 characters
- **Use gerund form** (verb+ing): `processing-pdfs`, `writing-documentation`
- Be specific, not generic

**Formula**: `[action]-[target]`
- Good: `analyzing-spreadsheets`, `generating-commit-messages`, `reviewing-pull-requests`
- Bad: `PDF_Processor`, `Git Commits!`, `helper`, `utils`

**Propose name to user**: "I suggest naming this Skill `[proposed-name]`. Does this work for you?"

### Step 3: Create Skill Structure

Create the directory and files:

```bash
# Personal
mkdir -p ~/.claude/skills/skill-name/{references,examples,scripts}

# Project
mkdir -p .claude/skills/skill-name/{references,examples,scripts}

# Plugin
mkdir -p plugin-name/skills/skill-name/{references,examples,scripts}
```

**Note:** Only create subdirectories you'll actually use. Delete empty ones.

**Structure options:**

```
# Minimal (simple knowledge)
skill-name/
└── SKILL.md

# Standard (recommended for most)
skill-name/
├── SKILL.md
├── references/
│   └── detailed-guide.md
└── examples/
    └── working-example.sh

# Complete (complex domain)
skill-name/
├── SKILL.md
├── references/
│   ├── patterns.md
│   └── advanced.md
├── examples/
│   ├── example1.sh
│   └── example2.json
└── scripts/
    └── validate.sh
```

### Step 4: Write SKILL.md Frontmatter

Create YAML frontmatter with required fields:

```yaml
---
name: skill-name
description: This skill should be used when the user asks to "specific trigger 1", "specific trigger 2", or mentions specific terms. Brief explanation of what it does.
---
```

**Name field:**
- Lowercase letters, numbers, hyphens only
- Max 64 characters
- Use gerund form (verb+ing): `processing-pdfs`, `writing-documentation`
- Good: `analyzing-spreadsheets`, `generating-commit-messages`
- Bad: `PDF_Processor`, `Git Commits!`, `helper`

**Description field:**
- Max 1024 characters
- Include BOTH what it does AND when to use it
- **Always write in third person**:
  - Good: "This skill should be used when the user asks to..."
  - Avoid: "I can help you..."
  - Avoid: "Use this skill to..."
- Use specific trigger words users would say
- Mention file types, operations, and context

**Good descriptions:**
```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", or mentions hook events (PreToolUse, PostToolUse, Stop). Provides comprehensive hooks API guidance.
```

```yaml
description: This skill should be used when the user asks to "analyze spreadsheet", "process Excel file", "extract CSV data", or works with .xlsx, .csv, or tabular data. Analyzes data, creates summaries, and generates visualizations.
```

**Bad descriptions:**
```yaml
description: Helps with hooks  # Vague, not third person
description: Use this skill for hook development  # Wrong person
description: I can help you create hooks  # First person
```

**Optional frontmatter fields:**

**allowed-tools** - Restrict tool access:
```yaml
allowed-tools: Read, Grep, Glob  # Read-only skill
```

Use for:
- Read-only skills
- Security-sensitive workflows
- Limited-scope operations

### Step 5: Write Effective Descriptions

The description is critical for Claude to discover your Skill.

**Formula**: `[What it does] + [When to use it] + [Key triggers]`

**Examples:**

✅ **Good** (third person, specific):
```yaml
description: This skill should be used when the user asks to "extract text from PDF", "fill PDF form", "merge PDFs", or works with PDF files. Extracts text and tables, fills forms, and merges documents using pdfplumber.
```

✅ **Good**:
```yaml
description: This skill should be used when the user asks to "analyze Excel", "create pivot table", "generate chart from spreadsheet", or works with .xlsx files. Analyzes data, creates pivot tables, and generates visualizations.
```

❌ **Too vague**:
```yaml
description: Helps with documents
description: For data analysis
```

❌ **Wrong person**:
```yaml
description: I help you process documents
description: You can use this for data analysis
```

**Tips:**
- Include specific file extensions (.pdf, .xlsx, .json)
- Mention common user phrases ("analyze", "extract", "generate")
- List concrete operations (not generic verbs)
- Add context clues ("Use when...", "For...")

### Step 6: Set Appropriate Degrees of Freedom

Match the level of specificity to the task's fragility and variability.

**High freedom** (text-based instructions):

Use when multiple approaches are valid, decisions depend on context.

```markdown
## Code review process
1. Analyze the code structure and organization
2. Check for potential bugs or edge cases
3. Suggest improvements for readability
```

**Medium freedom** (pseudocode or scripts with parameters):

Use when a preferred pattern exists but some variation is acceptable.

```markdown
## Generate report
Use this template and customize as needed:
\`\`\`python
def generate_report(data, format="markdown", include_charts=True):
    # Process data and generate output
\`\`\`
```

**Low freedom** (specific scripts, few or no parameters):

Use when operations are fragile and consistency is critical.

```markdown
## Database migration
Run exactly this script:
\`\`\`bash
python scripts/migrate.py --verify --backup
\`\`\`
Do not modify the command or add additional flags.
```

### Step 7: Think Through the Design

**Before generating the SKILL.md, think step-by-step:**

1. **Minimal viable scope**: What's the absolute minimum this Skill needs to do?
   - Challenge yourself: Can I remove any feature and still meet the user's need?
   - Avoid feature creep: Don't add "nice-to-haves"

2. **Similar Skills**: Are there existing Skills that do something similar?
   - Check Claude Code documentation for built-in patterns
   - Look at the user's other Skills for overlaps
   - If overlap exists, suggest enhancing existing Skill instead

3. **Conciseness**: What's the most concise way to explain this?
   - Avoid explaining what Claude already knows
   - Skip generic software engineering principles
   - Focus only on specifics unique to this Skill

4. **Examples**: What examples would make this immediately clear?
   - Choose real-world examples, not toy examples
   - Show complete code, not pseudocode
   - Include error cases if they're common

**After thinking through these questions, show user a preview:**

```
I'll create a Skill with this structure:

**Name**: `[skill-name]`
**Location**: `[~/.claude/skills/ or .claude/skills/]`

**Description** (what Claude will see):
"[Your proposed description in third person]"

**Sections**:
1. Quick start - [brief explanation]
2. Instructions - [main steps]
3. Examples - [what examples you'll include]
4. [Any optional sections like Requirements, Best practices]

**Token budget**: ~[estimated lines] lines (under 500 line limit)

Does this structure work for you? Any changes needed?
```

Wait for user confirmation before proceeding.

### Step 8: Structure the Skill Content

Use clear Markdown sections:

```markdown
# Skill Name

Brief overview of what this Skill does.

## Quick start

Provide a simple example to get started immediately.

## Instructions

Step-by-step guidance for Claude:
1. First step with clear action
2. Second step with expected outcome
3. Handle edge cases

## Examples

Show concrete usage examples with code or commands.

## Best practices

- Key conventions to follow
- Common pitfalls to avoid
- When to use vs. not use

## Requirements

List any dependencies or prerequisites:
\`\`\`bash
pip install package-name
\`\`\`

## Advanced usage

For complex scenarios, see [reference.md](references/detailed-guide.md).
```

### Step 8.5: Add Interactive Patterns (When Applicable)

**If the skill requires user input or decisions**, include `AskUserQuestion` patterns in the instructions.

**When to add interactive patterns:**
- Skill helps create/configure something (commands, hooks, configs)
- Multiple valid approaches exist
- User preferences matter for the workflow
- Gathering requirements is part of the task

**Example for command-creation skill:**

```markdown
## Instructions

### Step 1: Gather Command Requirements

Use AskUserQuestion to understand what the command should do:

\`\`\`json
{
  "questions": [
    {
      "question": "What should this command do?",
      "header": "Purpose",
      "multiSelect": false,
      "options": [
        {
          "label": "Run tests",
          "description": "Execute test suite with specific configuration"
        },
        {
          "label": "Build project",
          "description": "Compile and bundle project files"
        },
        {
          "label": "Review code",
          "description": "Perform code review with specific checks"
        }
      ]
    },
    {
      "question": "Does the command need arguments?",
      "header": "Arguments",
      "multiSelect": true,
      "options": [
        {
          "label": "File path",
          "description": "Command operates on specific file"
        },
        {
          "label": "Options/flags",
          "description": "Command accepts configuration options"
        }
      ]
    }
  ]
}
\`\`\`

### Step 2: Create Command Structure

Based on user's answers, create the command file...
```

**Benefits:**
- Makes the skill interactive and user-friendly
- Guides users through complex decisions
- Gathers requirements systematically
- Reduces errors from missing information

**See:** `examples/interactive-workflow-example.md` for complete patterns

### Step 9: Manage Token Budgets

Skills use progressive disclosure to minimize context usage:

| Level | When Loaded | Token Cost | Content |
|-------|-------------|------------|---------|
| **Level 1: Metadata** | Always (at startup) | ~100 tokens | `name` and `description` from YAML |
| **Level 2: Instructions** | When Skill triggered | Under 5k tokens | SKILL.md body |
| **Level 3: Resources** | As needed | Unlimited | Additional files, scripts |

**Guidelines:**
- Keep SKILL.md body **under 500 lines** (ideally 300-400)
- Split content into separate files when approaching this limit
- Only add context Claude doesn't already have
- Challenge each piece: "Does Claude really need this?"

**Good** (~50 tokens):
```markdown
## Extract PDF text
Use pdfplumber:
\`\`\`python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
\`\`\`
```

**Bad** (~150 tokens - over-explaining):
```markdown
PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. There are many libraries available...
```

### Step 10: Add Supporting Files (Optional)

Create additional files for progressive disclosure:

**references/** - Detailed API docs, advanced options
**examples/** - Extended examples and use cases
**scripts/** - Helper scripts and utilities

Reference them from SKILL.md:
```markdown
For advanced usage, see [references/advanced-patterns.md](references/advanced-patterns.md).

Run the helper script:
\`\`\`bash
python scripts/helper.py input.txt
\`\`\`
```

**Important**: Keep references one level deep from SKILL.md. Avoid deeply nested file references.

### Step 11: Validate the Skill

Check these requirements:

✅ **File structure**:
- [ ] SKILL.md exists in correct location (uppercase filename!)
- [ ] Directory name matches frontmatter `name`
- [ ] Only necessary subdirectories created (delete empty ones)

✅ **YAML frontmatter**:
- [ ] Opening `---` on line 1
- [ ] Closing `---` before content
- [ ] Valid YAML (no tabs, correct indentation)
- [ ] `name` follows naming rules (gerund form preferred)
- [ ] `description` is specific, third person, and < 1024 chars

✅ **Content quality**:
- [ ] Clear instructions for Claude in imperative form
- [ ] Concrete examples provided
- [ ] Edge cases handled
- [ ] Dependencies listed (if any)
- [ ] Under 500 lines (ideally 300-400)
- [ ] No second person ("you should...")

✅ **Progressive disclosure**:
- [ ] Core content in SKILL.md
- [ ] Detailed content in references/
- [ ] Working examples in examples/
- [ ] Utilities in scripts/
- [ ] SKILL.md references these resources

### Step 12: Test the Skill

1. **Restart Claude Code** (if running) to load the Skill

2. **Ask relevant questions** that match the description:
   ```
   Can you help me extract text from this PDF?
   ```

3. **Verify activation**: Claude should use the Skill automatically

4. **Check behavior**: Confirm Claude follows the instructions correctly

### Step 13: Debug if Needed

If Claude doesn't use the Skill:

1. **Make description more specific**:
   - Add trigger words
   - Include file types
   - Mention common user phrases

2. **Check file location**:
   ```bash
   ls ~/.claude/skills/skill-name/SKILL.md
   ls .claude/skills/skill-name/SKILL.md
   ```

3. **Validate YAML**:
   ```bash
   cat SKILL.md | head -n 10
   ```

4. **Run debug mode**:
   ```bash
   claude --debug
   ```

## Iterative Development with Claude

The most effective Skill development involves Claude itself:

1. **Complete a task without a Skill**: Work through a problem with Claude. Notice what information you repeatedly provide.

2. **Identify the reusable pattern**: After completing the task, identify what context would be useful for similar future tasks.

3. **Ask Claude to create a Skill**: "Create a Skill that captures this pattern we just used."

4. **Review for conciseness**: Check that Claude hasn't added unnecessary explanations.

5. **Test on similar tasks**: Use the Skill with a fresh Claude instance on related use cases.

6. **Iterate based on observation**: If Claude struggles, refine the Skill with specifics about what went wrong.

## Common Patterns

### Read-only Skill

```yaml
---
name: reviewing-code
description: This skill should be used when the user asks to "review code", "check code quality", "analyze codebase", or needs code review without making changes. Reviews code for best practices and potential issues.
allowed-tools: Read, Grep, Glob
---
```

### Script-based Skill

```yaml
---
name: processing-data
description: This skill should be used when the user asks to "process CSV", "analyze JSON", "transform data", or works with .csv or .json files. Processes data files with Python scripts.
---

# Processing Data

## Instructions

1. Use the processing script:
\`\`\`bash
python scripts/process.py input.csv --output results.json
\`\`\`

2. Validate output with:
\`\`\`bash
python scripts/validate.py results.json
\`\`\`
```

### Multi-file Skill with Progressive Disclosure

```yaml
---
name: designing-apis
description: This skill should be used when the user asks to "design API", "create REST endpoint", "plan API architecture", or works with API design. Designs REST APIs following best practices.
---

# Designing APIs

Quick start: See [examples/api-examples.md](examples/api-examples.md)

Detailed reference: See [references/api-patterns.md](references/api-patterns.md)

## Instructions

1. Gather requirements
2. Design endpoints (see examples)
3. Document with OpenAPI spec
4. Review against best practices (see reference)
```

## Anti-patterns to Avoid

### Vague Descriptions

```yaml
# Bad
description: Helps with documents

# Good
description: This skill should be used when the user asks to "extract PDF text", "fill PDF form", or works with PDF files. Extracts text and tables from PDFs using pdfplumber.
```

### Wrong Person

```yaml
# Bad
description: I can help you process documents
description: Use this skill for document processing

# Good
description: This skill should be used when the user asks to "process document", "extract text", or works with PDF/Word files.
```

### Too Many Options

```markdown
# Bad
"You can use pypdf, or pdfplumber, or PyMuPDF, or pdf2image..."

# Good - provide a default
"Use pdfplumber for text extraction. For scanned PDFs requiring OCR, use pdf2image with pytesseract instead."
```

### Inconsistent Terminology

Pick one term and use it throughout:
- Always "API endpoint" (not mixing with "URL", "route", "path")
- Always "field" (not mixing with "box", "element", "control")

## Validation Checklist

Before finalizing a Skill, verify:

- [ ] File named SKILL.md (uppercase)
- [ ] Name is lowercase, hyphens only, max 64 chars, gerund form
- [ ] Description is specific, third person, and < 1024 chars
- [ ] Description includes "what" and "when"
- [ ] YAML frontmatter is valid
- [ ] Instructions are step-by-step in imperative form
- [ ] Examples are concrete and realistic
- [ ] Dependencies are documented
- [ ] File paths use forward slashes
- [ ] Body is under 500 lines (ideally 300-400)
- [ ] Detailed content moved to references/
- [ ] Supporting files referenced in SKILL.md
- [ ] Skill activates on relevant queries
- [ ] Claude follows instructions correctly
- [ ] No second person ("you should...")

## Troubleshooting

**Skill doesn't activate:**
- Make description more specific with trigger words
- Include file types and operations in description
- Add "This skill should be used when..." clause with user phrases

**Multiple Skills conflict:**
- Make descriptions more distinct
- Use different trigger words
- Narrow the scope of each Skill

**Skill has errors:**
- Check YAML syntax (no tabs, proper indentation)
- Verify file paths (use forward slashes)
- Ensure scripts have execute permissions
- List all dependencies

## Output Format

When creating a Skill, follow this flow:

1. Ask clarifying questions about scope and requirements (using AskUserQuestion)
2. Suggest a Skill name and location
3. Show preview of structure and confirm with user
4. Create the SKILL.md file with proper frontmatter
5. Include clear instructions and examples in imperative form
6. Add supporting files if needed (references/, examples/, scripts/)
7. Provide testing instructions
8. Validate against all requirements

The result will be a complete, working Skill that follows all best practices and validation rules.
