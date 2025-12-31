# Commands Reference

Quick-access slash commands for common workflows.

## 📌 Available Commands

### `/commit` - Quick Conventional Commit

Create git commits with conventional format and optional auto-generation.

**Usage:**
```
/commit [flags] [type: message]
```

**Flags:**

| Flag | Effect |
|------|--------|
| `--push` | Push to remote after commit |
| `--amend` | Amend last commit (use with caution) |
| `--all` | Stage all changes before commit (`git add -A`) |

**Examples:**

```bash
# Auto-generate message from staged changes
/commit

# With custom message
/commit feat: add user authentication

# With scope
/commit fix(api): handle null response

# Commit and push
/commit --push docs: update README

# Stage all, commit, and push
/commit --all --push feat: add login page

# Amend last commit
/commit --amend fix: correct typo
```

**Conventional Commit Format:**
- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation
- `refactor:` code change (no feat/fix)
- `test:` tests
- `chore:` maintenance
- Add `(scope)` for area: `feat(auth):`
- Add `!` for breaking: `feat!:`

**Message Rules:**
- Use imperative mood: "add" not "added"
- Max 72 chars first line
- Think: "If applied, this commit will [message]"

---

### `/changelog` - Changelog Generator

Generate or update CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com) format.

**Usage:**
```
/changelog [version]
```

**Examples:**

```bash
# Auto-detect version bump from commits
/changelog

# Specify version explicitly
/changelog 2.0.0
```

**Features:**

| Feature | Description |
|---------|-------------|
| Format detection | Reads existing CHANGELOG.md header to match its style (dates, "v" prefix, sections) |
| Smart versioning | Suggests patch/minor/major based on conventional commits |
| Tiered version detection | Finds version in common files first, then any JSON/TOML with "version" field |
| Version sync | Asks to update project files when changelog version differs |
| Keep a Changelog | Uses standard sections (Added, Changed, Fixed, Security, etc.) |

**Date Format:** `December 25th, 2025` (readable with ordinal suffix)

**New changelogs:** Use "v" prefix by default (`## [v1.0.0]`)

**Version Bump Logic:**

| Commit Pattern | Suggested Bump |
|----------------|----------------|
| `BREAKING CHANGE:` or `feat!:` | Major (X.0.0) |
| `feat:` | Minor (x.X.0) |
| `fix:`, `refactor:`, etc. | Patch (x.x.X) |

**Commit to Section Mapping:**
- `feat:` → Added
- `fix:` → Fixed
- `refactor:`, `perf:` → Changed
- `security:` → Security
- `docs:`, `test:`, `chore:`, `ci:` → (skipped - not user-facing)

**Workflow:**
1. Gathers commits since last tag
2. Detects existing changelog format (dates, section order)
3. Suggests version bump based on commits
4. Shows preview for confirmation
5. Updates CHANGELOG.md preserving existing style
6. Optionally updates version in project files

---

## 🎯 Usage Tips

**Auto-staging:** If nothing is staged, command will ask what to stage.

**Security:** Command blocks commits of `.env`, secrets, and credential files.

**Message generation:** When no message provided, analyzes git diff and recent commits to generate appropriate conventional commit.
