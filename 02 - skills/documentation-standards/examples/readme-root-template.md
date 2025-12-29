# README (Root Project) Template

A concrete example of a well-structured root README following documentation standards.

---

# Project Name

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Brief one-liner: what this project does and why it's useful.

## Quick Start

Get running in **under 2 minutes**:

```bash
npm install project-name
```

```javascript
import { feature } from 'project-name'

const result = await feature.run()
console.log(result)
```

## Features

- Feature 1 - Brief description
- Feature 2 - Brief description
- Feature 3 - Brief description

## Installation

### Prerequisites

- [ ] Node.js 18+ ([download](https://nodejs.org))
- [ ] npm 9+

### Setup

```bash
# Install the package
npm install project-name

# Or with yarn
yarn add project-name
```

### Configuration

```bash
npx project-name init
```

This creates a `config.json` with default settings.

## Usage

### Basic Example

```javascript
import { Client } from 'project-name'

const client = new Client()
const result = await client.process('input')
console.log(result)
```

### With Options

```javascript
const client = new Client({
  timeout: 5000,
  retries: 3,
  debug: true
})
```

### Common Patterns

```javascript
// Pattern 1: Batch processing
const results = await client.processBatch(items)

// Pattern 2: Streaming
const stream = client.stream('input')
stream.on('data', console.log)
```

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| timeout | number | 30000 | Request timeout in ms |
| retries | number | 3 | Maximum retry attempts |
| debug | boolean | false | Enable debug logging |

See [Configuration Reference](./docs/config.md) for all options.

## Documentation

- [API Reference](./docs/api.md) - Complete API documentation
- [Configuration](./docs/config.md) - All configuration options
- [Examples](./examples/) - Code examples
- [Migration Guide](./docs/migration.md) - Upgrading between versions

## Contributing

We welcome contributions! See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

MIT - see [LICENSE](./LICENSE)

---

## Why This Template Works

### Quick Start First

Gets developers running in <2 minutes with copy-paste commands.

### Progressive Disclosure

- Quick Start - Immediate gratification
- Installation - More detail when needed
- Usage - Examples for common tasks
- Docs links - Deep dives elsewhere

### Practical Examples

Real code patterns, not foo/bar examples.

### Clear Configuration Table

Easy to scan key options with types and defaults.

### Linked Resources

Doesn't try to include everything - links to detailed docs.
