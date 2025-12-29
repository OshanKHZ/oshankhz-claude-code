---
name: documentation-standards
description: This skill should be used when the user asks about "documentation templates", "doc structure", "README format", "API documentation format", "how to write tutorials", "documentation checklist", or when the documentation-writer agent needs templates and workflows for specific documentation types. Provides Diataxis-based templates, checklists, and examples for 7 documentation types.
---

# Documentation Standards

Templates, workflows, and checklists for creating documentation following Diataxis principles.

## When to Use This Skill

Use when:
- Creating any type of documentation
- Need template for specific doc type
- Want checklist to verify doc completeness
- documentation-writer agent needs HOW guidance

## Diataxis Framework Quick Reference

| Quadrant | Purpose | Audience | Focus |
|----------|---------|----------|-------|
| **Tutorial** | Learning | Beginners | Hand-holding, confidence building |
| **How-to** | Goal completion | Practitioners | Steps to achieve specific goal |
| **Reference** | Information | Any level | Exhaustive, accurate lookup |
| **Explanation** | Understanding | Curious users | WHY, context, decisions |

## Documentation Types Overview

| Type | Diataxis | When to Use | Reference |
|------|----------|-------------|-----------|
| README (root) | How-to | Project entry point, setup | `references/readme-root.md` |
| README (module) | Reference + How-to | Specific module docs | `references/readme-module.md` |
| Quick Start | How-to | Fast path to working state | `references/quickstart.md` |
| CONTRIBUTING | How-to | Guide for contributors | `references/contributing.md` |
| API docs | Reference | Endpoint documentation | `references/api-docs.md` |
| Tutorial | Tutorial | Onboarding, learning | `references/tutorial.md` |
| How-to guide | How-to | Specific task completion | `references/how-to.md` |
| Reference | Reference | Exhaustive information | `references/reference-docs.md` |
| Explanation/ADR | Explanation | Architecture decisions, WHY | `references/explanation-adr.md` |

## Quick Decision Tree

```
What does the reader need?
├─ Learn something new → Tutorial
├─ Accomplish a specific task → How-to
├─ Look up information → Reference
└─ Understand why/context → Explanation
```

## Type Summaries and Checklists

### Type 1: README (Root Project)

**Diataxis**: How-to (goal: get project running)

**Required Sections:**
1. Title + One-liner
2. Quick Start (fastest path to working)
3. Installation (step-by-step)
4. Usage (basic examples)
5. License

**Checklist:**
- [ ] Can someone get running in <5 minutes?
- [ ] Prerequisites clearly stated?
- [ ] Installation steps verified to work?
- [ ] Basic usage example included?

**See `references/readme-root.md` for template**

---

### Quick Start Guide

**Diataxis**: How-to (goal: get running FAST)

**When to Create:** If README Quick Start section > 10 lines

**Required Sections:**
1. Time estimate upfront
2. Prerequisites (minimal)
3. Steps with expected output
4. Verification that it works
5. Next steps links

**Checklist:**
- [ ] Time-boxed (stated upfront)?
- [ ] Every command copy-paste ready?
- [ ] Expected output shown for each step?
- [ ] Ends with verifiable working state?

**See `references/quickstart.md` for template**

---

### CONTRIBUTING.md

**Diataxis**: How-to (goal: enable contributions)

**Required Sections:**
1. How to Contribute (overview)
2. Reporting Bugs
3. Development Setup
4. Pull Request Process
5. Code of Conduct (or link)

**Checklist:**
- [ ] Welcoming tone?
- [ ] Setup instructions tested?
- [ ] PR process clear?
- [ ] Response timeline mentioned?

**See `references/contributing.md` for template**

---

### Type 2: README (Module/Library)

**Diataxis**: Reference + How-to hybrid

**Required Sections:**
1. Purpose - What problem does this module solve?
2. API - Functions/classes exported
3. Usage Examples - Common use cases
4. Dependencies - What this module depends on

**Checklist:**
- [ ] Purpose clearly stated?
- [ ] All exports documented?
- [ ] Examples for main use cases?

**See `references/readme-module.md` for template**

---

### Type 3: API Documentation

**Diataxis**: Reference (exhaustive, accurate)

**Required Sections:**
1. Endpoint - Method + Path
2. Authentication - Requirements
3. Request - Headers, params, body
4. Response - Success + all error cases
5. Examples - curl/code

**Checklist:**
- [ ] All parameters documented with types?
- [ ] All response codes covered?
- [ ] Request/response examples provided?
- [ ] Authentication requirements stated?

**See `references/api-docs.md` for template**

---

### Type 4: Tutorial

**Diataxis**: Tutorial (learning-oriented)

**Core Principles:**
- Hand-holding: Every step explicit
- Confidence building: Small wins frequently
- Beginner-friendly: Assume nothing

**Required Sections:**
1. What you'll learn - Clear outcomes
2. Prerequisites - What reader needs
3. Steps - Numbered, explicit
4. Verification - How to know it worked
5. Next steps - Where to go from here

**Checklist:**
- [ ] Can a complete beginner follow?
- [ ] Each step has verification?
- [ ] No assumed knowledge?

**See `references/tutorial.md` for template**

---

### Type 5: How-to Guide

**Diataxis**: How-to (goal-oriented)

**Core Principles:**
- Goal-focused: Solve specific problem
- Assumes knowledge: Reader knows basics
- Concise: Minimum steps to goal

**Required Sections:**
1. Goal - What reader will accomplish
2. Prerequisites - Required knowledge/setup
3. Steps - Direct path to goal
4. Troubleshooting - Common issues

**Checklist:**
- [ ] Goal clearly stated?
- [ ] Steps minimal but complete?
- [ ] No unnecessary explanation?

**See `references/how-to.md` for template**

---

### Type 6: Reference Documentation

**Diataxis**: Reference (information-oriented)

**Core Principles:**
- Exhaustive: All options documented
- Accurate: 100% correct, verified against code
- Consistent: Same format throughout

**Required Sections:**
1. Overview - What this covers
2. Index/TOC - Navigation
3. Entries - Consistent format per item
4. Cross-references - Links to related

**Checklist:**
- [ ] Every option/parameter documented?
- [ ] Format consistent throughout?
- [ ] Verified against actual code?
- [ ] Types/defaults specified?

**See `references/reference-docs.md` for template**

---

### Type 7: Explanation / ADR

**Diataxis**: Explanation (understanding-oriented)

**Core Principles:**
- WHY-focused: Context and reasoning
- Long half-life: Stays relevant over time
- Contextual: Background and history

**Required Sections (ADR Format):**
1. Title - Decision being documented
2. Status - Proposed/Accepted/Deprecated
3. Context - Why decision was needed
4. Decision - What was decided
5. Alternatives - Options considered
6. Consequences - Trade-offs, implications

**Checklist:**
- [ ] Context explains WHY decision was needed?
- [ ] Alternatives considered documented?
- [ ] Trade-offs clearly stated?
- [ ] Consequences (good AND bad) listed?

**See `references/explanation-adr.md` for template**

---

## Process: Choosing the Right Type

### Step 1: Identify the Reader

Who is blocked without this doc?
- **New user** → Tutorial or README
- **Developer doing task** → How-to
- **Developer looking up info** → Reference
- **Anyone asking "why"** → Explanation

### Step 2: Identify the Need

What do they need?
- **Learn** → Tutorial
- **Do** → How-to
- **Know** → Reference
- **Understand** → Explanation

### Step 3: Get Template

Consult the reference file for that doc type.

### Step 4: Verify

Use the checklist for that doc type.

## Anti-Patterns

- **Super-documents**: Mixing all types in one doc
- **Tutorial as Reference**: Exhaustive details in learning context
- **Reference without verification**: Claims not traced to code
- **Explanation without context**: WHY without background
- **How-to with too much explanation**: Should be direct

## Additional Resources

### Reference Files (Detailed Templates)

**Essential Repo Docs:**
- **`references/readme-root.md`** - Complete root README guide with template
- **`references/quickstart.md`** - Quick Start guide for fast setup
- **`references/contributing.md`** - CONTRIBUTING.md template and guidelines

**Documentation Types:**
- **`references/readme-module.md`** - Module documentation guide with template
- **`references/api-docs.md`** - API documentation patterns with template
- **`references/tutorial.md`** - Tutorial writing guide with template
- **`references/how-to.md`** - How-to guide patterns with template
- **`references/reference-docs.md`** - Reference documentation guide with template
- **`references/explanation-adr.md`** - ADR and explanation guide with template

### Examples (Working Samples)

- **`examples/good-readme.md`** - Well-structured README
- **`examples/good-api-doc.md`** - Complete API endpoint doc
- **`examples/good-adr.md`** - Well-written ADR

---

*All documentation should be accurate, minimal, and serve a single Diataxis purpose.*
