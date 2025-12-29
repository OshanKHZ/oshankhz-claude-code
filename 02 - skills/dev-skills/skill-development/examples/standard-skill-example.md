# Standard Skill Example

This is the recommended structure for most skills - SKILL.md with references/ and examples/.

## Structure

```
standard-skill/
├── SKILL.md
├── references/
│   └── detailed-guide.md
└── examples/
    └── working-example.sh
```

## SKILL.md

```markdown
---
name: analyzing-apis
description: This skill should be used when the user asks to "analyze API", "review REST endpoint", "check API design", or works with API specifications. Analyzes REST APIs for best practices, security, and design patterns.
version: 1.0.0
---

# Analyzing APIs

## Overview

Analyze REST APIs for design quality, security, and best practices compliance.

## Quick Start

Basic API analysis:
1. Load API specification (OpenAPI, Swagger, or code)
2. Check endpoint structure
3. Verify authentication patterns
4. Review error handling
5. Report findings

## Instructions

### 1. Load API Specification

Read API spec:
\`\`\`bash
# For OpenAPI/Swagger
Read openapi.yaml

# For code-based APIs
Grep "app\.(get|post|put|delete)" **/*.js
\`\`\`

### 2. Analyze Endpoint Structure

Check for:
- RESTful naming (nouns, not verbs)
- Proper HTTP methods
- Consistent URL patterns
- Version strategy

### 3. Verify Authentication

Review:
- Auth mechanism (JWT, OAuth, API keys)
- Token handling
- Permission checks
- Rate limiting

### 4. Check Error Handling

Ensure:
- Consistent error format
- Appropriate HTTP status codes
- Helpful error messages
- Security considerations (no data leaks)

### 5. Report Findings

Provide:
- Summary of issues by severity
- Specific recommendations
- Code examples for fixes

## Best Practices

- Focus on security first
- Check consistency across endpoints
- Verify documentation accuracy
- Consider API evolution strategy

## Additional Resources

For detailed patterns and advanced analysis:
- **`references/detailed-guide.md`** - Comprehensive API analysis patterns

For working examples:
- **`examples/working-example.sh`** - Example analysis workflow
```

## references/detailed-guide.md

```markdown
# Detailed API Analysis Guide

## Advanced Patterns

### Security Analysis

Check for:
- SQL injection vulnerabilities
- XSS attack vectors
- CSRF protection
- Authentication bypass
- Authorization flaws
- Rate limiting bypass

### Performance Analysis

Review:
- N+1 query problems
- Caching strategy
- Pagination implementation
- Response size optimization

### Design Patterns

Verify:
- HATEOAS compliance
- Resource relationship handling
- Filtering and sorting patterns
- Batch operation support

## Edge Cases

### Legacy API Integration

Handle:
- Mixed versioning strategies
- Gradual migration paths
- Backward compatibility

### Microservices

Consider:
- Service boundaries
- Inter-service communication
- Distributed transactions
- API gateway patterns

## Comprehensive Checklist

[50+ detailed checks across security, performance, design, documentation]
```

## examples/working-example.sh

```bash
#!/bin/bash
# Example API analysis workflow

echo "API Analysis Workflow"
echo "====================="

# 1. Find all API endpoints
echo "Finding endpoints..."
grep -r "app\.(get|post|put|delete)" src/api/

# 2. Check for authentication
echo "Checking authentication..."
grep -r "authenticate\|requireAuth" src/middleware/

# 3. Analyze error handling
echo "Analyzing error handling..."
grep -r "try\|catch\|throw" src/api/

# 4. Generate report
echo "Analysis complete. Review findings above."
```

## When to Use Standard Structure

Use standard structure when:
- Skill has moderate complexity
- Detailed patterns exist but aren't always needed
- Working examples help understanding
- Core workflow fits in SKILL.md (<500 lines)
- Progressive disclosure benefits skill

## Advantages

- Progressive disclosure optimization
- Detailed content available when needed
- Working examples for quick reference
- Scales better than minimal
- Still relatively simple

## Disadvantages

- Slightly more complex than minimal
- Requires maintaining multiple files
- Need to keep references synchronized

## Migration Path

Start minimal, migrate to standard when:
- SKILL.md approaching 400 lines
- Detailed patterns accumulate
- Users need working examples
- Multiple complexity levels emerge
