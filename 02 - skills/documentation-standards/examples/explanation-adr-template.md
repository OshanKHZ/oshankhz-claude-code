# Explanation / ADR Template

A concrete example of a well-structured Architecture Decision Record following documentation standards.

---

# ADR-001: Use PostgreSQL for Primary Database

## Status

Accepted

## Date

2024-01-15

## Context

We're building a new e-commerce platform. We need to choose a primary database.

**Requirements:**

- ACID transactions for order processing
- Complex queries for reporting
- Scalability to 1M+ users
- Team familiarity considered

**Constraints:**

- Budget: $500/month for database hosting
- Team: 3 backend developers with SQL experience
- Timeline: MVP in 3 months

**Current situation:**

- New project, no existing database
- Expected data: users, products, orders, inventory
- Read-heavy workload (80% reads, 20% writes)

## Decision

We will use **PostgreSQL** as our primary database.

Specifically:

- Managed PostgreSQL on AWS RDS
- Start with db.t3.medium instance
- Enable read replicas when needed

## Alternatives Considered

### Alternative 1: MySQL

**Pros:**

- Team has experience
- Wide hosting support
- Good performance

**Cons:**

- Less powerful JSON support
- Fewer advanced features
- MySQL-specific quirks

**Why rejected:** PostgreSQL offers better JSON support and more consistent behavior. Team can adapt quickly.

### Alternative 2: MongoDB

**Pros:**

- Flexible schema
- Good for rapid prototyping
- Horizontal scaling built-in

**Cons:**

- No ACID transactions across documents
- Team would need training
- Complex queries harder

**Why rejected:** E-commerce requires ACID transactions for order processing. Team lacks NoSQL experience.

### Alternative 3: CockroachDB

**Pros:**

- Distributed PostgreSQL
- Automatic sharding
- Strong consistency

**Cons:**

- Higher cost
- Newer, less ecosystem support
- Overkill for MVP scale

**Why rejected:** Adds complexity we don't need yet. Can migrate later if scale requires.

## Consequences

### Positive

- **ACID Compliance:** Reliable transaction support for orders
- **Rich Features:** JSON support, full-text search, CTEs
- **Team Productivity:** SQL knowledge transfers directly
- **Ecosystem:** Excellent ORM support (Prisma, TypeORM)
- **Managed Options:** Easy hosting with RDS, Supabase, etc.

### Negative

- **Scaling Ceiling:** Single-node limitations eventually
- **Operational Complexity:** May need manual sharding at scale
- **Cost:** Managed PostgreSQL more expensive than MySQL

### Neutral

- Read replicas needed for scale (common pattern)
- Connection pooling required (PgBouncer)

## Implementation Notes

- Use Prisma as ORM
- Enable `pg_stat_statements` for query monitoring
- Set up automated backups
- Connection pooling via PgBouncer

## Review Date

Revisit if we exceed 100k users or $300/month database cost.

## Related

- [ADR-002: ORM Selection](./adr-002.md)
- [Database Schema Guidelines](../reference/database-schema.md)

---

## Why This Template Works

### Clear Status and Date

Immediately shows if decision is current.

### Complete Context

Explains requirements, constraints, and situation.

### Multiple Alternatives

Shows 3+ options with honest pros/cons.

### Clear Decision Statement

Unambiguous "We will use X" declaration.

### Balanced Consequences

Lists positive AND negative outcomes honestly.

### Review Trigger

Specifies when to reconsider the decision.

### Related Links

Connects to other decisions and documentation.
