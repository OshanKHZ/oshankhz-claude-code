---
allowed-tools: Bash(git:*)
argument-hint: [--push] [--amend] [--all] [type: message]
description: Quick conventional commit with auto-generated or custom message
---

# Quick Commit

**Arguments received:** $ARGUMENTS

## Flags

Parse these flags from `$ARGUMENTS`:

| Flag | Effect |
|------|--------|
| `--push` | Push to remote after commit |
| `--amend` | Amend last commit (use with caution) |
| `--all` | Stage all changes before commit (`git add -A`) |

**Examples:**
- `/commit feat: add login` → commit with message
- `/commit --push fix: typo` → commit and push
- `/commit --all --push` → stage all, auto-generate message, push
- `/commit --amend` → amend last commit with new message

After parsing flags, the remaining text is the commit message.

## Context

Before creating the commit, you should check:
- Current branch: Run `git branch --show-current`
- Recent commits for style reference: Run `git log --oneline -5`
- Staged changes: Run `git diff --cached --stat`
- Unstaged files: Run `git status --short`

## Your Task

### 1. Check staged changes

If nothing is staged (`git diff --cached` is empty):
- Show unstaged files
- Ask user what to stage, or suggest `git add -A` if appropriate
- **Never auto-stage without confirmation**

### 2. Check for sensitive files

**NEVER commit:**
- `.env`, `.env.*` files
- `*secret*`, `*credential*`, `*.key`, `*.pem`
- `*password*`, `*token*` files

If detected in staged files, **warn and unstage them**.

### 3. Create commit message

**If `$ARGUMENTS` provided:** Use it directly as commit message.

**If empty:** Analyze staged changes and generate message.

### Conventional Commits Format

```
type(scope): description

[optional body - WHY, not WHAT]
```

**Types:**
| Type | When to use |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code change (no feat/fix) |
| `test` | Adding/updating tests |
| `chore` | Maintenance, deps, config |
| `style` | Formatting, whitespace |
| `perf` | Performance improvement |
| `ci` | CI/CD changes |

**Scope (optional):** Area affected in parentheses
- `feat(auth):` `fix(api):` `docs(readme):`

**Breaking change:** Add ! before :
- `feat!:` `refactor(api)!:`

### Message Rules (CRITICAL)

**Use IMPERATIVE mood** - like giving an order to the code:

| Good (imperative) | Bad (not imperative) |
|-------------------|----------------------|
| add user login | added user login |
| fix null pointer | fixed null pointer |
| update dependencies | updating dependencies |
| remove deprecated API | removed deprecated API |
| refactor auth module | refactored auth module |

**Mental test:** "If applied, this commit will **[your message]**"
- "If applied, this commit will **add user login**" ✅
- "If applied, this commit will **added user login**" ❌

**Length:**
- First line: max 50 characters (hard limit: 72)
- Keep it short and focused
- Body (optional): explain WHY, not WHAT

### 4. Execute commit

After generating the commit message, use AskUserQuestion to confirm:
- Show the generated commit message
- Ask if user wants to proceed with the commit
- Only execute `git commit` if user confirms

**Question format:**
```
Ready to commit with this message:
"[generated message]"

Proceed with commit?
Options:
- Yes, commit now
- No, cancel
```

If confirmed:
```bash
git commit -m "type(scope): description"
```

### 5. Handle --amend flag

If `--amend` flag present:
- Use `git commit --amend` instead
- **Warning:** Only amend if commit wasn't pushed yet
- Check with `git status` if branch is ahead of remote

### 6. Handle --push flag

If `--push` flag present:
- After successful commit, run `git push`
- If push fails (no upstream), suggest `git push -u origin <branch>`

### 7. Show result

After commit, show:
- Commit hash
- Files changed
- Insertions/deletions
- Push status (if --push was used)
