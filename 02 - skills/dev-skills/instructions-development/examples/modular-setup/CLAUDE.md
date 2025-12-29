# E-commerce Platform

## Tech Stack

- **Language**: TypeScript
- **Frontend**: Next.js 14 (App Router) + React
- **Styling**: Tailwind CSS
- **State**: Zustand + React Query
- **Architecture**: Feature-Sliced Design (FSD)
- **Testing**: Jest + React Testing Library

## Core Standards

### Before ANY Task

GEN-1 (MUST) Validate task completely before starting
GEN-2 (MUST) Verify assumptions; ask when uncertain
GEN-3 (MUST) Match existing patterns and conventions
GEN-4 (SHOULD) Introduce minimal changes to achieve goals
GEN-5 (MUST) Consider impact and side effects

### Verify Before Referencing

Never assume something exists. Always verify first.

GEN-6 (MUST) Search codebase for any function, component, type, or import before using
GEN-7 (MUST) Verify exact name and import path
GEN-8 (MUST) Confirm arguments/props are correct
GEN-9 (MUST NOT) Invent plausible names

If not found: Ask user or create explicitly.

### TypeScript Rules

TS-1 (MUST) Never use `any` type - use `unknown`, generics, or proper types
TS-2 (MUST) Type all function parameters and return values
TS-3 (MUST) Use strict mode in tsconfig.json
TS-4 (SHOULD) Prefer `interface` for objects, `type` for unions

## Architecture: Feature-Sliced Design

Standardized frontend architecture preventing spaghetti code through strict dependency layers.

### Dependency Rule

ARCH-1 (MUST) Follow strict hierarchy: app → pages → widgets → features → entities → shared
ARCH-2 (MUST NOT) Import from higher layers in lower layers

See `.claude/rules/architecture.md` for detailed guidelines.

## Git Conventions

GIT-1 (MUST) Use Conventional Commits format
GIT-2 (MUST) Keep subject <72 characters
GIT-3 (MUST) Use imperative mood ("add" not "added")
GIT-4 (MUST NOT) Mention AI/Claude in commits

Format: `<type>[scope]: <description>`

Types: feat, fix, docs, refactor, test, chore

Example:
```
feat(cart): add quantity selector to product cards
```

See `.claude/rules/git.md` for complete git guidelines.

## Documentation Structure

Detailed guidelines in `.claude/rules/`:

- **coding-standards.md** - Naming, imports, quality (src/**/*.{ts,tsx})
- **architecture.md** - FSD layers, patterns, guidelines
- **components.md** - Component patterns, composition (src/components/**/*.tsx)
- **testing.md** - Test conventions, patterns (**/*.test.*)
- **api.md** - API client patterns, error handling
- **git.md** - Complete git workflow and commit guidelines

Rules load automatically based on path patterns.
