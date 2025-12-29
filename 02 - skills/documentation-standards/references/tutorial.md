# Tutorial - Complete Guide

## Purpose

Tutorials teach by doing. They take beginners through a learning experience, building confidence through small successes.

## Diataxis Classification

**Tutorial** - Learning-oriented, hand-holding experience.

## Key Principle

**The reader learns by doing, not by reading.**

A tutorial is not documentation - it's a guided learning experience. The goal is confidence, not just knowledge transfer.

## Audience

- Complete beginners to the topic
- People who learn by doing
- New team members onboarding

## Core Principles

### 1. Hand-Holding

Every step is explicit. Never assume knowledge.

Bad:
```markdown
Configure the database connection.
```

Good:
```markdown
Open `config/database.js` and add your database URL:

\`\`\`javascript
module.exports = {
  url: 'postgresql://localhost:5432/myapp'
}
\`\`\`

Save the file.
```

### 2. Immediate Feedback

After each step, show how to verify it worked.

```markdown
### Step 3: Start the Server

Run this command:

\`\`\`bash
npm start
\`\`\`

You should see:
\`\`\`
Server running on http://localhost:3000
\`\`\`

Open http://localhost:3000 in your browser. You should see the welcome page.
```

### 3. Build Confidence

Start with easy wins. Progress to harder tasks.

```markdown
## Part 1: Hello World (5 minutes)
## Part 2: Adding a Route (10 minutes)
## Part 3: Database Integration (15 minutes)
## Part 4: Authentication (20 minutes)
```

### 4. Avoid Distractions

Don't explain WHY. Don't offer alternatives. Stay focused on the path.

Bad:
```markdown
We're using Express here, but you could also use Fastify, Koa, or Hapi.
Express uses middleware pattern which means... [500 words of explanation]
```

Good:
```markdown
We're using Express to build the API. Let's create the first route.
```

## Structure

### Required Sections

#### 1. Title and Outcome

```markdown
# Tutorial: Build a REST API

By the end of this tutorial, you'll have a working REST API with:
- User registration and login
- CRUD operations for posts
- Input validation
```

#### 2. Prerequisites

Be exhaustive. Beginners don't know what they need.

```markdown
## Prerequisites

Before starting, make sure you have:

- [ ] Node.js 18+ installed ([download](https://nodejs.org))
- [ ] A code editor (we recommend VS Code)
- [ ] A terminal/command prompt
- [ ] About 45 minutes

**Note:** This tutorial is for beginners. No prior API experience needed.
```

#### 3. Setup Section

```markdown
## Setup

### Step 1: Create Project Directory

Open your terminal and run:

\`\`\`bash
mkdir my-api
cd my-api
\`\`\`

### Step 2: Initialize npm

\`\`\`bash
npm init -y
\`\`\`

This creates a `package.json` file. You should see:

\`\`\`
Wrote to /path/to/my-api/package.json
\`\`\`
```

#### 4. Main Tutorial Steps

Number everything. Show expected output.

```markdown
## Part 1: Your First Endpoint

### Step 1: Install Express

\`\`\`bash
npm install express
\`\`\`

### Step 2: Create the Server File

Create a new file called `server.js`:

\`\`\`javascript
const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.json({ message: 'Hello World' })
})

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000')
})
\`\`\`

### Step 3: Run the Server

\`\`\`bash
node server.js
\`\`\`

Expected output:
\`\`\`
Server running on http://localhost:3000
\`\`\`

### Step 4: Test the Endpoint

Open a new terminal and run:

\`\`\`bash
curl http://localhost:3000
\`\`\`

You should see:
\`\`\`json
{"message":"Hello World"}
\`\`\`

You just created your first API endpoint.
```

#### 5. Verification / Checkpoint

After each major section:

```markdown
## Checkpoint

At this point, you should have:
- [ ] Server running on port 3000
- [ ] GET / returning JSON message
- [ ] No errors in terminal

If something isn't working, check:
1. Is the server still running? (restart with `node server.js`)
2. Did you save `server.js`?
3. Are you in the correct directory?
```

#### 6. Next Steps

```markdown
## Next Steps

Congratulations! You've built a working REST API.

Continue learning:
- [Tutorial: Add a Database](./tutorial-database.md)
- [How-to: Deploy to Production](../how-to/deploy.md)
- [Reference: Express Configuration](../reference/express-config.md)
```

## Checklist

### Before Publishing

- [ ] Complete beginner can follow from start to finish
- [ ] Every step has explicit instructions
- [ ] Every step has verification (how to know it worked)
- [ ] No assumed knowledge
- [ ] Tested on fresh environment
- [ ] Time estimate provided
- [ ] All prerequisites listed

### Quality Checks

- [ ] No unexplained jargon
- [ ] No "obvious" shortcuts
- [ ] No alternative approaches (save for how-to guides)
- [ ] Screenshots where helpful
- [ ] Copy-pasteable code blocks

## Template

```markdown
# Tutorial: [What You'll Build]

[1-2 sentences describing what reader will create]

## What You'll Learn

By the end, you'll know how to:
- [Skill 1]
- [Skill 2]
- [Skill 3]

## Prerequisites

- [ ] [Requirement 1] ([link to install])
- [ ] [Requirement 2]
- [ ] About X minutes

## Setup

### Step 1: [Setup Step]

[Explicit instructions]

\`\`\`bash
[command]
\`\`\`

You should see:
\`\`\`
[expected output]
\`\`\`

## Part 1: [First Milestone]

### Step 1: [Action]

[Instructions]

### Step 2: [Action]

[Instructions]

### Checkpoint

You should now have:
- [ ] [Verification 1]
- [ ] [Verification 2]

## Part 2: [Second Milestone]

[Continue pattern...]

## Summary

You've learned how to:
- [Skill 1]
- [Skill 2]
- [Skill 3]

## Next Steps

- [Link to next tutorial]
- [Link to related how-to]
- [Link to reference]

## Troubleshooting

### [Common Problem 1]

**Symptom:** [What reader sees]
**Solution:** [How to fix]

### [Common Problem 2]

**Symptom:** [What reader sees]
**Solution:** [How to fix]
```

## Anti-Patterns

### The "Just" Problem

Never use "just" or "simply":

Bad: "Just add the middleware"
Good: "Add this line after line 5: `app.use(cors())`"

### Teaching in a Tutorial

Save explanations for explanation docs:

Bad: "Express middleware works by creating a chain of functions that..."
Good: "Add this middleware to handle JSON requests:"

### Skipping Steps

Never skip steps because they seem obvious:

Bad: "Set up your database"
Good: [20 lines of explicit database setup instructions]

### No Verification

Bad: "Configure the environment variables."
Good: "Configure the environment variables, then run `npm run check-env` to verify."
