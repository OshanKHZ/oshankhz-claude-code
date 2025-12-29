# Reference Documentation - Complete Guide

## Purpose

Reference documentation provides exhaustive, accurate information for lookup. It's the "dictionary" of your project.

## Diataxis Classification

**Reference** - Information-oriented, exhaustive, accurate.

## Key Characteristics

- **Complete**: Every option, parameter, configuration documented
- **Accurate**: 100% correct, verified against source code
- **Consistent**: Same format throughout
- **Navigable**: Easy to find specific information
- **Neutral**: States facts, doesn't persuade or teach

## Audience

- Developers needing specific information
- Anyone looking up details
- All experience levels

## Core Principles

### 1. Exhaustive

Document everything. Missing information is a bug.

Bad:
```markdown
## Configuration

The main options are `port` and `debug`.
```

Good:
```markdown
## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| port | number | 3000 | Server port |
| debug | boolean | false | Enable debug logging |
| timeout | number | 30000 | Request timeout (ms) |
| maxRetries | number | 3 | Maximum retry attempts |
| logLevel | string | "info" | Log level: debug, info, warn, error |
| ssl.enabled | boolean | false | Enable HTTPS |
| ssl.cert | string | null | Path to SSL certificate |
| ssl.key | string | null | Path to SSL key |
```

### 2. Accurate

Every claim verified against code. No assumptions.

Process:
1. Read the source code
2. Document what it actually does
3. Test the documentation
4. Update when code changes

### 3. Consistent

Same format throughout. Predictable structure.

```markdown
### `methodName(param1, param2)`

**Description:** What it does.

**Parameters:**
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|

**Returns:** `Type` - Description

**Throws:**
- `ErrorType` - When X happens

**Example:**
\`\`\`javascript
[code]
\`\`\`
```

### 4. Navigable

Multiple ways to find information:
- Table of contents
- Search-friendly headings
- Cross-references
- Index/glossary

## Structure

### Configuration Reference

```markdown
# Configuration Reference

## Overview

Configuration via `config.json`, environment variables, or programmatic API.

Priority: Environment > Config file > Defaults

## Options

### Server

#### `port`

- **Type:** `number`
- **Default:** `3000`
- **Env:** `APP_PORT`
- **CLI:** `--port`

Port number for the HTTP server.

\`\`\`json
{ "port": 8080 }
\`\`\`

#### `host`

- **Type:** `string`
- **Default:** `"0.0.0.0"`
- **Env:** `APP_HOST`

Host address to bind to.

### Database

#### `database.url`

- **Type:** `string`
- **Required:** Yes
- **Env:** `DATABASE_URL`

Database connection string.

Format: `protocol://user:pass@host:port/database`

\`\`\`json
{ "database": { "url": "postgres://localhost:5432/myapp" } }
\`\`\`

#### `database.pool.min`

- **Type:** `number`
- **Default:** `2`

Minimum connections in pool.

#### `database.pool.max`

- **Type:** `number`
- **Default:** `10`

Maximum connections in pool.
```

### API Reference

```markdown
# API Reference

## Classes

### `Client`

Main client for interacting with the service.

#### Constructor

\`\`\`typescript
new Client(options?: ClientOptions)
\`\`\`

**Parameters:**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| options | ClientOptions | No | Configuration options |
| options.apiKey | string | Yes | API authentication key |
| options.baseUrl | string | No | API base URL (default: https://api.example.com) |
| options.timeout | number | No | Request timeout in ms (default: 30000) |

**Example:**

\`\`\`typescript
const client = new Client({
  apiKey: 'your-api-key',
  timeout: 5000
})
\`\`\`

#### Methods

##### `client.get(path, options?)`

Make GET request.

**Parameters:**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| path | string | Yes | Request path |
| options.params | object | No | Query parameters |
| options.headers | object | No | Additional headers |

**Returns:** `Promise<Response>`

**Throws:**
- `AuthenticationError` - Invalid API key
- `NotFoundError` - Resource not found
- `TimeoutError` - Request timeout

**Example:**

\`\`\`typescript
const users = await client.get('/users', {
  params: { page: 1, limit: 10 }
})
\`\`\`
```

### CLI Reference

```markdown
# CLI Reference

## Commands

### `init`

Initialize a new project.

\`\`\`bash
myapp init [name] [options]
\`\`\`

**Arguments:**

| Name | Required | Description |
|------|----------|-------------|
| name | No | Project name (default: current directory) |

**Options:**

| Flag | Alias | Default | Description |
|------|-------|---------|-------------|
| --template | -t | default | Project template |
| --force | -f | false | Overwrite existing files |
| --no-git | | false | Skip git initialization |

**Examples:**

\`\`\`bash
# Basic initialization
myapp init my-project

# With template
myapp init my-project --template typescript

# Force overwrite
myapp init my-project --force
\`\`\`

### `build`

Build the project for production.

\`\`\`bash
myapp build [options]
\`\`\`

**Options:**

| Flag | Alias | Default | Description |
|------|-------|---------|-------------|
| --outDir | -o | dist | Output directory |
| --minify | -m | true | Minify output |
| --sourcemap | -s | false | Generate sourcemaps |
```

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

## Template

```markdown
# [Component] Reference

## Overview

[Brief description of what this reference covers]

## [Category 1]

### `itemName`

- **Type:** `type`
- **Default:** `default`
- **Required:** Yes/No
- **Since:** v1.2.0

[Description]

**Valid values:**
- `value1` - Description
- `value2` - Description

**Example:**

\`\`\`javascript
[example code]
\`\`\`

**See also:** [Related Item](#related)

### `anotherItem`

[Continue pattern...]

## [Category 2]

[Continue pattern...]

## Index

| Item | Type | Category |
|------|------|----------|
| itemName | type | Category 1 |
| anotherItem | type | Category 2 |
```

## Anti-Patterns

### Incomplete Reference

Bad: "Main options are X, Y, Z"
Good: [Complete table of ALL options]

### Teaching in Reference

Bad: "CORS is important because browsers..."
Good: "cors.enabled - Enable CORS headers"

### Inconsistent Format

Bad: Some options have tables, some have lists, some have prose
Good: Every option uses identical format

### Outdated Information

Bad: Reference says `oldMethod()` but code has `newMethod()`
Good: Reference matches current code exactly
