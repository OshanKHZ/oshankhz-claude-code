# How-to Guide Guidelines

Rules, tips, and best practices for creating effective how-to guides.

## Purpose

How-to guides help practitioners accomplish specific goals. They assume knowledge and provide direct, efficient paths to outcomes.

## Diataxis Classification

**How-to** - Goal-oriented, practical, assumes knowledge.

## Key Difference from Tutorial

| Tutorial | How-to |
|----------|--------|
| Learning-oriented | Goal-oriented |
| Teaches concepts | Assumes concepts |
| Hand-holds | Directs |
| "Follow me" | "Here's how" |
| Builds confidence | Gets job done |

## Audience

- Developers who know the basics
- People with specific tasks to complete
- Users who need quick answers

## Core Principles

### 1. Goal-Focused

Title states the goal. Content delivers it.

**Good titles:**
- "How to: Deploy to AWS Lambda"
- "How to: Configure CORS"
- "How to: Migrate from v2 to v3"

### 2. Assumes Knowledge

Don't explain basics. Reference them if needed.

**Bad:** "First, let's understand what environment variables are..."
**Good:** "Set these environment variables (see [reference](./env.md) if needed):"

### 3. Minimal but Complete

Every step necessary. No step unnecessary.

**Bad:** 500 words explaining why before showing how
**Good:** Direct steps to achieve the goal

### 4. Real-World Scenarios

Use realistic examples, not foo/bar.

**Bad:** `function doSomething(foo, bar)`
**Good:** `async function uploadToS3(file, bucket)`

## Required Sections

1. **Title** - "How to: [Goal]"
2. **Context** - One sentence if needed
3. **Prerequisites** - Only task-specific requirements
4. **Steps** - Direct path to goal
5. **Verify** - How to confirm success

## Optional Sections

- **Variations** - Alternative approaches
- **Troubleshooting** - Common issues
- **See Also** - Related guides/references

## Checklist

### Essential

- [ ] Title clearly states goal
- [ ] Steps lead directly to goal
- [ ] No unnecessary explanation
- [ ] Prerequisites listed
- [ ] Commands/code tested

### Quality

- [ ] Realistic examples (not foo/bar)
- [ ] Common troubleshooting covered
- [ ] Related resources linked
- [ ] Can be completed in <15 minutes

## Anti-Patterns

### Teaching in a How-to

**Bad:**
```markdown
## Understanding CORS

CORS stands for Cross-Origin Resource Sharing. It's a security mechanism...
```

**Good:**
```markdown
## Steps

### 1. Enable CORS

\`\`\`javascript
app.use(cors({ origin: 'https://yourdomain.com' }))
\`\`\`

For details, see [CORS Reference](./cors-ref.md).
```

### Too Many Prerequisites

**Bad:** 10 prerequisites including "understanding of JavaScript"
**Good:** 2-3 specific requirements for this task

### Unnecessary Alternatives

**Bad:** Show npm, yarn, AND pnpm for every install
**Good:** Pick one. Move on.

### Excessive Context

**Bad:** 3 paragraphs before the first step
**Good:** Jump to steps quickly

## Patterns

### Migration How-to

```markdown
## Breaking Changes

| v2 | v3 |
|----|-----|
| `oldMethod()` | `newMethod()` |

## Steps

### 1. Update Dependencies
### 2. Update Imports
### 3. Run Codemods
```

### Configuration How-to

```markdown
## Steps

### 1. Set Environment Variables
### 2. Update Config File
### 3. Verify Configuration
```

### Integration How-to

```markdown
## Prerequisites

- Account with [Service]
- API key

## Steps

### 1. Install SDK
### 2. Configure
### 3. Test Integration
```

## See Also

- **Template:** `examples/howto-template.md`
