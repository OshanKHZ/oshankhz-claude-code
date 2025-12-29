# API Documentation - Complete Guide

## Purpose

API documentation provides exhaustive, accurate reference for all endpoints. Developers should find everything they need to integrate.

## Diataxis Classification

**Reference** - Information lookup, exhaustive and accurate.

## Audience

- External developers integrating with API
- Internal frontend developers
- QA engineers testing endpoints
- Technical writers creating tutorials

## Structure Per Endpoint

### Required Elements

#### 1. Endpoint Header

```markdown
## POST /api/v1/users

Create a new user account.
```

#### 2. Authentication

```markdown
### Authentication

Requires Bearer token with `users:write` scope.

| Scope | Permission |
|-------|------------|
| `users:write` | Create users |
| `users:admin` | Create admin users |
```

#### 3. Request Details

```markdown
### Request

#### Headers

| Header | Required | Description |
|--------|----------|-------------|
| Authorization | Yes | Bearer token |
| Content-Type | Yes | Must be `application/json` |
| X-Request-ID | No | Client correlation ID |

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| id | string (UUID) | User identifier |

#### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| include | string | - | Comma-separated: `profile,settings` |
| fields | string | all | Fields to return |

#### Request Body

\`\`\`json
{
  "email": "user@example.com",
  "name": "John Doe",
  "role": "member"
}
\`\`\`

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| email | string | Yes | Valid email, max 255 | User's email |
| name | string | Yes | 1-100 chars | Display name |
| role | enum | No | member, admin | Default: member |
```

#### 4. Response Details

```markdown
### Response

#### 201 Created

User successfully created.

\`\`\`json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "name": "John Doe",
  "role": "member",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
\`\`\`

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

\`\`\`json
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
\`\`\`

#### 401 Unauthorized

Missing or invalid authentication.

\`\`\`json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Invalid or expired token"
  }
}
\`\`\`

#### 409 Conflict

Email already exists.

\`\`\`json
{
  "error": {
    "code": "DUPLICATE_EMAIL",
    "message": "A user with this email already exists"
  }
}
\`\`\`

#### 429 Too Many Requests

Rate limit exceeded.

\`\`\`json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests",
    "retryAfter": 60
  }
}
\`\`\`

Headers:
- `Retry-After: 60`
- `X-RateLimit-Remaining: 0`
```

#### 5. Examples

```markdown
### Examples

#### cURL

\`\`\`bash
curl -X POST https://api.example.com/api/v1/users \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "name": "New User"
  }'
\`\`\`

#### JavaScript (fetch)

\`\`\`javascript
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
\`\`\`

#### Python (requests)

\`\`\`python
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
\`\`\`
```

## Document Structure

### API Overview Page

```markdown
# API Reference

Base URL: `https://api.example.com/api/v1`

## Authentication

All endpoints require Bearer token authentication.

\`\`\`bash
Authorization: Bearer YOUR_API_TOKEN
\`\`\`

Get your token at [dashboard.example.com/api-keys](https://dashboard.example.com/api-keys)

## Rate Limits

| Plan | Requests/minute |
|------|-----------------|
| Free | 60 |
| Pro | 600 |
| Enterprise | Unlimited |

## Errors

All errors return:

\`\`\`json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": []
  }
}
\`\`\`

## Endpoints

### Users
- [POST /users](#post-users) - Create user
- [GET /users](#get-users) - List users
- [GET /users/:id](#get-usersid) - Get user
- [PATCH /users/:id](#patch-usersid) - Update user
- [DELETE /users/:id](#delete-usersid) - Delete user

### Products
- [GET /products](#get-products) - List products
...
```

## Checklist

### Per Endpoint

- [ ] HTTP method and path correct
- [ ] Description clear and concise
- [ ] Authentication requirements stated
- [ ] All parameters documented with types
- [ ] All response codes covered
- [ ] Response body schema documented
- [ ] Error responses documented
- [ ] At least one code example

### API Overview

- [ ] Base URL documented
- [ ] Authentication explained
- [ ] Rate limits documented
- [ ] Error format explained
- [ ] All endpoints linked

### Accuracy

- [ ] Schemas match actual API responses
- [ ] Examples tested and working
- [ ] No references to deprecated endpoints
- [ ] Versioning clearly indicated

## Template

```markdown
## METHOD /path/:param

Brief description of what this endpoint does.

### Authentication

[Required/Optional] - [Scope requirements]

### Request

#### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| param | type | Description |

#### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| param | type | default | Description |

#### Request Body

\`\`\`json
{
  "field": "value"
}
\`\`\`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| field | type | Yes/No | Description |

### Response

#### 200 OK

\`\`\`json
{
  "field": "value"
}
\`\`\`

| Field | Type | Description |
|-------|------|-------------|
| field | type | Description |

#### 4XX/5XX Errors

| Code | Error | Description |
|------|-------|-------------|
| 400 | VALIDATION_ERROR | Invalid input |
| 401 | UNAUTHORIZED | Invalid token |
| 404 | NOT_FOUND | Resource not found |

### Example

\`\`\`bash
curl -X METHOD https://api.example.com/path \
  -H "Authorization: Bearer TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"field": "value"}'
\`\`\`
```

## Anti-Patterns

### Missing Error Cases

Document ALL error responses, not just success.

### Untested Examples

Bad: Examples that don't actually work
Good: Copy-paste ready, tested examples

### Inconsistent Format

Keep same structure across all endpoints. Developers rely on consistency.

### Missing Types

Always specify types. `id: string` not just `id`.
