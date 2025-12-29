# README Guidelines

Rules, tips, and best practices for creating effective READMEs.

## Purpose

The root README is the entry point to your project. Its primary goal: get someone from zero to working as fast as possible.

## Diataxis Classification

- **Root README:** How-to (goal-oriented, get project running)
- **Module README:** Reference + How-to hybrid

## Audience

- New users discovering the project
- Developers evaluating whether to use it
- Contributors looking to get started

## Core Principles

### 1. Quick Start First

The fastest path to working. Should take <2 minutes for basic setup.

### 2. Progressive Disclosure

- Quick Start - Immediate gratification
- Installation - More detail when needed
- Usage - Examples for common tasks
- Docs links - Deep dives elsewhere

### 3. Link, Don't Embed

Don't try to include everything. Link to detailed docs.

**Good:** "See [Configuration Reference](./docs/config.md)"
**Bad:** 500 lines of configuration documentation in README

### 4. Test Your Instructions

Before publishing:

1. Clone to fresh directory
2. Follow README exactly
3. Time it (<5 minutes to working state)
4. Test on different OS if possible

## Required Sections (Root README)

1. **Title + One-liner** - What it does
2. **Quick Start** - Fastest path to working
3. **Installation** - Detailed setup steps
4. **Usage** - Basic examples
5. **License** - Required for open source

## Optional Sections

- Features - Bullet list of capabilities
- Configuration - Link to config reference
- Contributing - Link to CONTRIBUTING.md
- Documentation - Link to full docs
- Examples - Link to examples directory

## Required Sections (Module README)

1. **Purpose** - What problem does this module solve?
2. **API** - Functions/classes exported
3. **Usage Examples** - Common use cases
4. **Dependencies** - What this module depends on

## Checklist

### Root README

- [ ] Title clearly states what project does
- [ ] Quick Start works in <2 minutes
- [ ] Installation steps verified on clean machine
- [ ] Prerequisites clearly listed (checklist format)
- [ ] Basic usage example runs without modification
- [ ] License specified

### Module README

- [ ] Purpose clearly explained
- [ ] All exports documented
- [ ] Examples for main use cases
- [ ] Dependencies listed

### Quality

- [ ] No broken links
- [ ] No outdated version numbers
- [ ] Commands copy-paste ready
- [ ] Examples use realistic values (not foo/bar)

## Anti-Patterns

### Too Much Information

**Bad:** 500 lines of architecture explanation
**Good:** Link to architecture docs

### Outdated Quick Start

**Bad:** `npm install -g myproject@1.0.0` (2-year-old version)
**Good:** `npm install -g myproject` (latest)

### Missing Prerequisites

**Bad:** Just `npm install` with no context
**Good:** Prerequisites list with versions

### Placeholders in Examples

**Bad:** `api.call('<YOUR_API_KEY>')`
**Good:** `api.call('your-api-key')  // Get one at https://...`

## Patterns

### Badges

```markdown
![Build](https://github.com/user/repo/workflows/CI/badge.svg)
![npm](https://img.shields.io/npm/v/package)
![License](https://img.shields.io/badge/license-MIT-green)
```

### Configuration Table

```markdown
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| timeout | number | 30000 | Request timeout |
| retries | number | 3 | Max retry attempts |
```

### Multiple Installation Methods

Show preferred method first, alternatives below.

## See Also

- **Templates:**
  - `examples/readme-root-template.md`
  - `examples/readme-module-template.md`
- **Example:** `examples/good-readme.md`
