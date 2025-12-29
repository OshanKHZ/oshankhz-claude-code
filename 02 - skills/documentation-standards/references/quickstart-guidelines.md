# Quick Start Guidelines

Rules, tips, and best practices for creating effective Quick Start guides.

## Purpose

A Quick Start guide gets users from zero to working as fast as possible. It's the "impatient reader" version of your documentation.

## Diataxis Classification

**How-to** - Goal-oriented, assumes reader wants to get running immediately.

## When to Create

Create separate QUICKSTART.md when:

- README Quick Start section exceeds 10 lines
- Multiple setup paths exist
- Platform-specific instructions needed
- Project has test/verify steps

Keep in README when:

- Setup is truly 3-4 commands
- Single path works for everyone
- No verification needed

## Core Principles

### 1. Time-Box It

State expected time upfront. Be realistic.

**Good:** "Get running in **under 10 minutes**"
**Bad:** No time estimate or unrealistic "2 minutes" for complex setup

### 2. Minimal Prerequisites

Only list what's absolutely required. Use checklist format.

**Good:**
```markdown
- [ ] Node.js 18+ ([download](https://nodejs.org))
- [ ] Git installed
```

**Bad:**
```markdown
You need Node.js, npm, and Git installed. Also make sure you understand JavaScript...
```

### 3. Copy-Paste Ready

Every command should work when copy-pasted. No placeholders.

**Good:** `git clone https://github.com/org/repo.git`
**Bad:** `git clone https://github.com/<your-username>/<repo>.git`

### 4. Show Expected Output

After each step, show what success looks like.

**Good:**
```markdown
Run: `npm install`
You should see: `added 150 packages in 10s`
```

**Bad:** Just the command with no verification

### 5. Time Per Step

Add approximate time for each section to help readers plan.

**Good:** `### 1. Clone and Enter (~30 sec)`
**Bad:** No indication of how long steps take

### 6. End with "Need Help?" Not "Next Steps"

Provide actionable support options.

### 7. Use Emojis in Section Headers

Add relevant emojis to `##` section headers for visual scanning. Keep the main title `#` clean without emojis.

**Good:**
```markdown
# Quick Start                    # No emoji in title
## 📋 Prerequisites              # Emoji in sections
## 🚀 Installation
## ✅ Verify It Works
## 🔧 Troubleshooting
## 🆘 Need Help?
```

**Bad:**
```markdown
# ⚡ Quick Start                 # Emoji in title
## Prerequisites                 # No emoji in sections
```

**Good:**
```markdown
## Need Help?

- [Full Documentation](./docs)
- [GitHub Issues](https://github.com/...)
- [Discord Community](https://discord.gg/...)
```

**Bad:**
```markdown
## Next Steps

See the documentation for more information.
```

## Required Sections

1. **Title with time estimate** - "Quick Start - Get running in X minutes"
2. **Prerequisites** - Checklist format with `- [ ]`
3. **Numbered steps** - With time per section
4. **Expected output** - After each step
5. **Verify it works** - Final confirmation
6. **Troubleshooting** - Top 2-3 issues only
7. **Need Help?** - Support resources

## Checklist

### Essential

- [ ] Time estimate stated upfront
- [ ] Prerequisites listed with checklist format
- [ ] Every step has command + expected output
- [ ] Commands are copy-paste ready (no placeholders)
- [ ] Ends with verifiable working state
- [ ] "Need Help?" section with resources

### Quality

- [ ] Tested on fresh environment
- [ ] Works on all supported OS (or notes differences)
- [ ] Max 5-7 main steps
- [ ] No unnecessary explanation

## Anti-Patterns

### Too Much Explanation

**Bad:**
```markdown
A virtual environment is an isolated Python environment that allows you to
install packages without affecting your system Python...
```

**Good:**
```markdown
Create environment:
\`\`\`bash
python -m venv venv
source venv/bin/activate
\`\`\`
```

### Placeholders Without Instructions

**Bad:** `export API_KEY=<your-api-key>`
**Good:** `export API_KEY=your-api-key  # Get one at https://...`

### No Verification

**Bad:** Command with no expected output
**Good:** Command followed by "You should see: [output]"

### Too Many Steps

If more than 7 steps:

- Automate some (setup script)
- Create "Minimal" vs "Full" paths
- Move optional steps to separate doc

## See Also

- **Template:** `examples/quickstart-template.md`
