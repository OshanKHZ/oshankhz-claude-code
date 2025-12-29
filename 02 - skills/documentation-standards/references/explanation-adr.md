# Explanation / Architecture Decision Record - Complete Guide

## Purpose

Explanation documentation provides understanding. It answers "WHY" - context, reasoning, background, and implications.

## Diataxis Classification

**Explanation** - Understanding-oriented, context-rich.

## Key Characteristics

- **WHY-focused**: Reasoning and context, not procedures
- **Long half-life**: Stays relevant even as code changes
- **Connective**: Links concepts together
- **Background**: History and evolution
- **Trade-offs**: Pros, cons, alternatives considered

## Audience

- Developers needing to understand system design
- New team members understanding decisions
- Future maintainers wondering "why was this done?"
- Anyone asking "but why?"

## When to Write Explanation Docs

- Major architectural decisions
- Complex design patterns
- Non-obvious technical choices
- Historical context that affects current design
- Trade-offs that future developers should understand

## ADR (Architecture Decision Record) Format

ADRs are the most common explanation document format.

### Structure

```markdown
# ADR-[NUMBER]: [Decision Title]

## Status

[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Date

YYYY-MM-DD

## Context

[Describe the situation that led to this decision]
- What problem were we solving?
- What constraints existed?
- What forces were at play?

## Decision

[State the decision clearly]

We will [decision].

## Alternatives Considered

### [Alternative 1]

[Description]

**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Why rejected:** [Reason]

### [Alternative 2]

[Same format...]

## Consequences

### Positive

- [Positive consequence 1]
- [Positive consequence 2]

### Negative

- [Negative consequence 1]
- [Negative consequence 2]

### Neutral

- [Neutral consequence - neither good nor bad, but worth noting]

## Related

- [ADR-XXX](./adr-xxx.md) - Related decision
- [Documentation](./doc.md) - Related documentation
```

## Complete ADR Example

```markdown
# ADR-003: Use Event Sourcing for Order Processing

## Status

Accepted

## Date

2024-01-15

## Context

Our e-commerce platform processes 50,000 orders daily. We need to:

1. Track complete order history for auditing
2. Support complex order state transitions (placed → paid → shipped → delivered)
3. Enable order reconstruction for customer support
4. Handle concurrent updates safely

Current approach uses traditional CRUD with a single `orders` table. Problems:
- Lost history when updating status
- Race conditions during concurrent updates
- Difficult to debug order issues
- Compliance team needs full audit trail

## Decision

We will use Event Sourcing for the order processing domain.

Orders will be stored as a sequence of events:
- `OrderPlaced`
- `PaymentReceived`
- `OrderShipped`
- `OrderDelivered`
- `OrderCancelled`

Current state derived by replaying events.

## Alternatives Considered

### Alternative 1: Audit Log Table

Add separate `order_audit_log` table to track changes.

**Pros:**
- Simple to implement
- Minimal changes to existing code
- Team familiar with pattern

**Cons:**
- Two sources of truth (order + audit log)
- Audit log can drift from actual state
- Still have race condition issues

**Why rejected:** Doesn't solve concurrent update issues, creates consistency risks.

### Alternative 2: Soft Deletes + History Table

Never update, only insert new versions.

**Pros:**
- Complete history preserved
- Simple mental model

**Cons:**
- Complex queries for current state
- Storage grows quickly
- Performance degrades over time

**Why rejected:** Query complexity too high, doesn't model domain naturally.

### Alternative 3: Change Data Capture (CDC)

Use database CDC to capture all changes.

**Pros:**
- No application code changes
- Complete history automatically

**Cons:**
- Infrastructure complexity
- Delayed capture (not real-time)
- Harder to query events

**Why rejected:** Infrastructure overhead, doesn't give domain-level events.

## Consequences

### Positive

- **Complete Audit Trail**: Every change is an immutable event
- **Debugging**: Can replay events to see exactly what happened
- **Concurrency**: Optimistic concurrency via event version numbers
- **Analytics**: Event stream enables real-time analytics
- **Customer Support**: Easy to show order timeline

### Negative

- **Learning Curve**: Team needs to learn event sourcing patterns
- **Eventual Consistency**: Read models may lag behind writes
- **Event Schema Evolution**: Need strategy for changing event structure
- **Storage**: Events accumulate over time (mitigated by snapshots)

### Neutral

- Need to build projections for common queries
- CQRS pattern likely needed for read performance
- Existing order data needs migration

## Implementation Notes

- Using EventStoreDB for event storage
- Projections built with PostgreSQL for queries
- Migration: existing orders converted to `OrderImported` events
- Team training scheduled for Q1

## Related

- [ADR-001](./adr-001.md) - Database selection (PostgreSQL for projections)
- ADR-002 - Message queue choice (affects event publishing)
- [Event Sourcing Patterns](../explanation/event-sourcing.md) - General patterns doc
```

## Non-ADR Explanation Docs

Not all explanation docs are ADRs. Use prose for:
- Concept explanations
- System overviews
- Design philosophy
- Historical context

### Structure for Concept Explanations

```markdown
# Understanding [Concept]

## What It Is

[Define the concept clearly]

## Why It Matters

[Explain significance in your context]

## How It Works

[Conceptual explanation - not procedures]

## Key Principles

### [Principle 1]

[Explanation]

### [Principle 2]

[Explanation]

## Trade-offs

[Discuss pros and cons in your context]

## Common Misconceptions

### "[Misconception 1]"

[Clarification]

## Related Concepts

- [Concept A] - How it relates
- [Concept B] - How it relates

## Further Reading

- [Link 1]
- [Link 2]
```

### Example Concept Explanation

```markdown
# Understanding Our Authentication Architecture

## What It Is

Our authentication system uses a combination of JWTs for API access and secure HTTP-only cookies for session management.

## Why This Approach

We chose this hybrid approach because:

1. **API Clients**: Need stateless tokens for service-to-service communication
2. **Web App**: Needs secure session management resistant to XSS
3. **Mobile Apps**: Need persistent authentication without cookie support

## How It Works

### Token Types

**Access Token (JWT)**
- Short-lived (15 minutes)
- Contains user ID and roles
- Used for API authorization
- Stored in memory (web) or secure storage (mobile)

**Refresh Token**
- Long-lived (7 days)
- Stored in HTTP-only cookie (web) or secure storage (mobile)
- Used only to obtain new access tokens

### Authentication Flow

1. User logs in with credentials
2. Server validates and returns both tokens
3. Access token used for API calls
4. When access token expires, refresh token obtains new one
5. If refresh token expired, user must re-authenticate

## Why Not [Alternative]?

### "Why not just use sessions?"

Sessions require server-side state. With 20+ API servers, we'd need:
- Shared session store (Redis)
- Session synchronization
- Additional infrastructure

JWTs are self-contained - any server can validate without external lookup.

### "Why not just use JWTs for everything?"

JWTs in localStorage are vulnerable to XSS. A single XSS vulnerability could steal all user tokens. HTTP-only cookies can't be accessed by JavaScript.

## Trade-offs

### Advantages

- Stateless API layer (scalable)
- Secure web sessions (XSS-resistant)
- Works for all client types

### Disadvantages

- More complex than single approach
- Token refresh logic needed in all clients
- Can't immediately revoke access tokens (must wait for expiry)

## Related

- [ADR-005: JWT Library Selection](./adr-005.md)
- [How-to: Implement Authentication](../how-to/auth.md)
- [API Reference: Auth Endpoints](../reference/auth-api.md)
```

## Checklist

### ADRs

- [ ] Status clearly stated
- [ ] Context explains WHY decision was needed
- [ ] Decision clearly stated
- [ ] Alternatives documented with pros/cons
- [ ] Consequences (positive AND negative) listed
- [ ] Related decisions linked

### Concept Explanations

- [ ] Concept clearly defined
- [ ] Significance explained
- [ ] Trade-offs discussed
- [ ] Common misconceptions addressed
- [ ] Related concepts linked

## Template (ADR)

```markdown
# ADR-[NUMBER]: [Title]

## Status

[Proposed | Accepted | Deprecated | Superseded]

## Date

YYYY-MM-DD

## Context

[What situation led to this decision?]

## Decision

We will [decision].

## Alternatives Considered

### [Alternative]

**Pros:** [list]
**Cons:** [list]
**Why rejected:** [reason]

## Consequences

### Positive
- [consequence]

### Negative
- [consequence]

## Related

- [links]
```

## Anti-Patterns

### No Alternatives

Bad: Just stating the decision without showing what else was considered
Good: Documenting 2-3 alternatives with clear reasoning

### Missing Negative Consequences

Bad: Only listing benefits
Good: Honest assessment of trade-offs

### Too Procedural

Bad: ADR that reads like a how-to guide
Good: Focus on WHY, link to how-to for procedures

### Not Updated

Bad: ADR marked "Accepted" but approach was later changed
Good: Update status to "Superseded by ADR-XXX"
