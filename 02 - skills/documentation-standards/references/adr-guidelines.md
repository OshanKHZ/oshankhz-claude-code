# ADR (Architecture Decision Record) Guidelines

Rules, tips, and best practices for creating effective ADRs and explanation documentation.

## Purpose

Explanation documentation provides understanding. It answers "WHY" - context, reasoning, background, and implications.

## Diataxis Classification

**Explanation** - Understanding-oriented, context-rich.

## Key Characteristics

- **WHY-focused:** Reasoning and context, not procedures
- **Long half-life:** Stays relevant even as code changes
- **Connective:** Links concepts together
- **Background:** History and evolution
- **Trade-offs:** Pros, cons, alternatives considered

## When to Write

- Major architectural decisions
- Complex design patterns
- Non-obvious technical choices
- Historical context that affects current design
- Trade-offs future developers should understand

## ADR Structure

```markdown
# ADR-[NUMBER]: [Decision Title]

## Status
[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Date
YYYY-MM-DD

## Context
[What situation led to this decision?]

## Decision
We will [decision].

## Alternatives Considered
### [Alternative 1]
**Pros:** ...
**Cons:** ...
**Why rejected:** ...

## Consequences
### Positive
- ...

### Negative
- ...

## Related
- [Links to related ADRs/docs]
```

## Core Principles

### 1. Focus on WHY

The decision itself is important, but the reasoning is MORE important.

**Bad:** "We chose PostgreSQL."
**Good:** "We chose PostgreSQL because we need ACID transactions for order processing and the team has SQL experience."

### 2. Document Alternatives

Show what else was considered with honest pros/cons.

Always document 2-3 alternatives minimum.

### 3. Honest Consequences

List both positive AND negative consequences. Don't oversell.

**Bad:** Only listing benefits
**Good:** "Positive: X, Y. Negative: Z, W."

### 4. Keep Updated

If a decision is superseded, update the status and link to the new ADR.

## Required Sections

1. **Status** - Current state
2. **Date** - When decided
3. **Context** - Why decision was needed
4. **Decision** - What was decided
5. **Alternatives** - Options considered
6. **Consequences** - Trade-offs (good AND bad)

## Optional Sections

- Implementation Notes
- Review Date/Trigger
- Related Decisions
- References

## Checklist

### Essential

- [ ] Status clearly stated
- [ ] Context explains WHY decision was needed
- [ ] Decision clearly stated ("We will...")
- [ ] 2+ alternatives documented with pros/cons
- [ ] Consequences (positive AND negative) listed
- [ ] Related decisions linked

### Quality

- [ ] Constraints and requirements documented
- [ ] Risks identified with mitigations
- [ ] Review trigger specified (when to reconsider)
- [ ] No overselling - honest about trade-offs

## Anti-Patterns

### No Alternatives

**Bad:** Just stating the decision
**Good:** 2-3 alternatives with clear reasoning for rejection

### Missing Negative Consequences

**Bad:** Only listing benefits
**Good:** Honest assessment including downsides

### Too Procedural

**Bad:** ADR that reads like a how-to guide
**Good:** Focus on WHY, link to how-to for procedures

### Not Updated

**Bad:** ADR marked "Accepted" but approach was later changed
**Good:** Status updated to "Superseded by ADR-XXX"

### Missing Context

**Bad:** Jump straight to decision
**Good:** Explain situation, constraints, and forces at play

## ADR Numbering

Use sequential numbers: ADR-001, ADR-002, etc.

Store in `/docs/adr/` directory.

## Status Values

| Status | Meaning |
|--------|---------|
| Proposed | Under discussion, not yet decided |
| Accepted | Decision made and in effect |
| Deprecated | No longer recommended |
| Superseded | Replaced by newer ADR |

## Concept Explanation Format

For non-ADR explanation docs:

```markdown
# Understanding [Concept]

## What It Is
[Definition]

## Why It Matters
[Significance in your context]

## How It Works
[Conceptual explanation - not procedures]

## Trade-offs
[Pros and cons]

## Common Misconceptions
["Misconception" - Clarification]

## Related Concepts
- [Concept A] - Relationship
```

## See Also

- **Template:** `examples/explanation-adr-template.md`
- **Example:** `examples/good-adr.md`
