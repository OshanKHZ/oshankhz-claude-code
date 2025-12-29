# README (Module/Library) - Complete Guide

## Purpose

Module READMEs document internal code modules. They help developers understand and use specific parts of the codebase.

## Diataxis Classification

**Reference + How-to hybrid** - Information lookup with usage guidance.

## Audience

- Team developers working with this module
- New team members onboarding
- Future maintainers

## When to Create

Create module README when:
- Module has complex API
- Module is used by multiple parts of codebase
- Non-obvious design decisions exist
- Common usage patterns should be documented

## Structure

### Required Sections

#### 1. Purpose

What problem does this module solve? Why does it exist?

```markdown
# Auth Module

Handles user authentication, session management, and token refresh.

## Purpose

Centralizes all authentication logic to:
- Ensure consistent security practices
- Provide single source of truth for auth state
- Abstract OAuth complexity from feature code
```

#### 2. API Reference

Document all exports.

```markdown
## API

### `authenticate(credentials)`

Authenticate user with email/password.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| credentials.email | string | Yes | User email |
| credentials.password | string | Yes | User password |

**Returns:** `Promise<AuthResult>`

**Throws:**
- `InvalidCredentialsError` - Wrong email/password
- `AccountLockedError` - Too many failed attempts

**Example:**
\`\`\`typescript
const result = await authenticate({
  email: 'user@example.com',
  password: 'secret'
})
\`\`\`

### `refreshToken(token)`

Refresh an expired access token.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | Refresh token |

**Returns:** `Promise<TokenPair>`
```

#### 3. Usage Examples

Show common patterns.

```markdown
## Usage

### Basic Authentication

\`\`\`typescript
import { authenticate, logout } from '@/modules/auth'

// Login
const { user, tokens } = await authenticate({
  email: 'user@example.com',
  password: 'password'
})

// Later: logout
await logout()
\`\`\`

### With React Hook

\`\`\`typescript
import { useAuth } from '@/modules/auth'

function LoginButton() {
  const { login, isLoading } = useAuth()

  return (
    <button onClick={() => login(credentials)} disabled={isLoading}>
      Login
    </button>
  )
}
\`\`\`
```

#### 4. Dependencies

What this module depends on.

```markdown
## Dependencies

### Internal
- `@/lib/api` - HTTP client for API calls
- `@/lib/storage` - Token persistence

### External
- `jose` - JWT handling
- `zod` - Input validation
```

### Optional Sections

#### Architecture Notes

For complex modules:

```markdown
## Architecture

### Token Flow

1. User authenticates via `authenticate()`
2. Server returns access + refresh tokens
3. Access token stored in memory (15min expiry)
4. Refresh token stored in secure cookie
5. `refreshToken()` called automatically before expiry

### State Management

Auth state stored in Zustand store, persisted to localStorage.
See `store.ts` for implementation.
```

#### Gotchas / Edge Cases

```markdown
## Gotchas

### Token Expiry During Request

If access token expires mid-request, the API client automatically:
1. Catches 401 response
2. Calls `refreshToken()`
3. Retries original request

You don't need to handle this manually.

### SSR Considerations

Auth state is client-only. On server:
- `useAuth()` returns `{ user: null, isLoading: true }`
- Use `getServerSession()` for server-side auth checks
```

## Checklist

### Completeness

- [ ] Purpose clearly explained
- [ ] All public exports documented
- [ ] Parameters with types and descriptions
- [ ] Return values documented
- [ ] Errors/exceptions listed
- [ ] Usage examples for common cases

### Accuracy

- [ ] Function signatures match actual code
- [ ] Examples run without modification
- [ ] No references to removed features
- [ ] Dependencies list is current

### Clarity

- [ ] Non-obvious behavior explained
- [ ] Edge cases documented
- [ ] Related modules linked

## Template

```markdown
# Module Name

Brief description of what this module does.

## Purpose

Why this module exists and what problem it solves.

## API

### `functionOne(param1, param2)`

Description.

**Parameters:**
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| param1 | string | Yes | - | Description |
| param2 | number | No | 10 | Description |

**Returns:** `ReturnType` - Description

**Example:**
\`\`\`typescript
const result = functionOne('value', 20)
\`\`\`

### `functionTwo(options)`

Description.

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| options.key | string | Yes | Description |

**Returns:** `Promise<Result>`

**Throws:**
- `ErrorType` - When X happens

## Usage

### Common Pattern

\`\`\`typescript
import { functionOne } from '@/modules/name'

// Usage example
const result = functionOne('input')
\`\`\`

### With Configuration

\`\`\`typescript
import { configure, functionOne } from '@/modules/name'

configure({ option: 'value' })
const result = functionOne('input')
\`\`\`

## Dependencies

### Internal
- `@/lib/x` - Used for Y

### External
- `package-name` - Used for Z

## Architecture

[Only if complex enough to warrant explanation]

## Gotchas

- **Issue 1**: Explanation and workaround
- **Issue 2**: Explanation and workaround

## Related

- [Other Module](./other.md) - Related functionality
```

## Anti-Patterns

### Documenting Private Functions

Only document public API. Internal helpers don't need docs.

### Copy-Pasting JSDoc

If function has good JSDoc, don't duplicate. Reference code or generate docs.

### Outdated Examples

Bad:
```typescript
// Old API
auth.login(email, password)
```

Good:
```typescript
// Current API
authenticate({ email, password })
```

Keep examples in sync with actual code.
