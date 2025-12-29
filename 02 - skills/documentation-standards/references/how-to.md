# How-to Guide - Complete Guide

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

```markdown
# How to: Deploy to AWS Lambda
# How to: Configure CORS for API
# How to: Migrate from v2 to v3
```

### 2. Assumes Knowledge

Don't explain basics. Reference them if needed.

Bad:
```markdown
First, let's understand what environment variables are.
Environment variables are key-value pairs that...
```

Good:
```markdown
Set these environment variables (see [Environment Variables Reference](./env-reference.md) if needed):

\`\`\`bash
export API_KEY=your-key
export DB_URL=postgres://...
\`\`\`
```

### 3. Minimal but Complete

Every step necessary. No step unnecessary.

Bad (too much):
```markdown
### Step 1: Understanding the Config

Before we configure, let's understand what each option does...
[500 words of explanation]
```

Good (just enough):
```markdown
### Step 1: Configure

Create `.env`:

\`\`\`
API_KEY=xxx
DEBUG=false
\`\`\`
```

### 4. Real-World Scenarios

Use realistic examples, not foo/bar.

Bad:
```markdown
\`\`\`javascript
function doSomething(foo, bar) {
  return foo + bar
}
\`\`\`
```

Good:
```markdown
\`\`\`javascript
async function uploadToS3(file, bucket) {
  return s3.upload({ Bucket: bucket, Key: file.name, Body: file })
}
\`\`\`
```

## Structure

### Required Sections

#### 1. Title (Goal Statement)

```markdown
# How to: [Accomplish Specific Goal]
```

Use consistent format: "How to: " prefix.

#### 2. Goal + Context (Optional)

Quick context if needed. Keep brief.

```markdown
Configure your API to accept requests from different origins (CORS).
```

#### 3. Prerequisites

Only what's specific to this task.

```markdown
## Prerequisites

- Application running locally
- Admin access to server
- AWS CLI configured
```

#### 4. Steps

Direct path to goal.

```markdown
## Steps

### 1. Install Dependencies

\`\`\`bash
npm install cors helmet
\`\`\`

### 2. Configure Middleware

Add to `server.js`:

\`\`\`javascript
const cors = require('cors')

app.use(cors({
  origin: 'https://yourdomain.com',
  credentials: true
}))
\`\`\`

### 3. Test Configuration

\`\`\`bash
curl -I -X OPTIONS https://api.yourdomain.com/test
\`\`\`

Should return `Access-Control-Allow-Origin` header.
```

#### 5. Troubleshooting (If Common Issues)

```markdown
## Troubleshooting

### CORS errors persist

1. Check browser console for specific origin being blocked
2. Verify `origin` in config matches exactly (including protocol)
3. Clear browser cache and retry

### Preflight requests failing

Ensure OPTIONS method is allowed:

\`\`\`javascript
app.options('*', cors())
\`\`\`
```

### Optional Sections

#### Variations

When there are multiple approaches:

```markdown
## Variations

### For Development

Allow all origins:

\`\`\`javascript
app.use(cors())
\`\`\`

### For Production

Whitelist specific origins:

\`\`\`javascript
app.use(cors({
  origin: ['https://app.example.com', 'https://admin.example.com']
}))
\`\`\`
```

#### See Also

```markdown
## See Also

- [CORS Reference](./cors-reference.md) - All configuration options
- [Security Guide](./security.md) - Additional security headers
```

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

## Template

```markdown
# How to: [Goal]

[One sentence context if needed]

## Prerequisites

- [Requirement 1]
- [Requirement 2]

## Steps

### 1. [First Action]

\`\`\`bash
[command]
\`\`\`

### 2. [Second Action]

[Brief instruction]

\`\`\`javascript
[code]
\`\`\`

### 3. [Verify]

\`\`\`bash
[verification command]
\`\`\`

Expected output:
\`\`\`
[output]
\`\`\`

## Troubleshooting

### [Common Problem]

**Symptom:** [What happens]
**Fix:** [How to resolve]

## See Also

- [Related How-to](./related.md)
- [Reference Doc](./reference.md)
```

## Common Patterns

### Migration How-to

```markdown
# How to: Migrate from v2 to v3

## Breaking Changes

| v2 | v3 |
|----|-----|
| `oldMethod()` | `newMethod()` |
| `config.old` | `config.new` |

## Steps

### 1. Update Dependencies

\`\`\`bash
npm install package@3
\`\`\`

### 2. Update Imports

Find and replace:
- `package/old` → `package/new`

### 3. Update Method Calls

\`\`\`diff
- oldMethod(arg1, arg2)
+ newMethod({ first: arg1, second: arg2 })
\`\`\`

### 4. Run Codemods (Optional)

\`\`\`bash
npx package-codemod migrate-v3 ./src
\`\`\`
```

### Configuration How-to

```markdown
# How to: Configure for Production

## Steps

### 1. Set Environment Variables

\`\`\`bash
export NODE_ENV=production
export API_URL=https://api.production.com
export DB_URL=postgres://prod-server/db
\`\`\`

### 2. Update Config

\`\`\`javascript
// config/production.js
module.exports = {
  cache: true,
  logLevel: 'error',
  ssl: true
}
\`\`\`

### 3. Build

\`\`\`bash
npm run build
\`\`\`

### 4. Deploy

\`\`\`bash
npm run deploy:production
\`\`\`
```

### Integration How-to

```markdown
# How to: Add Stripe Payments

## Prerequisites

- Stripe account with API keys
- Application with user authentication

## Steps

### 1. Install Stripe SDK

\`\`\`bash
npm install stripe
\`\`\`

### 2. Configure Keys

\`\`\`bash
# .env
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
\`\`\`

### 3. Create Payment Endpoint

\`\`\`javascript
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY)

app.post('/api/payment', async (req, res) => {
  const session = await stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    line_items: req.body.items,
    success_url: 'https://yoursite.com/success',
    cancel_url: 'https://yoursite.com/cancel'
  })
  res.json({ sessionId: session.id })
})
\`\`\`

### 4. Test

Use Stripe test card: `4242 4242 4242 4242`
```

## Anti-Patterns

### Teaching in a How-to

Bad:
```markdown
## Understanding CORS

CORS stands for Cross-Origin Resource Sharing. It's a security mechanism...
[Long explanation]
```

Good:
```markdown
## Steps

### 1. Enable CORS

\`\`\`javascript
app.use(cors({ origin: 'https://yourdomain.com' }))
\`\`\`

For details on CORS options, see [CORS Reference](./cors-ref.md).
```

### Too Many Prerequisites

Bad:
```markdown
## Prerequisites
- Understanding of JavaScript
- Understanding of Node.js
- Understanding of HTTP
- Understanding of REST
- ...
```

Good:
```markdown
## Prerequisites
- Node.js project with Express
- AWS account with CLI configured
```

### Unnecessary Alternatives

Bad:
```markdown
### Step 2: Install the package

You can use npm:
\`\`\`bash
npm install package
\`\`\`

Or yarn:
\`\`\`bash
yarn add package
\`\`\`

Or pnpm:
\`\`\`bash
pnpm add package
\`\`\`
```

Good:
```markdown
### Step 2: Install

\`\`\`bash
npm install package
\`\`\`
```

Pick one. Move on.
