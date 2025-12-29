# CONTRIBUTING.md - Complete Guide

## Purpose

CONTRIBUTING.md tells potential contributors how to participate in the project. It reduces friction and sets expectations.

## Diataxis Classification

**How-to** - Goal-oriented guide for contributing.

## Audience

- Developers wanting to contribute code
- Users wanting to report bugs
- Community members wanting to help with docs
- First-time open source contributors

## Core Principles

### 1. Lower the Barrier

Make it easy to start. Don't overwhelm with rules.

### 2. Set Clear Expectations

What happens after they submit? How long to wait for review?

### 3. Be Welcoming

First-time contributors are valuable. Make them feel welcome.

### 4. Only Document What Exists

Don't write about CI/CD pipelines you don't have. Don't mention tests if there are none.

## Structure

### Required Sections

1. **How to Contribute** - Overview of ways to help
2. **Reporting Bugs** - How to submit good bug reports
3. **Development Setup** - Getting local env running
4. **Pull Request Process** - What to do before/after PR
5. **Code of Conduct** - Behavior expectations (can link to separate file)

### Optional Sections

- Suggesting Features
- Commit Message Guidelines
- Code Style
- Testing Requirements
- Priority Areas
- Recognition/Credits

## Template (Minimal)

```markdown
# Contributing

Thanks for your interest in contributing!

## Ways to Contribute

- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

## Reporting Bugs

1. Check existing issues first
2. Open new issue with:
   - Clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment (OS, version)

## Development Setup

\`\`\`bash
git clone https://github.com/org/repo.git
cd repo
npm install
npm test  # Verify setup works
\`\`\`

## Pull Request Process

1. Fork the repo
2. Create branch: `git checkout -b feature/my-feature`
3. Make changes
4. Run tests: `npm test`
5. Commit with clear message
6. Push and open PR

## Code Style

- Follow existing patterns
- Run linter before commit: `npm run lint`

## Questions?

Open an issue with the `question` label.
```

## Template (Complete)

```markdown
# Contributing to [Project]

First off, thanks for taking the time to contribute!

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project follows our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

**Quick summary:**
- Be respectful and inclusive
- Accept constructive criticism
- Focus on what's best for the community

## How Can I Contribute?

### Reporting Bugs

Before submitting:
- Check [existing issues](https://github.com/org/repo/issues)
- Search closed issues too

When submitting:
- Use the bug report template
- Include clear title: `[Bug] Short description`
- Provide:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Screenshots if applicable
  - Environment (OS, version, etc.)

### Suggesting Features

- Open issue with `[Feature]` prefix
- Describe the problem it solves
- Explain your proposed solution
- Note any alternatives you considered

### Contributing Code

Good first issues are labeled `good first issue`.

**Before starting work:**
1. Check if issue exists or create one
2. Comment that you're working on it
3. Wait for maintainer acknowledgment on large changes

### Improving Documentation

Documentation PRs are always welcome:
- Fix typos
- Add examples
- Clarify confusing sections
- Translate to other languages

## Development Setup

### Prerequisites

- Node.js 18+
- npm 9+
- Git

### Local Setup

\`\`\`bash
# Fork and clone
git clone https://github.com/YOUR-USERNAME/repo.git
cd repo

# Add upstream remote
git remote add upstream https://github.com/org/repo.git

# Install dependencies
npm install

# Run tests to verify setup
npm test
\`\`\`

### Running Locally

\`\`\`bash
npm run dev
\`\`\`

### Running Tests

\`\`\`bash
npm test              # All tests
npm test -- --watch   # Watch mode
npm run test:coverage # With coverage
\`\`\`

## Pull Request Process

### Before Submitting

1. **Sync with upstream:**
   \`\`\`bash
   git fetch upstream
   git rebase upstream/main
   \`\`\`

2. **Create feature branch:**
   \`\`\`bash
   git checkout -b feature/short-description
   \`\`\`

3. **Make changes:**
   - Write/update tests
   - Follow style guidelines
   - Update docs if needed

4. **Verify:**
   \`\`\`bash
   npm run lint
   npm test
   npm run build
   \`\`\`

5. **Commit:**
   \`\`\`bash
   git commit -m "feat: add new feature"
   \`\`\`

### Commit Messages

Follow [Conventional Commits](https://conventionalcommits.org/):

\`\`\`
<type>: <description>

[optional body]

[optional footer]
\`\`\`

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting (no code change)
- `refactor`: Code change (no feature/fix)
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
\`\`\`
feat: add user authentication
fix: resolve memory leak in cache
docs: update installation instructions
refactor: simplify database queries
\`\`\`

### Submitting PR

1. Push to your fork
2. Open PR against `main` branch
3. Fill out PR template:
   - What changed
   - Why it changed
   - How to test
4. Link related issues: `Closes #123`

### After Submitting

- Respond to review feedback
- Make requested changes
- Keep PR updated with main branch
- Be patient - maintainers are volunteers

**Review timeline:**
- Initial response: ~48 hours
- Full review: ~1 week
- Merge after approval: ~24 hours

## Style Guidelines

### Code Style

- Use [Prettier](https://prettier.io/) for formatting
- Follow [ESLint](https://eslint.org/) rules
- Max line length: 100 characters

\`\`\`bash
# Format code
npm run format

# Check lint
npm run lint
\`\`\`

### Naming Conventions

- **Files:** kebab-case (`user-service.ts`)
- **Classes:** PascalCase (`UserService`)
- **Functions:** camelCase (`getUser`)
- **Constants:** SCREAMING_SNAKE (`MAX_RETRIES`)

### Documentation

- JSDoc for public APIs
- Inline comments for complex logic
- Update README for user-facing changes

## Recognition

Contributors are listed in [CONTRIBUTORS.md](CONTRIBUTORS.md).

## Questions?

- Open issue with `question` label
- Join our [Discord](https://discord.gg/...)
- Email: maintainers@project.org

---

Thank you for contributing!
```

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

## Patterns

### Good First Issues

```markdown
## Finding Something to Work On

- Look for `good first issue` label
- Check `help wanted` label
- Browse open issues and comment your interest

**Good first issues:**
- Documentation improvements
- Adding tests
- Small bug fixes
- Typo corrections
```

### Review Timeline

Be honest about capacity:

```markdown
### What to Expect

- Initial response: 2-3 business days
- Code review: ~1 week
- Merge after approval: 1-2 days

We're a small team of volunteers. Thanks for your patience!
```

### Large Changes

```markdown
### Before Starting Large Changes

For significant changes (new features, architecture changes):

1. **Open an issue first** to discuss approach
2. **Wait for maintainer feedback** before coding
3. **Consider breaking into smaller PRs** if possible

This saves everyone time if the approach needs adjustment.
```

## Anti-Patterns

### Too Many Rules

Bad:
```markdown
## Rules

1. All commits must be signed
2. All PRs must have 100% test coverage
3. All code must pass 15 different linters
4. All commits must reference an issue
5. All PRs must be reviewed by 3 maintainers
6. ...
```

Good:
```markdown
## Guidelines

- Run tests before submitting
- Follow existing code style
- Keep PRs focused and small
```

### Outdated Instructions

Don't document what you don't have:
- No tests? Don't mention test requirements
- No CI? Don't mention CI checks
- No linter config? Don't require linting

### No Response Timeline

Bad:
```markdown
Submit your PR and wait for review.
```

Good:
```markdown
Submit your PR. Expect initial feedback within 48 hours.
If you don't hear back in a week, feel free to ping.
```

### Unwelcoming Tone

Bad:
```markdown
DO NOT submit PRs without reading ALL documentation first.
DO NOT open issues for questions.
DO NOT expect quick responses.
```

Good:
```markdown
New to open source? We're happy to help!
Questions are welcome - open an issue with the `question` label.
```

## Code of Conduct

Every CONTRIBUTING.md should reference a Code of Conduct.

### Inline (Minimal)

```markdown
## Code of Conduct

- Be respectful and inclusive
- No harassment or discrimination
- Accept constructive feedback gracefully
- Focus on what's best for the community

Violations can be reported to maintainers@project.org.
```

### Separate File (Recommended for larger projects)

```markdown
## Code of Conduct

This project follows our [Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you agree to uphold this code.
```

Use [Contributor Covenant](https://www.contributor-covenant.org/) as a starting point.

## When to Update

Update CONTRIBUTING.md when:
- Development setup changes
- New requirements added (tests, linting)
- Review process changes
- Team capacity changes
- Tools change (CI, formatters)
