---
allowed-tools: Bash(git:*), Bash(date:*), Bash(head:*), Bash(test:*), Bash(grep:*), Read, Write, AskUserQuestion
argument-hint: [version]
description: Generate or update CHANGELOG.md following Keep a Changelog format
---

# Changelog Generator

**Arguments received:** $ARGUMENTS

## Context Gathering (MANDATORY)

**CRITICAL: Always run these commands first:**

1. **Get today's date (MANDATORY - never assume):**
   ```bash
   date "+%B %d, %Y"
   ```
   This gives format like "December 25, 2025". Then add ordinal suffix (1st, 2nd, 3rd, 4th, etc.) to the day number.

   **Ordinal suffix rules:**
   - 1, 21, 31 → "st" (1st, 21st, 31st)
   - 2, 22 → "nd" (2nd, 22nd)
   - 3, 23 → "rd" (3rd, 23rd)
   - All others → "th" (4th, 5th, 11th, 12th, 13th, etc.)

   **Final format:** `December 25th, 2025`

2. **Check for existing CHANGELOG.md:**
   ```bash
   test -f CHANGELOG.md && echo "EXISTS" || echo "MISSING"
   ```

3. **If CHANGELOG.md exists, read only the first 50 lines to detect format:**
   ```bash
   head -50 CHANGELOG.md
   ```
   From this header, detect:
   - Does it use dates? (e.g., `## [1.0.0] - 2024-01-15` vs `## [1.0.0]`)
   - Section order (Added, Changed, Fixed, etc.)
   - Any custom header text
   - Link format at bottom (if any)

4. **Detect version source (tiered approach):**

   **Tier 1 - Common files (check first, covers 90% of projects):**
   ```bash
   test -f package.json && echo "FOUND: package.json"
   test -f Cargo.toml && echo "FOUND: Cargo.toml"
   test -f pyproject.toml && echo "FOUND: pyproject.toml"
   test -f composer.json && echo "FOUND: composer.json"
   ```
   If found, use Read tool to parse and extract version.

   **Tier 2 - Root-level JSON/TOML with version (if Tier 1 fails):**
   ```bash
   grep -l '"version"' *.json 2>/dev/null
   grep -l 'version' *.toml 2>/dev/null
   ```
   Finds unconventional files like `plugin.json`, `manifest.json`, `marketplace.json`.

   **Tier 3 - Config directories (if Tier 2 fails):**
   ```bash
   grep -rl '"version"' .claude-plugin/ config/ .config/ 2>/dev/null | head -3
   ```
   Searches common config directories.

   **Tier 4 - Git tags (fallback):**
   ```bash
   git describe --tags --abbrev=0 2>/dev/null
   ```

   **Tier 5 - Ask user:**
   If nothing found, ask user to provide the version manually.

   **If multiple version files found:** Ask user which one is the source of truth.

5. **Get commits since last version:**
   - Find last tag: `git describe --tags --abbrev=0 2>/dev/null`
   - If tag exists: `git log [tag]..HEAD --oneline`
   - If no tags: `git log --oneline -30`

## Existing Changelog Format Detection

**IMPORTANT:** If CHANGELOG.md exists, follow its existing conventions:

| Detected Pattern | Action |
|------------------|--------|
| `## [vX.Y.Z]` (with "v" prefix) | Use "v" prefix in new entry |
| `## [X.Y.Z]` (no "v" prefix) | Omit "v" prefix in new entry |
| `## [X.Y.Z] - <date>` | Include date in new entry (match existing date format) |
| `## [X.Y.Z]` (no date) | Omit date in new entry |
| Custom header text | Preserve existing header |
| Specific section order | Follow same order |
| Link references at bottom | Add link for new version |

**Default for new changelogs:** Use "v" prefix (e.g., `## [v1.0.0]`)

**Never change the existing changelog's style.** Match it exactly.

## Version Bump Logic

Analyze commits to suggest version bump:

| Commit Pattern | Suggested Bump |
|----------------|----------------|
| `BREAKING CHANGE:` in body | Major (X.0.0) |
| `feat!:` or `fix!:` (with !) | Major (X.0.0) |
| `feat:` (new feature) | Minor (x.X.0) |
| `fix:`, `docs:`, `refactor:`, etc. | Patch (x.x.X) |

**If $ARGUMENTS provided:** Use it as the new version directly.

**If empty:** Calculate suggested bump and ask user to confirm.

## User Confirmation for Version

If no version argument provided, use AskUserQuestion:

Show:
- Current version: [detected version]
- Commits analyzed: [count]
- Breaking changes: [yes/no]
- New features: [count]
- Bug fixes: [count]

Question: "What version should this release be?"
Header: "Version"
Options:
  - [suggested version] (Recommended based on commits)
  - Patch bump (x.x.X)
  - Minor bump (x.X.0)
  - Major bump (X.0.0)

User can also select "Other" to provide custom version.

## Commit Type to Section Mapping

| Conventional Commit | Changelog Section |
|---------------------|-------------------|
| `feat:` | Added |
| `fix:` | Fixed |
| `docs:` | (skip - not user-facing) |
| `refactor:` | Changed |
| `perf:` | Changed |
| `style:` | (skip - not user-facing) |
| `test:` | (skip - not user-facing) |
| `chore:` | (skip - not user-facing) |
| `ci:` | (skip - not user-facing) |
| `build:` | (skip - not user-facing) |
| `security:` or contains "security" | Security |
| `deprecate:` or contains "deprecate" | Deprecated |
| `remove:` or contains "remove" | Removed |

**Note:** Only include sections that have entries. Empty sections should be omitted.

## Execution Steps

### Step 1: Gather Context (CRITICAL)

Run bash commands to gather:
- **Today's date** (MANDATORY: `date "+%B %d, %Y"` then add ordinal suffix)
- Existing changelog header (first 50 lines only)
- Current version from project files
- Last git tag
- Commits since last tag

### Step 2: Detect Existing Format

If CHANGELOG.md exists:
- Parse header to detect date format usage
- Identify section ordering convention
- Note any custom header or link patterns

### Step 3: Parse Commits

Analyze each commit message:
- Extract type and scope from conventional format
- Group by changelog section
- Format as bullet points

### Step 4: Determine Version

If $ARGUMENTS has version:
- Use provided version

If no version provided:
- Calculate suggested bump based on commit types
- Ask user to confirm with AskUserQuestion

### Step 5: Generate Changelog Entry

Create new version section matching existing format:
- Use detected date format (with date or without)
- Follow detected section order
- Only non-empty sections included

### Step 6: Preview and Confirm

Show preview of the new changelog entry to user.

Use AskUserQuestion:

Question: "Ready to update CHANGELOG.md with this entry?"
Header: "Confirm"
Options:
  - Yes, update changelog (Write the changes)
  - No, cancel (Abort without changes)

### Step 7: Write Changelog

If CHANGELOG.md exists:
- Read existing content
- Insert new version section after header (before first ## [x.y.z] entry)
- Preserve all existing content exactly

If CHANGELOG.md doesn't exist:
- Create with simple header using "v" prefix:
  ```markdown
  # Changelog

  ## [vX.Y.Z] - Month DDth, YYYY

  ### Added
  - ...
  ```

### Step 8: Version Sync Check (IMPORTANT)

After determining the new changelog version, compare it with the project file version:

**If versions match:** No action needed, proceed.

**If versions DON'T match** (e.g., changelog will be 1.1.0 but plugin.json is still 1.0.1):

Use AskUserQuestion:

Question: "Version mismatch detected. Changelog: [new version], Project file: [current version]. Update project files?"
Header: "Sync version"
Options:
  - Yes, update to [new version] (Sync project files with changelog)
  - No, keep current version (Only update changelog)

**Files to update (if yes):**
- Update the version field in the detected version source file(s)
- If multiple files have versions (e.g., `plugin.json` AND `marketplace.json`), update all of them

### Step 9: Show Result

After completion, show:
- Path to CHANGELOG.md
- New version number
- Number of changes documented
- Suggest next steps (commit, tag, release)

## Error Handling

**No commits found:**
- Inform user there are no new commits to document
- Suggest checking if there are unreleased changes

**No version source found:**
- Ask user to provide version manually
- Suggest creating package.json or similar

**Malformed commits:**
- Include them under "Changed" section with original message
- Note that conventional commit format is recommended

## Example Output (new changelog with dates)

```markdown
## [v1.2.0] - January 15th, 2025

### Added
- Add user authentication with OAuth2 support
- Add dark mode toggle to settings

### Changed
- Refactor database connection pooling for better performance

### Fixed
- Fix memory leak in event handler
- Fix incorrect date formatting in reports
```

## Example Output (without dates, following existing format)

```markdown
## [v1.2.0]

### Added
- Add user authentication with OAuth2 support

### Fixed
- Fix memory leak in event handler
```
