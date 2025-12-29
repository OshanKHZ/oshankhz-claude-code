# Example: Professional CLAUDE.md (Single File)

Example using codified rules for clarity and scannability (~200 lines).

```markdown
# Task Management API

## Tech Stack

- **Language**: TypeScript
- **Framework**: Express.js + Node.js
- **Architecture**: Feature-First
- **Database**: PostgreSQL with Prisma ORM
- **Testing**: Jest + Supertest

## Core Standards

### Before ANY Task

GEN-1 (MUST) Validate task completely before starting
GEN-2 (MUST) Verify assumptions; ask when uncertain
GEN-3 (MUST) Match existing patterns and conventions
GEN-4 (SHOULD) Introduce minimal changes to achieve goals
GEN-5 (MUST) Consider impact and side effects

### Verify Before Referencing

Never assume something exists. Always verify first.

GEN-6 (MUST) Search codebase for any function, component, type, or import before using
GEN-7 (MUST) Verify exact name and import path
GEN-8 (MUST) Confirm arguments/props are correct
GEN-9 (MUST NOT) Invent plausible names

If not found: Ask user or create explicitly.

### TypeScript Rules

TS-1 (MUST) Never use \`any\` type - use \`unknown\`, generics, or proper types
TS-2 (MUST) Type all function parameters and return values
TS-3 (MUST) Use strict mode in tsconfig.json
TS-4 (SHOULD) Prefer \`interface\` for objects, \`type\` for unions

Example:
\`\`\`typescript
// ✅ Good
function getUserById(id: string): Promise<User> { ... }

// ❌ Bad
function getUserById(id: any): any { ... }
\`\`\`

## Architecture: Feature-First

Organize by product features, not technical layers.

### Principles

ARCH-1 (MUST) Organize by feature (\`features/tasks/\`, \`features/users/\`)
ARCH-2 (SHOULD) Each feature is self-contained (controllers, services, models, tests)
ARCH-3 (SHOULD) Colocate related code within features
ARCH-4 (SHOULD) Extract to \`shared/\` only when used 3+ times
ARCH-5 (MUST) Use business language in folder names

Structure:
\`\`\`
src/
├── features/
│   ├── tasks/
│   │   ├── tasks.controller.ts
│   │   ├── tasks.service.ts
│   │   ├── tasks.model.ts
│   │   └── tasks.test.ts
│   └── users/
│       └── ...
└── shared/
    ├── database/
    └── middleware/
\`\`\`

## Coding Standards

### Naming Conventions

**Files**:
- Controllers: \`*.controller.ts\`
- Services: \`*.service.ts\`
- Models: \`*.model.ts\`
- Tests: \`*.test.ts\`
- Utilities: camelCase.ts

**Code**:
- Functions/Variables: camelCase (\`getUserById\`, \`isActive\`)
- Classes/Types: PascalCase (\`TaskService\`, \`UserModel\`)
- Constants: SCREAMING_SNAKE_CASE (\`API_URL\`, \`MAX_RETRIES\`)
- Booleans: \`is/has/can/should\` prefix (\`isCompleted\`, \`hasPermission\`)

CS-1 (MUST) Follow naming conventions above
CS-2 (SHOULD) Use descriptive names
CS-3 (MUST) Use boolean prefixes consistently

### Import Order

CS-4 (MUST) Follow this import order:
\`\`\`typescript
// 1. Node built-ins
import fs from 'fs'

// 2. External dependencies
import express from 'express'
import { z } from 'zod'

// 3. Internal aliases (@/)
import { db } from '@/shared/database'

// 4. Relative imports
import { TaskService } from './tasks.service'

// 5. Types
import type { Request, Response } from 'express'
\`\`\`

### Quality Rules

CS-5 (SHOULD) Keep functions <30 lines (hard limit: 50)
CS-6 (SHOULD) Max 3-4 parameters (use object parameter if more)
CS-7 (MUST) Single responsibility per function
CS-8 (SHOULD) Use early returns (avoid deep nesting)
CS-9 (MUST) Handle errors explicitly (no empty \`catch {}\`)

Example:
\`\`\`typescript
// ✅ Good - Early return
function validateTask(task: Task): boolean {
  if (!task.title) return false
  if (!task.userId) return false
  return true
}

// ❌ Bad - Deep nesting
function validateTask(task: Task): boolean {
  if (task.title) {
    if (task.userId) {
      return true
    }
  }
  return false
}
\`\`\`

## API Conventions

### Endpoint Patterns

API-1 (MUST) Use plural nouns (\`/tasks\` not \`/task\`)
API-2 (MUST) Use lowercase with hyphens (\`/user-profiles\`)
API-3 (SHOULD) Nest resources appropriately (\`/users/:id/tasks\`)
API-4 (SHOULD) Limit nesting to 2 levels max

### Response Format

API-5 (MUST) Use standard response:
\`\`\`json
{
  "data": {
    "id": "123",
    "title": "Task title"
  }
}
\`\`\`

API-6 (MUST) Use standard error:
\`\`\`json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Title is required"
  }
}
\`\`\`

### Status Codes

API-7 (MUST) Use appropriate HTTP status codes:
- 200 OK - Successful GET, PUT, PATCH
- 201 Created - Successful POST
- 204 No Content - Successful DELETE
- 400 Bad Request - Invalid input
- 401 Unauthorized - Not authenticated
- 403 Forbidden - No permission
- 404 Not Found - Resource not found
- 500 Internal Server Error - Server error

## Testing

TEST-1 (MUST) Colocate tests with source (\`tasks.controller.ts\` → \`tasks.test.ts\`)
TEST-2 (MUST) Use Arrange-Act-Assert pattern
TEST-3 (SHOULD) Aim for >70% coverage on business logic
TEST-4 (SHOULD) Mock external dependencies

Example:
\`\`\`typescript
describe('TasksController', () => {
  it('should create new task', async () => {
    // Arrange
    const taskData = { title: 'New task' }

    // Act
    const response = await request(app).post('/tasks').send(taskData)

    // Assert
    expect(response.status).toBe(201)
    expect(response.body.data.title).toBe('New task')
  })
})
\`\`\`

## Git Conventions

GIT-1 (MUST) Use Conventional Commits format
GIT-2 (MUST) Keep subject <72 characters
GIT-3 (MUST) Use imperative mood ("add" not "added")
GIT-4 (MUST NOT) Mention AI/Claude in commits
GIT-5 (SHOULD) Reference issues (\`Closes #123\`)

Format:
\`\`\`
<type>[scope]: <description>

[body]

[footer]
\`\`\`

Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore

Example:
\`\`\`
feat(tasks): add task priority field

Implement priority levels (low, medium, high).

Closes #42
\`\`\`
```
