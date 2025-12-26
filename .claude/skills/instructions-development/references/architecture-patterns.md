# Architecture Patterns - Detailed Reference

Complete guide to architectural patterns for project documentation.

## Feature-Sliced Design (FSD)

**Best for**: Large React/Vue/Next.js SPAs with multiple teams

### Overview

Standardized architecture with strict dependency layers preventing spaghetti code. Enforces unidirectional dependency flow from high-level to low-level layers.

### Layers (High to Low)

1. **app** - Application initialization, providers, routing
2. **pages** - Full pages, route handlers
3. **widgets** - Autonomous blocks (header, sidebar)
4. **features** - User interactions (add-to-cart, login)
5. **entities** - Business entities (user, product)
6. **shared** - Reusable utilities, UI kit

### Dependency Rules

```
app ──→ pages ──→ widgets ──→ features ──→ entities ──→ shared
  ↓       ↓         ↓           ↓           ↓
  ✓       ✓         ✓           ✓           ✓

Lower layers CANNOT import from higher layers
```

### Structure Example

```
src/
├── app/
│   ├── providers/
│   └── router/
├── pages/
│   ├── home/
│   └── profile/
├── widgets/
│   ├── header/
│   └── sidebar/
├── features/
│   ├── auth/
│   └── cart/
├── entities/
│   ├── user/
│   └── product/
└── shared/
    ├── ui/
    └── lib/
```

### Key Principles

- **Public API**: Each slice exports via `index.ts`
- **Colocation**: Related code stays together
- **Business value organization**: Not by technical role
- **Segment structure**: ui/, model/, api/, lib/ within slices

### When to Use

- ✅ Large SPAs (>50k lines)
- ✅ Multiple developers/teams
- ✅ Complex user workflows
- ✅ Need strict boundaries

### When NOT to Use

- ❌ Small projects (<10k lines)
- ❌ Simple CRUD apps
- ❌ Backend/API services
- ❌ Team unfamiliar with pattern

### Template for CLAUDE.md

```markdown
## Architecture: Feature-Sliced Design

Standardized frontend architecture preventing spaghetti code through strict dependency layers. Chosen for scalability and maintainability on large SPAs.

### Key Principles

- **Strict dependency hierarchy**: app → pages → widgets → features → entities → shared
- **Lower layers cannot import from higher layers** (enforced rule)
- **Public APIs via index.ts**: Each layer exposes only what's needed
- **Organize by business value, not technical role**
- **Colocation of related code** within each slice

### Guidelines

- Use barrel exports (`index.ts`) for public APIs
- Each feature is autonomous and independently testable
- Shared code extracted only when used 3+ times
- Segment structure: ui/, model/, api/, lib/
```

---

## Feature-First

**Best for**: Backend APIs, medium-sized frontends, autonomous teams

### Overview

Simple vertical slicing by product features. Optimizes for team autonomy and rapid development without FSD's strict layering.

### Structure Example

```
src/
├── features/
│   ├── auth/
│   │   ├── login.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.model.ts
│   │   └── auth.test.ts
│   ├── users/
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   └── users.test.ts
│   └── posts/
│       ├── posts.controller.ts
│       ├── posts.service.ts
│       └── posts.test.ts
└── shared/
    ├── database/
    ├── middleware/
    └── utils/
```

### Key Principles

- **Vertical slicing**: Each feature is self-contained
- **Colocation**: Related code lives together
- **Autonomous features**: Teams work independently
- **Extract to shared/ only when used 3+ times**
- **Business language in names**: `/features/user-registration/` not `/features/form-handler/`

### When to Use

- ✅ Backend/API services
- ✅ Medium SPAs (10k-50k lines)
- ✅ Autonomous teams
- ✅ Rapid feature development

### When NOT to Use

- ❌ Need strict dependency enforcement
- ❌ Very large frontends (>100k lines)
- ❌ Framework enforces different pattern (Django, Rails)

### Template for CLAUDE.md

```markdown
## Architecture: Feature-First

Organize by product features, not technical layers. Simpler than FSD, optimizes for team autonomy and rapid feature development.

### Key Principles

- **Vertical slicing**: Each feature is self-contained with components, logic, tests
- **Colocation over separation**: Related code lives together (e.g., `features/auth/`)
- **Autonomous features**: Teams can work on features independently
- **Minimize premature abstraction**: Extract to `shared/` only when used 3+ times
- **Business language in folder names**: `/features/user-registration/` not `/features/form-handler/`

### Guidelines

- Keep features independent with minimal cross-dependencies
- Shared utilities go in `shared/` only after 3rd use
- Each feature should be testable in isolation
- Favor duplication over wrong abstraction
```

---

## Package by Feature

**Best for**: Go, Java, C#, backend microservices

### Overview

Simple vertical slicing by business domain. Pragmatic choice prioritizing maintainability over strict layering.

### Structure Example

```
cmd/
    └── api/
        └── main.go
internal/
    ├── users/
    │   ├── handler.go
    │   ├── service.go
    │   ├── repository.go
    │   └── model.go
    ├── posts/
    │   ├── handler.go
    │   ├── service.go
    │   └── repository.go
    └── auth/
        ├── middleware.go
        └── service.go
pkg/
    ├── database/
    └── logger/
```

### Key Principles

- **Group by feature, not technical layer**: `users/` contains all user code
- **High cohesion within packages**: Everything for feature together
- **Low coupling between packages**: Features are independent
- **Simple and pragmatic**: No complex rules
- **Framework-agnostic**: Works with any backend stack

### When to Use

- ✅ Go services (idiomatic)
- ✅ Java/Spring Boot
- ✅ .NET/C# services
- ✅ Backend microservices

### When NOT to Use

- ❌ Framework enforces different pattern
- ❌ Frontend SPAs (use FSD or Feature-First)

### Template for CLAUDE.md

```markdown
## Architecture: Package by Feature

Simple vertical slicing by business domain. Pragmatic choice for backend services prioritizing maintainability over strict layering.

### Key Principles

- **Group by feature, not technical layer**: `users/` contains all user-related code
- **High cohesion within packages**: Everything for a feature is together
- **Low coupling between packages**: Features are independent
- **Simple and pragmatic**: No complex rules or abstractions
- **Framework-agnostic**: Works with any backend stack

### Guidelines

- Each package should be independently understandable
- Shared code goes in `pkg/` (public) or `internal/shared/` (private)
- Avoid circular dependencies between packages
- Keep package APIs minimal and focused
```

---

## MVC (Model-View-Controller)

**Best for**: Django, Rails, frameworks that enforce it

### Overview

Traditional layered architecture separating data (Model), presentation (View), and logic (Controller). Use when framework enforces or team is familiar.

### Structure Example

```
app/
├── models/
│   ├── user.py
│   └── post.py
├── views/
│   ├── user_views.py
│   └── post_views.py
├── controllers/
│   ├── user_controller.py
│   └── post_controller.py
├── services/
│   └── email_service.py
└── templates/
    └── user/
        └── profile.html
```

### Key Principles

- **Separation of concerns**: Models (data), Views (presentation), Controllers (logic)
- **Follow framework conventions**: Don't fight the framework
- **Keep controllers thin**: Business logic belongs in models/services
- **Services for complex operations**: Extract business logic when needed
- **Convention over configuration**: Leverage framework defaults

### When to Use

- ✅ Django projects
- ✅ Ruby on Rails
- ✅ Laravel/PHP
- ✅ Framework enforces MVC

### When NOT to Use

- ❌ Framework doesn't enforce it
- ❌ Need feature-based organization

### Template for CLAUDE.md

```markdown
## Architecture: MVC (Model-View-Controller)

Traditional layered architecture. Use when framework enforces it (Django, Rails) or team is already familiar with this pattern.

### Key Principles

- **Separation of concerns**: Models (data), Views (presentation), Controllers (logic)
- **Follow framework conventions**: Don't fight the framework
- **Keep controllers thin**: Business logic belongs in models/services
- **Services for complex operations**: Extract business logic from models when needed
- **Convention over configuration**: Leverage framework defaults

### Guidelines

- Fat models, thin controllers
- Extract complex business logic to services
- Views should only handle presentation
- Follow framework's official guidelines
- Use framework ORM properly (avoid raw SQL)
```

---

## Choosing the Right Pattern

### Decision Tree

```
Is it a frontend SPA?
├─ Yes → Is it >50k lines with multiple teams?
│  ├─ Yes → Feature-Sliced Design (FSD)
│  └─ No → Feature-First
│
└─ No → Is it backend/API?
   ├─ Go/Java/C# → Package by Feature
   ├─ Django/Rails → MVC
   └─ Express/Flask/FastAPI → Feature-First
```

### Quick Comparison

| Pattern | Complexity | Team Size | Best For | Strictness |
|---------|-----------|-----------|----------|------------|
| **FSD** | High | Large (5+) | Large SPAs | Very Strict |
| **Feature-First** | Low | Any | APIs, medium SPAs | Flexible |
| **Package by Feature** | Low | Any | Backend services | Simple |
| **MVC** | Medium | Any | Framework-enforced | Framework rules |

---

## Common Mistakes

### Over-Engineering

❌ **Bad**: Using FSD for 5k line project
```
Unnecessary complexity for small codebase
```

✅ **Good**: Feature-First for small projects
```
Simple, easy to understand, room to grow
```

### Fighting Framework

❌ **Bad**: Forcing Feature-First on Django
```
Django expects MVC, creates friction
```

✅ **Good**: Follow Django conventions (MVC)
```
Leverage framework strengths
```

### Premature Abstraction

❌ **Bad**: Creating shared/ immediately
```
Extract to shared/ after 3+ uses, not before
```

✅ **Good**: Duplicate first, abstract later
```
Wait until pattern is clear (3+ uses)
```

### Wrong Language

❌ **Bad**: Technical names
```
/features/form-handler/
/features/data-fetcher/
```

✅ **Good**: Business names
```
/features/user-registration/
/features/product-catalog/
```

---

## Migration Strategies

### From No Pattern to Feature-First

1. Identify existing features
2. Create `features/` directory
3. Move related files to feature folders
4. Extract common code to `shared/`
5. Update imports

### From Flat to FSD

1. Identify FSD layers in existing code
2. Create layer directories
3. Move components to appropriate layers
4. Create `index.ts` barrel exports
5. Enforce dependency rules via linter

### From MVC to Feature-First

Only if framework allows:
1. Group models/views/controllers by feature
2. Create feature folders
3. Move related MVC files together
4. Extract cross-feature code to shared

**Note**: Don't fight framework conventions. If Django/Rails, stay with MVC.

---

## Path Patterns for .claude/rules/

### FSD Projects

```yaml
---
paths: src/{pages,widgets,features}/**/*.{ts,tsx}
---
```

### Feature-First Projects

```yaml
---
paths: src/features/**/*
---
```

### Package by Feature (Go)

```yaml
---
paths: internal/**/*.go
---
```

### MVC Projects

```yaml
---
paths: app/{models,views,controllers}/**/*
---
```
