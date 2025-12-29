# README (Root Project) - Complete Guide

## Purpose

The root README is the entry point to your project. Its primary goal: get someone from zero to working as fast as possible.

## Diataxis Classification

**How-to** - Goal-oriented, assumes reader wants to use the project.

## Audience

- New users discovering the project
- Developers evaluating whether to use it
- Contributors looking to get started

## Structure

### Required Sections

#### 1. Title + Badge Line

```markdown
# Project Name

![Build](https://...) ![License](https://...)

One sentence: what this project does.
```

#### 2. Quick Start (Most Important)

The fastest possible path to a working state. Should take <2 minutes.

```markdown
## Quick Start

\`\`\`bash
npx create-myapp myproject
cd myproject
npm start
\`\`\`

Open http://localhost:3000
```

#### 3. Installation

Detailed setup for those who need it.

```markdown
## Installation

### Prerequisites
- Node.js 18+ ([download](https://nodejs.org))
- npm or yarn

### Steps

1. Clone the repository
   \`\`\`bash
   git clone https://github.com/user/project.git
   cd project
   \`\`\`

2. Install dependencies
   \`\`\`bash
   npm install
   \`\`\`

3. Configure environment
   \`\`\`bash
   cp .env.example .env
   # Edit .env with your values
   \`\`\`

4. Start development server
   \`\`\`bash
   npm run dev
   \`\`\`
```

#### 4. Basic Usage

Show the most common use case.

```markdown
## Usage

\`\`\`javascript
import { Client } from 'myproject'

const client = new Client({ apiKey: 'xxx' })
const result = await client.doThing()
console.log(result)
\`\`\`
```

#### 5. License

```markdown
## License

MIT - see [LICENSE](./LICENSE)
```

### Optional Sections

Add only if valuable:

- **Features** - Bullet list of capabilities
- **Configuration** - Link to config reference
- **Contributing** - Link to CONTRIBUTING.md
- **Documentation** - Link to full docs
- **Examples** - Link to examples directory

## Checklist

### Essential

- [ ] Title clearly states what project does
- [ ] Quick Start works in <2 minutes
- [ ] Installation steps verified on clean machine
- [ ] Prerequisites clearly listed
- [ ] Basic usage example runs without modification

### Quality

- [ ] No broken links
- [ ] No outdated version numbers
- [ ] No references to deprecated features
- [ ] Commands copy-paste ready
- [ ] Examples use realistic values

### Completeness

- [ ] License specified
- [ ] Link to detailed docs (if exist)
- [ ] Contact/support info for questions

## Common Mistakes

### Too Much Information

Bad:
```markdown
## Architecture

Our project uses a microservices architecture with...
[500 lines of architectural explanation]
```

Good:
```markdown
## Architecture

See [Architecture Overview](./docs/architecture.md)
```

### Outdated Quick Start

Bad:
```markdown
## Quick Start
npm install -g myproject@1.0.0  # Version from 2 years ago
```

Good:
```markdown
## Quick Start
npm install -g myproject  # Always gets latest
```

### Missing Prerequisites

Bad:
```markdown
## Installation
npm install
```

Good:
```markdown
## Installation

### Prerequisites
- Node.js 18+
- PostgreSQL 14+

### Steps
npm install
```

## Template

```markdown
# Project Name

![Build Status](badge) ![npm version](badge) ![License](badge)

Brief description of what this project does and why it's useful.

## Quick Start

\`\`\`bash
npm install myproject
\`\`\`

\`\`\`javascript
import { feature } from 'myproject'
feature.run()
\`\`\`

## Installation

### Prerequisites

- Node.js 18+
- npm 9+

### Setup

1. Install the package:
   \`\`\`bash
   npm install myproject
   \`\`\`

2. Create configuration:
   \`\`\`bash
   npx myproject init
   \`\`\`

3. Start using:
   \`\`\`javascript
   import { feature } from 'myproject'
   \`\`\`

## Usage

### Basic Example

\`\`\`javascript
import { Client } from 'myproject'

const client = new Client()
const result = await client.process('input')
console.log(result)
\`\`\`

### With Options

\`\`\`javascript
const client = new Client({
  timeout: 5000,
  retries: 3
})
\`\`\`

## Documentation

- [API Reference](./docs/api.md)
- [Configuration](./docs/config.md)
- [Examples](./examples/)

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

MIT - see [LICENSE](./LICENSE)
```

## Verification

Before publishing, verify:

1. **Clone fresh** - Clone to new directory
2. **Follow README exactly** - No deviations
3. **Time it** - Should be <5 minutes to working state
4. **Test on different OS** - If possible

If any step fails or is confusing, fix the README.
