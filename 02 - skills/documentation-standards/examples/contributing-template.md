# CONTRIBUTING.md Template

A concrete example of a welcoming CONTRIBUTING.md following documentation standards.

---

# Contributing to [Project Name]

First off, thank you for considering contributing! Every contribution helps make this project better.

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

- [ ] Check [existing issues](https://github.com/org/repo/issues) first
- [ ] Search closed issues too

When submitting, include:

- Clear title: `[Bug] Short description`
- Steps to reproduce
- Expected vs actual behavior
- Environment (OS, version, etc.)
- Screenshots if applicable

### Suggesting Features

- Open issue with `[Feature]` prefix
- Describe the problem it solves
- Explain your proposed solution
- Note any alternatives considered

### Contributing Code

**Good first issues** are labeled `good first issue`.

Before starting work:

1. Check if issue exists or create one
2. Comment that you're working on it
3. Wait for maintainer acknowledgment on large changes

### Improving Documentation

Documentation PRs are always welcome:

- Fix typos
- Add examples
- Clarify confusing sections

## Development Setup (~5 min)

### Prerequisites

- [ ] Node.js 18+
- [ ] npm 9+
- [ ] Git

### Local Setup

```bash
# Fork and clone
git clone https://github.com/YOUR-USERNAME/repo.git
cd repo

# Add upstream remote
git remote add upstream https://github.com/org/repo.git

# Install dependencies
npm install

# Run tests to verify setup
npm test
```

You should see all tests passing.

### Running Locally

```bash
npm run dev
```

### Running Tests

```bash
npm test              # All tests
npm test -- --watch   # Watch mode
npm run test:coverage # With coverage
```

## Pull Request Process

### Before Submitting

1. **Sync with upstream:**

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Create feature branch:**

   ```bash
   git checkout -b feature/short-description
   ```

3. **Make changes:**
   - Write/update tests
   - Follow style guidelines
   - Update docs if needed

4. **Verify:**

   ```bash
   npm run lint
   npm test
   npm run build
   ```

5. **Commit:**

   ```bash
   git commit -m "feat: add new feature"
   ```

### Commit Messages

Follow [Conventional Commits](https://conventionalcommits.org/):

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting (no code change) |
| `refactor` | Code change (no feature/fix) |
| `test` | Adding tests |
| `chore` | Maintenance |

### Submitting PR

1. Push to your fork
2. Open PR against `main` branch
3. Fill out PR template
4. Link related issues: `Closes #123`

### What to Expect

- **Initial response:** 2-3 business days
- **Code review:** ~1 week
- **Merge after approval:** 1-2 days

We're volunteers - thanks for your patience!

## Style Guidelines

### Code Style

- Use [Prettier](https://prettier.io/) for formatting
- Follow [ESLint](https://eslint.org/) rules

```bash
npm run format  # Format code
npm run lint    # Check lint
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | kebab-case | `user-service.ts` |
| Classes | PascalCase | `UserService` |
| Functions | camelCase | `getUser` |
| Constants | SCREAMING_SNAKE | `MAX_RETRIES` |

## Need Help?

- Open issue with `question` label
- Join our [Discord](https://discord.gg/...)
- Email: maintainers@project.org

---

Thank you for contributing!

---

## Why This Template Works

### Welcoming Tone

Opens with gratitude, making contributors feel valued.

### Clear Table of Contents

Easy navigation to specific sections.

### Checklist Prerequisites

Uses `- [ ]` for easy mental tracking.

### Time Estimates

Shows development setup takes ~5 min.

### Realistic Expectations

Honest about review timelines.

### Multiple Ways to Help

Bug reports, features, code, docs - everyone can contribute.
