# CONTRIBUTING.md Guidelines

Rules, tips, and best practices for creating effective contribution guides.

## Purpose

CONTRIBUTING.md tells potential contributors how to participate in the project. It reduces friction and sets expectations.

## Diataxis Classification

**How-to** - Goal-oriented guide for contributing.

## Core Principles

### 1. Lower the Barrier

Make it easy to start. Don't overwhelm with rules.

**Good:** Simple 4-step PR process
**Bad:** 15-step checklist with mandatory sign-offs

### 2. Set Clear Expectations

What happens after they submit? How long to wait for review?

**Good:** "Expect initial feedback within 48 hours"
**Bad:** "Submit your PR and wait for review"

### 3. Be Welcoming

First-time contributors are valuable. Make them feel welcome.

**Good:** "New to open source? We're happy to help!"
**Bad:** "DO NOT submit PRs without reading ALL documentation"

### 4. Only Document What Exists

Don't write about processes you don't have.

**Good:** Document actual test command that works
**Bad:** Mention test requirements when tests don't exist

## Required Sections

1. **How to Contribute** - Overview of ways to help
2. **Reporting Bugs** - How to submit good bug reports
3. **Development Setup** - Getting local env running (with time estimate)
4. **Pull Request Process** - What to do before/after PR
5. **Code of Conduct** - Behavior expectations (or link)

## Optional Sections

- Suggesting Features
- Commit Message Guidelines
- Code Style
- Testing Requirements
- Priority Areas (good first issues)
- Recognition/Credits
- Response Timeline

## Checklist

### Essential

- [ ] How to report bugs
- [ ] How to set up dev environment
- [ ] How to submit PR
- [ ] Code of conduct (or link to it)

### Quality

- [ ] Welcoming tone
- [ ] Clear expectations
- [ ] Realistic timelines mentioned
- [ ] Links to good first issues
- [ ] Contact method for questions

### Accuracy

- [ ] Setup instructions tested
- [ ] Commands actually work
- [ ] Links not broken
- [ ] Reflects actual project practices

## Anti-Patterns

### Too Many Rules

**Bad:**
```markdown
1. All commits must be signed
2. All PRs must have 100% test coverage
3. All code must pass 15 different linters
...
```

**Good:**
```markdown
- Run tests before submitting
- Follow existing code style
- Keep PRs focused and small
```

### No Response Timeline

**Bad:** "Submit your PR and wait for review"
**Good:** "Expect initial feedback within 48 hours. If no response in a week, feel free to ping."

### Unwelcoming Tone

**Bad:** "DO NOT submit PRs without reading ALL documentation first."
**Good:** "New to open source? We're happy to help! Questions welcome."

### Outdated Instructions

Don't document processes you don't actually use. If no CI, don't mention CI checks.

## Patterns

### Good First Issues

```markdown
## Finding Something to Work On

- Look for `good first issue` label
- Check `help wanted` label
- Browse open issues and comment your interest
```

### Large Changes

```markdown
### Before Starting Large Changes

For significant changes:
1. Open an issue first to discuss approach
2. Wait for maintainer feedback
3. Consider breaking into smaller PRs
```

## When to Update

Update CONTRIBUTING.md when:

- Development setup changes
- New requirements added (tests, linting)
- Review process changes
- Team capacity changes
- Tools change

## See Also

- **Template:** `examples/contributing-template.md`
