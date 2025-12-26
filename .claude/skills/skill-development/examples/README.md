# Skill Structure Examples

This directory contains three skill structure examples demonstrating different complexity levels.

## Examples Overview

| Example | Complexity | Best For | Structure |
|---------|-----------|----------|-----------|
| **Minimal** | Simple | Straightforward knowledge | SKILL.md only |
| **Standard** | Moderate | Most skills (recommended) | SKILL.md + references/ + examples/ |
| **Complete** | Complex | Advanced domains with utilities | SKILL.md + references/ + examples/ + scripts/ |

## Minimal Skill Example

**File:** [minimal-skill-example.md](minimal-skill-example.md)

**Structure:**
```
minimal-skill/
└── SKILL.md
```

**Use when:**
- Simple, straightforward knowledge
- No complex workflows or scripts needed
- Content fits comfortably in <500 lines
- No need for detailed patterns or advanced techniques

**Example use case:** Quick code review skill with simple checklist

## Standard Skill Example (Recommended)

**File:** [standard-skill-example.md](standard-skill-example.md)

**Structure:**
```
standard-skill/
├── SKILL.md
├── references/
│   └── detailed-guide.md
└── examples/
    └── working-example.sh
```

**Use when:**
- Skill has moderate complexity
- Detailed patterns exist but aren't always needed
- Working examples help understanding
- Core workflow fits in SKILL.md (<500 lines)
- Progressive disclosure benefits skill

**Example use case:** API analysis skill with basic workflow in SKILL.md and detailed patterns in references/

## Complete Skill Example

**File:** [complete-skill-example.md](complete-skill-example.md)

**Structure:**
```
complete-skill/
├── SKILL.md
├── references/
│   ├── patterns.md
│   ├── advanced.md
│   └── migration.md
├── examples/
│   ├── basic-example.sh
│   ├── advanced-workflow.sh
│   └── config-template.json
└── scripts/
    ├── validate.sh
    ├── test.sh
    └── README.md
```

**Use when:**
- Skill has high complexity
- Multiple levels of detail needed (basic → advanced)
- Automated tools complement manual review
- Users benefit from utilities and helpers
- Progressive disclosure is critical
- Content would exceed 500 lines in single file

**Example use case:** Comprehensive API security audit with automated scanning tools and detailed manual review patterns

## Choosing the Right Structure

**Start minimal, grow as needed:**

1. **Begin with minimal** - Most skills start simple
2. **Upgrade to standard** when:
   - SKILL.md approaching 400 lines
   - Detailed patterns accumulate
   - Users need working examples
3. **Upgrade to complete** when:
   - Adding automated validation tools
   - Multiple reference files needed
   - Users need working scripts

## Key Differences

### Token Usage

| Structure | SKILL.md Size | Always Loaded | Progressive Disclosure |
|-----------|--------------|---------------|----------------------|
| Minimal | <500 lines | All content | None |
| Standard | 300-400 lines | Core only | references/, examples/ |
| Complete | 300-400 lines | Core only | references/, examples/, scripts/ |

### Maintenance

| Structure | Complexity | Files to Maintain | Sync Overhead |
|-----------|-----------|-------------------|---------------|
| Minimal | Low | 1 file | None |
| Standard | Medium | 3-5 files | Low |
| Complete | High | 7-10 files | Medium |

### Use Cases

| Structure | Ideal For |
|-----------|-----------|
| Minimal | Simple workflows, quick references, basic knowledge |
| Standard | Most skills, moderate workflows, some complexity |
| Complete | Complex domains, automated tools, multi-level content |

## Progressive Disclosure Benefits

**Standard and Complete structures leverage progressive disclosure:**

1. **Level 1 (Always):** Metadata (name + description) ~100 words
2. **Level 2 (When triggered):** SKILL.md body ~1,500-2,000 words
3. **Level 3 (As needed):** references/, examples/, scripts/ - Unlimited

**Result:**
- Faster skill loading
- Lower token usage
- Better context management
- Scalable to complex domains

## Study These Examples

Each example file contains:
- Complete skill code
- When to use this structure
- Advantages and disadvantages
- Migration paths
- Best practices

Read the examples to understand:
- Frontmatter structure
- Content organization
- Progressive disclosure patterns
- Reference file organization
- Script documentation

## Real-World Examples

Study these skills in this plugin for real implementations:

- **hook-development** - Complete structure with references/, examples/, scripts/
- **command-development** - Standard structure with references/ and examples/
- **sync-claude-md** - Well-organized analysis skill

## Additional Resources

For complete guidance on skill development:

- **`../SKILL.md`** - Core skill development workflow
- **`../references/creating-skills.md`** - Detailed creation process
- **`../references/editing-skills.md`** - Detailed editing process
- **`../references/best-practices.md`** - Validation rules and optimization
