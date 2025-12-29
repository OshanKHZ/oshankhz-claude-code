# Minimal Skill Example

This is the simplest possible skill structure - just a SKILL.md file.

## Structure

```
minimal-skill/
└── SKILL.md
```

## SKILL.md

```markdown
---
name: quick-review
description: This skill should be used when the user asks to "quick review", "fast check", or needs rapid code review. Provides fast, focused code review for obvious issues.
---

# Quick Review

## Instructions

Perform fast code review focusing on:

1. Obvious syntax errors
2. Common security issues
3. Clear bugs or logic errors

Provide brief, actionable feedback. Skip detailed analysis - this is a quick check only.

## When to Use

Use for:
- Quick sanity checks
- Pre-commit reviews
- Fast feedback loops

For comprehensive review, use the `comprehensive-review` skill instead.
```

## When to Use Minimal Structure

Use minimal structure when:
- Skill provides simple, straightforward knowledge
- No complex workflows or scripts needed
- Content fits comfortably in <500 lines
- No need for detailed patterns or advanced techniques

## Advantages

- Simple to create and maintain
- Fast to load
- Easy to understand
- No complexity overhead

## Disadvantages

- Limited scalability
- Can't leverage progressive disclosure
- All content loaded when skill triggers
- May approach line limits quickly
