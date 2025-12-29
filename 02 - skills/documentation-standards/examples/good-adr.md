# Example: Well-Written ADR

This is an example of a well-structured Architecture Decision Record following documentation standards.

---

# ADR-007: Use GraphQL for Public API

## Status

Accepted

## Date

2024-01-10

## Context

We're building a public API for our platform. Current situation:

**Business Requirements:**
- Multiple client types (web app, mobile apps, partner integrations)
- Clients need different data subsets
- High API traffic expected (100k+ requests/day)
- Developer experience is a key differentiator

**Technical Constraints:**
- Backend is microservices (8 services)
- Team has REST experience, limited GraphQL
- Need to support real-time updates for some features
- Must integrate with existing auth system

**Current Problems:**
- REST endpoints return too much data for mobile (over-fetching)
- Multiple endpoints needed for single views (under-fetching)
- API documentation frequently out of sync
- Adding fields requires careful versioning

## Decision

We will use GraphQL for our public API.

Specifically:
- Apollo Server for the GraphQL layer
- Federation to compose schemas from microservices
- Persisted queries for production performance
- REST endpoints remain for internal service-to-service communication

## Alternatives Considered

### Alternative 1: REST with JSON:API

Continue with REST, adopt JSON:API specification for consistency.

**Pros:**
- Team already knows REST
- Simpler infrastructure
- Wide tooling support
- Clear HTTP semantics

**Cons:**
- Over/under-fetching problems remain
- Sparse fieldsets help but are complex
- Multiple round trips for related data
- Manual documentation maintenance

**Why rejected:** Doesn't solve the core over/under-fetching problem well. JSON:API sparse fieldsets are awkward for complex nested data.

### Alternative 2: REST with BFF (Backend for Frontend)

Create separate REST APIs optimized for each client type.

**Pros:**
- Each client gets exactly what it needs
- Simple for each individual API
- Can optimize per client

**Cons:**
- Duplicated logic across BFFs
- Maintenance burden (3+ APIs instead of 1)
- Inconsistent behavior risk
- Team stretched thin maintaining multiple APIs

**Why rejected:** Too much duplication. Team size doesn't support maintaining multiple APIs.

### Alternative 3: gRPC with gRPC-Web

Use gRPC for all APIs, gRPC-Web for browser clients.

**Pros:**
- Strong typing with Protocol Buffers
- Excellent performance
- Built-in streaming
- Great for service-to-service

**Cons:**
- Browser support requires proxy
- Worse developer experience for public API consumers
- Less familiar to typical API consumers
- Documentation/playground not as good

**Why rejected:** Public API consumers expect REST-like experience. gRPC better suited for internal services.

## Consequences

### Positive

- **Flexible Queries:** Clients request exactly what they need
- **Single Endpoint:** One request for complex data needs
- **Self-Documenting:** Schema is the documentation
- **Type Safety:** Strongly typed schema catches errors early
- **Tooling:** GraphQL Playground for exploration
- **Evolution:** Add fields without breaking clients

### Negative

- **Learning Curve:** Team needs GraphQL training (estimated 2-3 weeks)
- **Caching Complexity:** HTTP caching doesn't work out of box (need Apollo Cache)
- **Query Complexity:** Must implement query cost analysis to prevent abuse
- **N+1 Queries:** Need DataLoader pattern to avoid performance issues
- **Error Handling:** GraphQL errors different from REST (200 with errors in body)

### Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Team inexperience | Training sessions, pair programming, start with simple schema |
| Performance issues | Query complexity limits, persisted queries, monitoring |
| Security (malicious queries) | Depth limiting, cost analysis, query whitelisting |
| Migration complexity | Keep REST for internal, GraphQL only for public API |

### Migration Plan

1. **Phase 1 (Week 1-2):** Set up Apollo Server, basic schema
2. **Phase 2 (Week 3-4):** Implement first service federation
3. **Phase 3 (Week 5-6):** Add remaining services
4. **Phase 4 (Week 7-8):** Testing, documentation, soft launch
5. **Phase 5 (Week 9+):** Gradual client migration

## Implementation Notes

### Schema Design Principles

- Connections pattern for pagination
- Relay-style IDs for global object identification
- Input types for mutations
- Custom scalars for dates, URLs, etc.

### Security Measures

```javascript
// Query complexity limit
const complexity = {
  maximumComplexity: 1000,
  variables: true,
  onComplete: (complexity) => {
    console.log(`Query complexity: ${complexity}`)
  }
}

// Depth limit
const depthLimit = require('graphql-depth-limit')
app.use(depthLimit(10))
```

### Monitoring

- Apollo Studio for schema analytics
- Query performance tracking
- Error rate monitoring
- Field usage analytics

## Related

- [ADR-003: Microservices Architecture](./adr-003.md) - Why we have multiple services
- [ADR-005: Authentication Strategy](./adr-005.md) - How auth integrates with GraphQL
- [GraphQL Schema Guidelines](../reference/graphql-guidelines.md) - Schema design standards
- [API Deprecation Policy](../reference/deprecation.md) - How we deprecate fields

## References

- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)
- [Apollo Federation](https://www.apollographql.com/docs/federation/)
- [Shopify GraphQL Design Tutorial](https://github.com/Shopify/graphql-design-tutorial)

---

## Why This ADR Works

### Clear Context

Explains the situation, constraints, and why a decision was needed.

### Multiple Alternatives

Shows 3 alternatives with honest pros/cons for each.

### Honest Consequences

Lists both positive and negative consequences. Doesn't oversell.

### Risks Addressed

Acknowledges risks and provides mitigations.

### Implementation Guidance

Includes enough detail to start implementing without being a how-to guide.

### Connected to Other Decisions

Links to related ADRs showing how decisions fit together.
