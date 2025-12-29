# API Documentation Guidelines

Rules, tips, and best practices for creating effective API documentation.

## Purpose

API documentation provides exhaustive, accurate reference for all endpoints. Developers should find everything they need to integrate.

## Diataxis Classification

**Reference** - Information lookup, exhaustive and accurate.

## Audience

- External developers integrating with API
- Internal frontend developers
- QA engineers testing endpoints
- Technical writers creating tutorials

## Core Principles

### 1. Complete

Document ALL endpoints, parameters, and response codes. Missing info is a bug.

### 2. Accurate

Every claim verified against actual API behavior. No assumptions.

### 3. Consistent

Same format for every endpoint. Predictable structure.

### 4. Testable

Examples should work when copy-pasted.

## Required Elements Per Endpoint

1. **Endpoint Header** - Method + Path + Description
2. **Authentication** - Required scopes/tokens
3. **Request** - Headers, params, body with types
4. **Response** - All status codes with examples
5. **Examples** - Multiple languages (curl, JS, Python)

## Structure

### 1. Endpoint Header

```markdown
## POST /api/v1/users

Create a new user account.
```

### 2. Authentication

```markdown
### Authentication

Requires Bearer token with `users:write` scope.
```

### 3. Request Details

Include:

- Headers (table format)
- Path parameters
- Query parameters
- Request body (JSON + table)

### 4. Response Details

Document ALL codes:

- 2XX success responses
- 4XX client errors
- 5XX server errors

Each with example JSON payload.

### 5. Examples

Provide at least:

- cURL
- JavaScript (fetch)
- Python (requests)

All should be copy-paste ready.

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

### API Overview Page

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

## Anti-Patterns

### Missing Error Cases

**Bad:** Only document 200 OK
**Good:** Document all 4XX and 5XX responses

### Untested Examples

**Bad:** Examples that don't work when copy-pasted
**Good:** Verified examples with actual output

### Inconsistent Format

**Bad:** Mix of tables, lists, and prose for parameters
**Good:** Same table format for all endpoints

### Missing Types

**Bad:** `id` (no type)
**Good:** `id: string (UUID)`

### Stale Documentation

Keep docs in sync with code. Consider auto-generation from OpenAPI specs.

## Patterns

### Parameter Tables

```markdown
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| limit | integer | No | 20 | Results per page (1-100) |
| offset | integer | No | 0 | Results to skip |
```

### Error Response Format

```markdown
#### 400 Bad Request

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Description",
    "details": [...]
  }
}
```
```

### Rate Limit Headers

```markdown
Response Headers:
- `X-RateLimit-Limit: 100`
- `X-RateLimit-Remaining: 95`
- `X-RateLimit-Reset: 1705315800`
```

## See Also

- **Template:** `examples/api-docs-template.md`
- **Example:** `examples/good-api-doc.md`
