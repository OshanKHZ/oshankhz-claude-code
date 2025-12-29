# Tutorial Guidelines

Rules, tips, and best practices for creating effective tutorials.

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

**Bad:** "Configure the database connection."
**Good:** "Open `config/database.js` and add: `{ url: 'postgres://...' }`"

### 2. Immediate Feedback

After each step, show how to verify it worked.

**Good:**
```markdown
Run `npm start`. You should see:
\`\`\`
Server running on http://localhost:3000
\`\`\`
```

### 3. Build Confidence

Start with easy wins. Progress to harder tasks.

**Good structure:**
- Part 1: Hello World (5 min)
- Part 2: Adding a Route (10 min)
- Part 3: Database Integration (15 min)

### 4. Avoid Distractions

Don't explain WHY. Don't offer alternatives. Stay focused on the path.

**Bad:** "We're using Express here, but you could also use Fastify, Koa..."
**Good:** "We're using Express. Let's create the first route."

### 5. Show Time Estimates

State total time and time per section upfront.

**Good:** "**Time required:** ~30 minutes"

## Required Sections

1. **Title and Outcome** - What reader will build
2. **Time Estimate** - Total duration
3. **What You'll Learn** - Skills gained
4. **Prerequisites** - Checklist format with `- [ ]`
5. **Setup Section** - Getting started
6. **Numbered Parts** - With checkpoints
7. **Summary** - Skills recap
8. **Troubleshooting** - Common issues
9. **Need Help?** - Next resources

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
- [ ] No alternative approaches
- [ ] Screenshots where helpful
- [ ] Copy-pasteable code blocks

## Anti-Patterns

### The "Just" Problem

Never use "just" or "simply":

**Bad:** "Just add the middleware"
**Good:** "Add this line after line 5: `app.use(cors())`"

### Teaching in a Tutorial

Save explanations for explanation docs:

**Bad:** "Express middleware works by creating a chain of functions that..."
**Good:** "Add this middleware to handle JSON requests:"

### Skipping Steps

Never skip because it seems obvious:

**Bad:** "Set up your database"
**Good:** [20 lines of explicit database setup]

### No Verification

**Bad:** "Configure the environment variables."
**Good:** "Configure the variables, then run `npm run check-env` to verify."

### Too Much at Once

Break into digestible parts with checkpoints.

## Patterns

### Checkpoint Sections

```markdown
### Checkpoint

At this point, you should have:
- [ ] Server running on port 3000
- [ ] GET / returning JSON
- [ ] No errors in terminal
```

### Troubleshooting Format

```markdown
### "Module not found" error

**Symptom:** Error when running server
**Solution:** Run `npm install` in project directory
```

### Complete Code at End

Provide full working code after tutorial for reference.

## See Also

- **Template:** `examples/tutorial-template.md`
