# README (Module/Library) Template

A concrete example of a well-structured module README following documentation standards.

---

# Auth Module

Handles user authentication, session management, and token refresh.

## Purpose

Centralizes all authentication logic to:

- Ensure consistent security practices
- Provide single source of truth for auth state
- Abstract OAuth complexity from feature code

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

```typescript
const result = await authenticate({
  email: 'user@example.com',
  password: 'secret'
})
```

### `refreshToken(token)`

Refresh an expired access token.

**Parameters:**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | Refresh token |

**Returns:** `Promise<TokenPair>`

**Example:**

```typescript
const { accessToken, refreshToken } = await refreshToken(oldRefreshToken)
```

### `logout()`

End the current session and invalidate tokens.

**Returns:** `Promise<void>`

**Example:**

```typescript
await logout()
```

## Usage

### Basic Authentication

```typescript
import { authenticate, logout } from '@/modules/auth'

// Login
const { user, tokens } = await authenticate({
  email: 'user@example.com',
  password: 'password'
})

// Later: logout
await logout()
```

### With React Hook

```typescript
import { useAuth } from '@/modules/auth'

function LoginButton() {
  const { login, isLoading } = useAuth()

  return (
    <button onClick={() => login(credentials)} disabled={isLoading}>
      Login
    </button>
  )
}
```

### Error Handling

```typescript
import { authenticate, InvalidCredentialsError } from '@/modules/auth'

try {
  await authenticate(credentials)
} catch (error) {
  if (error instanceof InvalidCredentialsError) {
    showError('Invalid email or password')
  } else {
    showError('Something went wrong')
  }
}
```

## Dependencies

### Internal

- `@/lib/api` - HTTP client for API calls
- `@/lib/storage` - Token persistence

### External

- `jose` - JWT handling
- `zod` - Input validation

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

## Related

- [User Module](./user.md) - User profile management
- [Permissions Module](./permissions.md) - Role-based access control

---

## Why This Template Works

### Clear Purpose

Explains what problem the module solves and why it exists.

### Complete API Reference

All public functions documented with parameters, returns, and throws.

### Real Usage Examples

Shows common patterns with realistic code.

### Architecture Notes

Explains how the module works internally for maintainers.

### Gotchas Section

Documents non-obvious behavior and edge cases.
