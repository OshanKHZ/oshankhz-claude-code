# Reference Documentation Guidelines

Rules, tips, and best practices for creating effective reference documentation.

## Purpose

Reference documentation provides exhaustive, accurate information for lookup. It's the "dictionary" of your project.

## Diataxis Classification

**Reference** - Information-oriented, exhaustive, accurate.

## Key Characteristics

- **Complete:** Every option, parameter, configuration documented
- **Accurate:** 100% correct, verified against source code
- **Consistent:** Same format throughout
- **Navigable:** Easy to find specific information
- **Neutral:** States facts, doesn't persuade or teach

## Audience

- Developers needing specific information
- Anyone looking up details
- All experience levels

## Core Principles

### 1. Exhaustive

Document everything. Missing information is a bug.

**Bad:** "The main options are `port` and `debug`."
**Good:** Complete table of ALL options with types and defaults

### 2. Accurate

Every claim verified against code. No assumptions.

Process:
1. Read the source code
2. Document what it actually does
3. Test the documentation
4. Update when code changes

### 3. Consistent

Same format for every item. Predictable structure.

```markdown
### `optionName`

- **Type:** `type`
- **Default:** `value`
- **Required:** Yes/No

Description.
```

### 4. Navigable

Multiple ways to find information:

- Table of contents
- Search-friendly headings
- Cross-references
- Quick reference tables

## Required Elements

### For Configuration Reference

- Type
- Default value
- Environment variable name (if applicable)
- Description
- Example
- Valid values (for enums)

### For API Reference

- Function/method signature
- Parameters (name, type, required, description)
- Return type
- Throws/errors
- Example

### For CLI Reference

- Command syntax
- Arguments
- Options/flags
- Examples

## Checklist

### Completeness

- [ ] Every option/parameter documented
- [ ] All types specified
- [ ] All defaults stated
- [ ] All constraints noted (min, max, valid values)

### Accuracy

- [ ] Verified against source code
- [ ] Examples tested
- [ ] Types correct
- [ ] Defaults match actual behavior

### Consistency

- [ ] Same format throughout
- [ ] Same terminology
- [ ] Same detail level
- [ ] Same example style

### Navigation

- [ ] Table of contents
- [ ] Logical grouping
- [ ] Cross-references
- [ ] Search-friendly headings

## Anti-Patterns

### Incomplete Reference

**Bad:** "Main options are X, Y, Z"
**Good:** Complete table of ALL options

### Teaching in Reference

**Bad:** "CORS is important because browsers..."
**Good:** "`cors.enabled` - Enable CORS headers. Type: boolean. Default: false."

### Inconsistent Format

**Bad:** Mix of tables, lists, and prose
**Good:** Same format for every option

### Outdated Information

**Bad:** Reference says `oldMethod()` but code has `newMethod()`
**Good:** Reference matches current code exactly

### Missing Types

**Bad:** `id` - User identifier
**Good:** `id: string (UUID)` - User identifier

## Patterns

### Configuration Option Format

```markdown
### `database.url`

- **Type:** `string`
- **Required:** Yes
- **Env:** `DATABASE_URL`

Database connection string.

**Format:** `protocol://user:pass@host:port/database`

**Example:**
\`\`\`json
{ "database": { "url": "postgres://localhost:5432/myapp" } }
\`\`\`
```

### Function Documentation Format

```markdown
### `functionName(param1, param2)`

Description.

**Parameters:**
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|

**Returns:** `ReturnType` - Description

**Throws:**
- `ErrorType` - When condition

**Example:**
\`\`\`typescript
const result = functionName('value', options)
\`\`\`
```

### Quick Reference Table

```markdown
| Variable | Config Path | Default |
|----------|-------------|---------|
| `APP_PORT` | port | 3000 |
| `DATABASE_URL` | database.url | - |
```

## See Also

- **Template:** `examples/reference-docs-template.md`
