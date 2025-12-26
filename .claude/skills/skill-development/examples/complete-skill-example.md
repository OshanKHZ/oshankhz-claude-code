# Complete Skill Example

This is the full structure for complex skills - SKILL.md with references/, examples/, and scripts/.

## Structure

```
complete-skill/
├── SKILL.md
├── references/
│   ├── patterns.md
│   ├── advanced.md
│   └── migration.md
├── examples/
│   ├── basic-example.sh
│   ├── advanced-workflow.sh
│   └── config-template.json
└── scripts/
    ├── validate.sh
    ├── test.sh
    └── README.md
```

## SKILL.md

```markdown
---
name: comprehensive-api-security
description: This skill should be used when the user asks to "audit API security", "check API vulnerabilities", "secure API endpoints", or works with API security review. Comprehensive security audit for REST APIs with automated validation.
version: 2.0.0
---

# Comprehensive API Security

## Overview

Perform comprehensive security audit of REST APIs using automated tools and manual review patterns.

## Quick Start

Run automated security scan:
\`\`\`bash
bash scripts/validate.sh src/api/
\`\`\`

Review results and perform manual checks for identified issues.

## Instructions

### 1. Automated Security Scan

Run validation script:
\`\`\`bash
bash scripts/validate.sh [api-directory]
\`\`\`

This checks for:
- Common vulnerabilities (SQL injection, XSS, CSRF)
- Authentication issues
- Authorization flaws
- Input validation problems

### 2. Manual Security Review

Follow patterns in references/patterns.md:
- Authentication flow analysis
- Permission boundary testing
- Data exposure checks
- Rate limiting verification

### 3. Advanced Techniques

For complex scenarios, see references/advanced.md:
- OAuth 2.0 flow security
- JWT token validation
- API gateway security
- Microservices auth

### 4. Report Findings

Generate security report:
\`\`\`bash
bash scripts/test.sh --generate-report
\`\`\`

## Best Practices

- Run automated scan first
- Focus on high-severity issues
- Verify fixes don't break functionality
- Document security decisions

## Additional Resources

### Reference Files
- **`references/patterns.md`** - Common security patterns (20+ patterns)
- **`references/advanced.md`** - Advanced security techniques
- **`references/migration.md`** - Migrating to secure patterns

### Examples
- **`examples/basic-example.sh`** - Simple security check workflow
- **`examples/advanced-workflow.sh`** - Multi-stage security audit
- **`examples/config-template.json`** - Security scan configuration

### Scripts
- **`scripts/validate.sh`** - Automated security validation
- **`scripts/test.sh`** - Security test runner
- **`scripts/README.md`** - Script documentation
```

## references/patterns.md

```markdown
# Common Security Patterns

## Pattern 1: Authentication Validation

Verify authentication implementation:

\`\`\`javascript
// Check for proper token validation
// Check for secure session management
// Check for password hashing
\`\`\`

[20+ detailed security patterns]

## Pattern 2: Authorization Checks

[Detailed pattern]

## Pattern 3: Input Validation

[Detailed pattern]

[Continue for 20+ patterns]
```

## references/advanced.md

```markdown
# Advanced Security Techniques

## OAuth 2.0 Security

Comprehensive OAuth 2.0 security audit:
- Authorization code flow validation
- Token management security
- Refresh token handling
- Scope verification

[Detailed techniques for advanced scenarios]

## JWT Security

[Advanced JWT validation patterns]

## API Gateway Security

[Gateway-specific security considerations]

[Extensive advanced content]
```

## references/migration.md

```markdown
# Migrating to Secure Patterns

## From Basic Auth to OAuth 2.0

Step-by-step migration:
1. Set up OAuth provider
2. Implement auth flow
3. Migrate endpoints gradually
4. Deprecate basic auth
5. Monitor and validate

## From Session to JWT

[Detailed migration guide]

## Security Upgrade Checklist

[Comprehensive checklist for upgrades]
```

## examples/basic-example.sh

```bash
#!/bin/bash
# Basic security check workflow

echo "Running basic security checks..."

# 1. Check for hardcoded secrets
echo "Checking for secrets..."
grep -r "password.*=.*['\"]" src/ && echo "⚠️ Found hardcoded passwords"

# 2. Check for SQL injection vectors
echo "Checking for SQL injection..."
grep -r "query.*+.*req\." src/ && echo "⚠️ Potential SQL injection"

# 3. Check for XSS vulnerabilities
echo "Checking for XSS..."
grep -r "innerHTML.*req\." src/ && echo "⚠️ Potential XSS"

echo "Basic checks complete"
```

## examples/advanced-workflow.sh

```bash
#!/bin/bash
# Multi-stage comprehensive security audit

echo "Comprehensive Security Audit"
echo "==========================="

# Stage 1: Static analysis
echo "Stage 1: Static Analysis"
bash scripts/validate.sh src/

# Stage 2: Authentication review
echo "Stage 2: Authentication Review"
grep -r "authenticate\|login\|auth" src/auth/

# Stage 3: Authorization checks
echo "Stage 3: Authorization Review"
grep -r "authorize\|permission\|role" src/middleware/

# Stage 4: Input validation
echo "Stage 4: Input Validation"
grep -r "validate\|sanitize" src/validators/

# Stage 5: Generate report
echo "Stage 5: Generating Report"
bash scripts/test.sh --generate-report

echo "Audit complete. Review report.html"
```

## examples/config-template.json

```json
{
  "scanSettings": {
    "severity": ["high", "critical"],
    "categories": ["auth", "injection", "xss", "csrf"],
    "excludePaths": ["node_modules/", "test/"]
  },
  "reportFormat": "html",
  "outputPath": "./security-report.html"
}
```

## scripts/validate.sh

```bash
#!/bin/bash
# Automated security validation script

set -euo pipefail

API_DIR="${1:-.}"

echo "Validating API security in: $API_DIR"

# Check 1: Hardcoded secrets
echo "✓ Checking for hardcoded secrets..."
if grep -r "password\|secret\|api_key" "$API_DIR" | grep -v "process.env"; then
  echo "⚠️ Found potential hardcoded secrets"
  exit 1
fi

# Check 2: SQL injection
echo "✓ Checking for SQL injection vectors..."
if grep -r "query.*+.*req\." "$API_DIR"; then
  echo "⚠️ Found potential SQL injection"
  exit 1
fi

# Check 3: XSS
echo "✓ Checking for XSS vulnerabilities..."
if grep -r "innerHTML.*req\." "$API_DIR"; then
  echo "⚠️ Found potential XSS"
  exit 1
fi

echo "✅ All automated checks passed"
```

## scripts/test.sh

```bash
#!/bin/bash
# Security test runner

set -euo pipefail

GENERATE_REPORT=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --generate-report)
      GENERATE_REPORT=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "Running security tests..."

# Run test suite
npm test -- --testPathPattern=security

if [ "$GENERATE_REPORT" = true ]; then
  echo "Generating security report..."
  npm run security:report
fi

echo "Tests complete"
```

## scripts/README.md

```markdown
# Security Scripts

## validate.sh

Automated security validation script.

**Usage:**
\`\`\`bash
bash scripts/validate.sh [api-directory]
\`\`\`

**Checks:**
- Hardcoded secrets
- SQL injection vectors
- XSS vulnerabilities
- CSRF protection

**Exit codes:**
- 0: All checks passed
- 1: Security issues found

## test.sh

Security test runner.

**Usage:**
\`\`\`bash
bash scripts/test.sh [--generate-report]
\`\`\`

**Options:**
- `--generate-report`: Generate HTML security report

**Requirements:**
- Node.js and npm
- Test suite in `test/security/`
```

## When to Use Complete Structure

Use complete structure when:
- Skill has high complexity
- Multiple levels of detail needed (basic → advanced)
- Automated tools complement manual review
- Users benefit from utilities and helpers
- Progressive disclosure is critical
- Content would exceed 500 lines in single file

## Advantages

- Maximum progressive disclosure
- Automated tools reduce manual work
- Scales to very complex domains
- Clear separation of concerns
- Utilities are executable (scripts/)
- Examples show real workflows

## Disadvantages

- Most complex to maintain
- Requires synchronization across files
- Higher initial setup cost
- More files to keep up-to-date

## Migration Path

Evolve from standard to complete when:
- Adding automated validation tools
- Multiple reference files accumulate
- Users need working scripts
- Complexity requires full structure

## Best Practices for Complete Skills

1. **Keep SKILL.md focused** (300-400 lines)
2. **Organize references by topic** (patterns, advanced, migration)
3. **Provide working examples** that users can run
4. **Document scripts thoroughly** (README.md in scripts/)
5. **Test scripts before distribution**
6. **Version the skill** to track changes
7. **Use consistent naming** across files
