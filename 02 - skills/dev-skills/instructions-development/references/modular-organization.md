# Modular Organization with .claude/rules/

Complete guide to organizing project documentation using the .claude/rules/ structure.

## Overview

Claude Code supports modular documentation where:
- **CLAUDE.md**: Core standards, always loaded
- **.claude/rules/*.md**: Focused topic files, loaded by path pattern

Benefits:
- Better context management
- Path-specific rules
- Easier to maintain
- Scales with project size

## When to Use Modular Structure

### Use Modular When

- ✅ Project >10k lines of code
- ✅ Multiple distinct areas (frontend, backend, mobile)
- ✅ CLAUDE.md >500 lines
- ✅ Different rules for different file types
- ✅ Multiple teams working on codebase

### Use Single File When

- ❌ Small project (<10k lines)
- ❌ Simple structure
- ❌ Single technology stack
- ❌ Everything fits in ~250 lines

## Directory Structure

```
project/
├── CLAUDE.md                      # Core standards (100-150 lines)
└── .claude/
    └── rules/
        ├── coding-standards.md    # Naming, imports, quality
        ├── architecture.md        # Pattern details
        ├── testing.md             # Test conventions
        ├── api.md                 # API patterns (backend)
        ├── components.md          # Component patterns (frontend)
        └── database.md            # Schema, migrations (if applicable)
```

## Path-Specific Rules

### YAML Frontmatter

Rule files can have `paths` frontmatter to specify when they apply:

```yaml
---
paths: src/**/*.{ts,tsx}
---

# Content only loaded for matching files
```

### Path Pattern Syntax

Uses glob patterns:

```yaml
# All TypeScript files in src/
paths: src/**/*.{ts,tsx}

# All test files
paths: **/*.{test,spec}.*

# API routes only
paths: src/{api,routes}/**/*

# Multiple patterns
paths: |
  src/**/*.ts
  lib/**/*.js
```

### When No Path Specified

If no `paths` frontmatter, rule applies globally (loaded for all contexts).

## Core Files

### CLAUDE.md (Core Standards)

**Purpose**: Essential standards that apply everywhere
**Target length**: 100-150 lines
**Always loaded**: Yes

**Should contain**:
- Project overview and tech stack
- Core non-negotiable standards (verify-before-referencing)
- Language-specific critical rules (no `any`)
- Git conventions (brief)
- References to .claude/rules/ files

**Example structure**:

```markdown
# [Project Name]

> Core project standards - See .claude/rules/ for detailed guidelines

## Tech Stack

- **Language**: TypeScript
- **Framework**: Next.js 14
- **Architecture**: Feature-Sliced Design
- **Styling**: Tailwind CSS

## Core Standards

### Before ANY Task

- Validate task completely before starting
- Verify assumptions; ask when uncertain
- Match existing patterns and conventions
- Introduce minimal changes to achieve goals
- Consider impact and side effects

### Verify Before Referencing (CRITICAL)

**NEVER assume something exists. ALWAYS verify first.**

[...detailed verify rules...]

### TypeScript Rules

- **NEVER use `any` type** - use `unknown`, generics, or proper types
- Type all function parameters and return values
- Use strict mode in tsconfig.json

## Git Conventions

Use Conventional Commits format. See `.claude/rules/git.md` for details.

## Documentation Structure

Detailed guidelines in `.claude/rules/`:
- `coding-standards.md` - Naming, imports, quality (src/**/*.{ts,tsx})
- `architecture.md` - FSD details and patterns
- `testing.md` - Test conventions (*.test.*)
- `components.md` - Component patterns (src/components/**/*.tsx)

---

*Load .claude/rules/ files automatically based on path patterns*
```

### coding-standards.md

**Purpose**: Naming, imports, code quality
**Target length**: 150-200 lines
**Path pattern**: `src/**/*.{ts,tsx,js,jsx}`

**Template**:

```yaml
---
paths: src/**/*.{ts,tsx}
---

# Coding Standards

## Naming Conventions

### Files

- **Components**: PascalCase.tsx (e.g., `UserProfile.tsx`)
- **Pages**: kebab-case.tsx (e.g., `user-profile.tsx`)
- **Utilities**: camelCase.ts (e.g., `dateUtils.ts`)
- **Hooks**: camelCase with `use` prefix (e.g., `useAuth.ts`)
- **Constants**: SCREAMING_SNAKE_CASE.ts (e.g., `API_KEYS.ts`)

### Code

- **Functions/Variables**: camelCase (e.g., `getUserData`, `isActive`)
- **Components/Classes**: PascalCase (e.g., `UserProfile`, `AuthService`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `API_URL`, `MAX_RETRIES`)
- **Booleans**: `is/has/can/should` prefix (e.g., `isLoading`, `hasPermission`)

### Examples

```typescript
// ✅ Good
const fetchUserData = async (userId: string) => {...}
const isAuthenticated = checkAuth()
const MAX_RETRY_COUNT = 3

// ❌ Bad
const FetchUserData = async (userid: string) => {...}
const authenticated = checkAuth()
const max_retry_count = 3
```

## Import Order

```typescript
// 1. Node built-ins
import fs from 'fs'
import path from 'path'

// 2. External dependencies
import React from 'react'
import { useQuery } from '@tanstack/react-query'

// 3. Internal aliases (@/)
import { api } from '@/lib/api'
import { Button } from '@/components/ui'

// 4. Relative imports
import { UserCard } from './UserCard'
import { formatDate } from './utils'

// 5. Types (if not inline)
import type { User } from '@/types'
```

## Quality Rules

### Function Length

- **Target**: <30 lines per function
- **Hard limit**: <50 lines
- **If longer**: Extract helper functions

### Function Complexity

- **Max parameters**: 3-4 (use object parameter if more)
- **Single responsibility**: One function, one purpose
- **Early returns**: Avoid deep nesting

### Examples

```typescript
// ✅ Good - Early return, single responsibility
function validateUser(user: User): boolean {
  if (!user.email) return false
  if (!user.name) return false
  if (user.age < 18) return false
  return true
}

// ❌ Bad - Deep nesting
function validateUser(user: User): boolean {
  if (user.email) {
    if (user.name) {
      if (user.age >= 18) {
        return true
      }
    }
  }
  return false
}
```

### Code Organization

- **Colocation**: Keep related code together
- **DRY**: Extract repeated logic (3+ uses)
- **KISS**: Prefer simple solutions
- **YAGNI**: Don't add features "just in case"

## Comments

- **When to comment**: Non-obvious logic, complex algorithms, workarounds
- **When NOT to comment**: Obvious code, self-explanatory names
- **JSDoc**: For public APIs, exported functions

```typescript
// ✅ Good - Explains WHY
// Using setTimeout to debounce rapid clicks and prevent double-submission
const handleSubmit = debounce(() => {...}, 300)

// ❌ Bad - Explains WHAT (code already says this)
// This function fetches user data
function getUserData() {...}
```

## Error Handling

- Use try/catch for operations that can fail
- Provide descriptive error messages
- Don't silence errors (no empty `catch {}`)
- Propagate errors when appropriate

```typescript
// ✅ Good
try {
  const data = await fetchUser(id)
  return data
} catch (error) {
  console.error('Failed to fetch user:', error)
  throw new Error(`User fetch failed: ${error.message}`)
}

// ❌ Bad
try {
  const data = await fetchUser(id)
  return data
} catch (error) {
  // Silent failure
}
```
```

### architecture.md

**Purpose**: Detailed architectural guidelines
**Target length**: 100-150 lines
**Path pattern**: Usually global (no paths)

**Template**:

```yaml
---
# No paths - applies globally
---

# Architecture: Feature-Sliced Design

## Overview

Feature-Sliced Design (FSD) is a standardized architecture for frontend applications. It organizes code by business value and enforces strict dependency rules.

**Why FSD**: Chosen for scalability, maintainability, and clear boundaries in a large SPA.

## Layers

From high-level to low-level:

1. **app** - Application initialization, providers, routing
2. **pages** - Full pages, route handlers
3. **widgets** - Autonomous blocks (header, footer, sidebar)
4. **features** - User interactions (add-to-cart, login-form)
5. **entities** - Business entities (user, product, order)
6. **shared** - Reusable utilities, UI kit

## Dependency Rules

**STRICT RULE**: Lower layers CANNOT import from higher layers

```
app ──→ pages ──→ widgets ──→ features ──→ entities ──→ shared
```

Examples:

```typescript
// ✅ Good - Higher imports from lower
import { Button } from '@/shared/ui'        // pages → shared
import { UserCard } from '@/entities/user'  // features → entities

// ❌ Bad - Lower imports from higher
import { LoginPage } from '@/pages/login'   // entities → pages (FORBIDDEN)
import { Header } from '@/widgets/header'   // features → widgets (FORBIDDEN)
```

## Slice Structure

Each slice (feature, entity) has segments:

```
features/auth/
├── ui/              # Components
├── model/           # State, hooks, types
├── api/             # API calls
├── lib/             # Utilities
└── index.ts         # Public API (barrel export)
```

## Public APIs

**RULE**: Slices export via `index.ts` barrel exports

```typescript
// features/auth/index.ts
export { LoginForm } from './ui/LoginForm'
export { useAuth } from './model/useAuth'
export type { AuthUser } from './model/types'

// Other files import from public API only
import { LoginForm, useAuth } from '@/features/auth'
```

## Guidelines

- **Colocation**: Related code stays together within slice
- **Segment organization**: ui/, model/, api/, lib/
- **Extract to shared/ only after 3rd use**
- **Business language in names**: `features/user-registration` not `features/form-handler`
- **Independent slices**: Features should be autonomous
```

### testing.md

**Purpose**: Testing conventions and patterns
**Target length**: 80-120 lines
**Path pattern**: `**/*.{test,spec}.*`

**Template**:

```yaml
---
paths: **/*.{test,spec}.*
---

# Testing Standards

## Framework

- **Test Runner**: Jest
- **UI Testing**: React Testing Library
- **Run tests**: `npm test`
- **Run with coverage**: `npm test -- --coverage`

## Conventions

### File Location

**Colocated with source files**:

```
src/
├── components/
│   ├── Button.tsx
│   └── Button.test.tsx      # ✅ Colocated
└── features/
    └── auth/
        ├── LoginForm.tsx
        └── LoginForm.test.tsx
```

### File Naming

- **Pattern**: `*.test.tsx` (or `*.spec.tsx`)
- **Match source file**: `Button.tsx` → `Button.test.tsx`

### Test Structure

**Use Arrange-Act-Assert pattern**:

```typescript
describe('Button', () => {
  it('should call onClick when clicked', () => {
    // Arrange
    const handleClick = jest.fn()
    render(<Button onClick={handleClick}>Click me</Button>)

    // Act
    fireEvent.click(screen.getByText('Click me'))

    // Assert
    expect(handleClick).toHaveBeenCalledTimes(1)
  })
})
```

## Coverage Expectations

- **Business logic**: >70% coverage
- **UI components**: >60% coverage
- **Utilities**: >80% coverage
- **Don't chase 100%**: Focus on critical paths

## Testing Patterns

### Component Tests

```typescript
import { render, screen } from '@testing-library/react'
import { UserCard } from './UserCard'

describe('UserCard', () => {
  it('should display user name', () => {
    render(<UserCard name="John" email="john@example.com" />)
    expect(screen.getByText('John')).toBeInTheDocument()
  })
})
```

### Hook Tests

```typescript
import { renderHook } from '@testing-library/react'
import { useCounter } from './useCounter'

describe('useCounter', () => {
  it('should increment counter', () => {
    const { result } = renderHook(() => useCounter())
    act(() => result.current.increment())
    expect(result.current.count).toBe(1)
  })
})
```

### Async Tests

```typescript
it('should fetch user data', async () => {
  render(<UserProfile userId="123" />)
  expect(await screen.findByText('John Doe')).toBeInTheDocument()
})
```

## Best Practices

- Test behavior, not implementation
- Use `data-testid` sparingly (prefer semantic queries)
- Mock external dependencies (APIs, services)
- Keep tests simple and readable
- One assertion per test (when possible)
```

### api.md (Backend Projects)

**Purpose**: API design patterns and conventions
**Target length**: 100-150 lines
**Path pattern**: `src/{api,routes}/**/*`

**Template**:

```yaml
---
paths: src/{api,routes}/**/*
---

# API Standards

## Endpoint Patterns

### Naming

- **Use plural nouns**: `/users` not `/user`
- **Lowercase with hyphens**: `/user-profiles` not `/userProfiles`
- **Resource nesting**: `/users/:id/posts` for relationships
- **Max 2 levels**: Avoid `/users/:id/posts/:postId/comments/:commentId`

### Examples

```
GET    /users           # List users
GET    /users/:id       # Get user
POST   /users           # Create user
PUT    /users/:id       # Update user (full)
PATCH  /users/:id       # Update user (partial)
DELETE /users/:id       # Delete user

GET    /users/:id/posts # User's posts
```

## Request/Response Format

### Standard Response

```json
{
  "data": {
    "id": "123",
    "name": "John Doe"
  }
}
```

### Error Response

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": {
      "field": "email",
      "value": "invalid-email"
    }
  }
}
```

## Status Codes

- **200 OK**: Successful GET, PUT, PATCH, DELETE
- **201 Created**: Successful POST
- **204 No Content**: Successful DELETE (no response body)
- **400 Bad Request**: Invalid input
- **401 Unauthorized**: Missing/invalid authentication
- **403 Forbidden**: Authenticated but no permission
- **404 Not Found**: Resource doesn't exist
- **409 Conflict**: Resource conflict (e.g., duplicate email)
- **422 Unprocessable Entity**: Validation failed
- **500 Internal Server Error**: Server error

## Validation

- Validate all inputs at API boundary
- Return descriptive error messages
- Use validation library (Zod, Joi, etc.)

```typescript
// ✅ Good
const schema = z.object({
  email: z.string().email(),
  age: z.number().min(18)
})

try {
  const data = schema.parse(req.body)
} catch (error) {
  return res.status(400).json({
    error: {
      code: 'VALIDATION_ERROR',
      message: error.message
    }
  })
}
```

## Authentication

- Use Bearer tokens: `Authorization: Bearer <token>`
- Never log tokens or sensitive data
- Implement rate limiting

## Pagination

```
GET /users?page=1&limit=20&sort=createdAt&order=desc
```

Response:

```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "totalPages": 8
  }
}
```
```

## Managing Rules

### Adding New Rule File

1. Create file in `.claude/rules/`
2. Add YAML frontmatter with `paths` (if needed)
3. Write focused content (<200 lines)
4. Reference in CLAUDE.md

### Updating Existing Rules

1. Read rule file
2. Analyze matching code patterns
3. Show preview of changes
4. Get user confirmation
5. Update file

### Splitting Large Rule

If rule >200 lines:
1. Identify subtopics
2. Create separate files (e.g., `testing.md` → `testing-unit.md`, `testing-e2e.md`)
3. Use more specific path patterns
4. Update references

## Best Practices

### File Organization

- ✅ One topic per file
- ✅ Files <200 lines
- ✅ Descriptive filenames (coding-standards.md not cs.md)
- ✅ Use path patterns when applicable

### Content Quality

- ✅ Concrete examples, not abstract theory
- ✅ Explain WHY, not just WHAT
- ✅ Include code examples
- ✅ Show good vs bad patterns

### Path Patterns

- ✅ Specific but stable (`src/**/*.ts`)
- ✅ Use multiple patterns if needed
- ❌ Overly specific (`src/components/ui/buttons/PrimaryButton.tsx`)
- ❌ Too broad (`**/*`)

## Anti-Patterns

### Content Anti-Patterns

- ❌ Duplicating CLAUDE.md content in rules
- ❌ Including line counts, statistics, dates
- ❌ Writing obvious/framework-enforced conventions
- ❌ Creating tiny files (<50 lines) for simple topics

### Organization Anti-Patterns

- ❌ Too many files (>10 rule files is usually too many)
- ❌ Overly fragmented topics
- ❌ No path patterns when they would help
- ❌ Path patterns that match everything

## Migration Path

### From Single File to Modular

1. **Read CLAUDE.md** and identify sections
2. **Think**: What's core vs detailed?
3. **Core stays**: Overview, core standards, git basics
4. **Details move**: Coding standards, architecture details, testing
5. **Create rule files** with moved content
6. **Add path patterns** where appropriate
7. **Update CLAUDE.md** with references
8. **Verify**: Check nothing duplicated

### Example Migration

**Before** (CLAUDE.md - 800 lines):
```markdown
# Project
## Core Standards (50 lines)
## Coding Standards (200 lines)
## Architecture (150 lines)
## Testing (100 lines)
## API (120 lines)
## Database (80 lines)
## Git (100 lines)
```

**After** (CLAUDE.md - 120 lines):
```markdown
# Project
## Core Standards (50 lines)
## Git Conventions (30 lines)
## Documentation Structure (40 lines)
  - coding-standards.md
  - architecture.md
  - testing.md
  - api.md
  - database.md
```

**.claude/rules/** (5 files):
- coding-standards.md (180 lines, path: src/**/*.ts)
- architecture.md (140 lines)
- testing.md (90 lines, path: **/*.test.*)
- api.md (110 lines, path: src/api/**/*)
- database.md (75 lines)

Total reduction: 800 lines → 715 lines across 6 files (better organized, path-aware)
