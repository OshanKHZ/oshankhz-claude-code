# API Documentation Template

A concrete example of a well-structured API endpoint documentation following documentation standards.

---

## POST /api/v1/users

Create a new user account.

### Authentication

Requires Bearer token with `users:write` scope.

### Rate Limits

- Standard: 100 requests/minute
- Burst: 20 requests/second

### Request

#### Headers

| Header | Required | Description |
|--------|----------|-------------|
| Authorization | Yes | Bearer token |
| Content-Type | Yes | Must be `application/json` |
| X-Request-ID | No | Client correlation ID |

#### Request Body

```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "role": "member"
}
```

#### Body Parameters

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| email | string | Yes | Valid email, max 255 | User's email address |
| name | string | Yes | 1-100 characters | Display name |
| role | enum | No | `member`, `admin` | User role (default: `member`) |

### Response

#### 201 Created

User successfully created.

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "name": "John Doe",
  "role": "member",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

| Field | Type | Description |
|-------|------|-------------|
| id | string (UUID) | Unique identifier |
| email | string | User's email |
| name | string | Display name |
| role | enum | User role |
| createdAt | string (ISO 8601) | Creation timestamp |
| updatedAt | string (ISO 8601) | Last update timestamp |

#### 400 Bad Request

Invalid input data.

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request body",
    "details": [
      {
        "field": "email",
        "code": "INVALID_FORMAT",
        "message": "Must be a valid email address"
      }
    ]
  }
}
```

#### 401 Unauthorized

Missing or invalid authentication.

```json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Invalid or expired token"
  }
}
```

#### 409 Conflict

Email already exists.

```json
{
  "error": {
    "code": "DUPLICATE_EMAIL",
    "message": "A user with this email already exists"
  }
}
```

#### 429 Too Many Requests

Rate limit exceeded.

```json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests",
    "retryAfter": 60
  }
}
```

Headers: `Retry-After: 60`, `X-RateLimit-Remaining: 0`

### Examples

#### cURL

```bash
curl -X POST https://api.example.com/api/v1/users \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "name": "New User"
  }'
```

#### JavaScript

```javascript
const response = await fetch('https://api.example.com/api/v1/users', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    email: 'newuser@example.com',
    name: 'New User'
  })
})

const user = await response.json()
```

#### Python

```python
import requests

response = requests.post(
    'https://api.example.com/api/v1/users',
    headers={'Authorization': f'Bearer {token}'},
    json={
        'email': 'newuser@example.com',
        'name': 'New User'
    }
)

user = response.json()
```

### Related Endpoints

- [GET /users/:id](./get-user.md) - Get user details
- [PATCH /users/:id](./update-user.md) - Update user
- [DELETE /users/:id](./delete-user.md) - Delete user

---

## Why This Template Works

### Complete Request Documentation

Every parameter documented with type, required status, and constraints.

### All Response Codes

Not just success - every error with example payload.

### Real Examples

Three languages with copy-paste ready code.

### Consistent Format

Tables for parameters, JSON for examples, same structure throughout.

### Cross-References

Links to related endpoints for easy navigation.
