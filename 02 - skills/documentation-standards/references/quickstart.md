# Quick Start Guide - Complete Guide

## Purpose

A Quick Start guide gets users from zero to working as fast as possible. It's the "impatient reader" version of your documentation.

## Diataxis Classification

**How-to** - Goal-oriented, assumes reader wants to get running immediately.

## Difference from README

| README | Quick Start |
|--------|-------------|
| Overview + setup | Setup only |
| What it is + how to use | Just how to use |
| Features, architecture | Skip all that |
| 5-10 min read | 2-5 min read |

**Rule:** If your README Quick Start section exceeds 10 lines, create a separate QUICKSTART.md.

## Audience

- Impatient developers who want to try it NOW
- Evaluators deciding if tool is worth deeper investment
- Experienced devs who just need the commands

## Core Principles

### 1. Time-Boxed

State expected time upfront. Be realistic.

```markdown
# Quick Start

Get running in **under 10 minutes**.
```

### 2. Minimal Prerequisites

Only list what's absolutely required. Link to detailed setup for edge cases.

```markdown
## Prerequisites

- Node.js 18+
- Git

> Need help installing these? See [detailed setup](./docs/installation.md)
```

### 3. Copy-Paste Ready

Every command should work when copy-pasted. No placeholders that require editing.

Bad:
```bash
git clone https://github.com/<your-username>/<repo>.git
```

Good:
```bash
git clone https://github.com/org/repo.git
```

### 4. Verify Each Step

Show expected output so user knows it worked.

```markdown
### 2. Install Dependencies

\`\`\`bash
npm install
\`\`\`

You should see:
\`\`\`
added 150 packages in 10s
\`\`\`
```

### 5. End with Working State

User should have something functional at the end.

```markdown
## Done!

Open http://localhost:3000 - you should see the welcome page.

## Next Steps

- [Configuration Guide](./docs/config.md)
- [First Tutorial](./docs/tutorial.md)
```

## Structure

### Required Sections

```markdown
# Quick Start

[One sentence: what you'll have at the end]

## Prerequisites

- [Requirement 1]
- [Requirement 2]

## Steps

### 1. [First Step]
[Command + expected output]

### 2. [Second Step]
[Command + expected output]

[... max 5-7 steps ...]

## Verify It Works

[How to confirm success]

## Next Steps

- [Link to deeper docs]
```

### Optional Sections

- **Checklist** - Pre-flight checklist
- **Troubleshooting** - Top 2-3 issues only (link to full troubleshooting)
- **Minimal vs Full Setup** - If there are tiers

## Template

```markdown
# Quick Start

Get [project] running in **under 15 minutes**.

## Prerequisites

- [ ] Python 3.10+
- [ ] Git
- [ ] API key from [service] ([get one here](https://...))

## Setup

### 1. Clone and Enter

\`\`\`bash
git clone https://github.com/org/project.git
cd project
\`\`\`

### 2. Create Environment

\`\`\`bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
\`\`\`

### 3. Install Dependencies

\`\`\`bash
pip install -r requirements.txt
\`\`\`

You should see:
\`\`\`
Successfully installed [packages]
\`\`\`

### 4. Configure

\`\`\`bash
cp .env.example .env
\`\`\`

Edit `.env` and add your API key:
\`\`\`
API_KEY=your-key-here
\`\`\`

### 5. Run

\`\`\`bash
python main.py
\`\`\`

Expected output:
\`\`\`
Server running on http://localhost:8000
\`\`\`

## Verify

Open http://localhost:8000 in your browser. You should see the dashboard.

## Quick Test

\`\`\`bash
curl http://localhost:8000/health
\`\`\`

Should return:
\`\`\`json
{"status": "ok"}
\`\`\`

## Troubleshooting

### "Module not found" error
\`\`\`bash
pip install -r requirements.txt
\`\`\`

### Port already in use
\`\`\`bash
python main.py --port 8001
\`\`\`

For more issues, see [Troubleshooting Guide](./docs/troubleshooting.md).

## Next Steps

- [Configuration Reference](./docs/config.md) - Customize settings
- [Tutorial: First Project](./docs/tutorial.md) - Build something real
- [API Documentation](./docs/api.md) - Full API reference
```

## Checklist

### Essential

- [ ] Time estimate stated upfront
- [ ] Prerequisites listed with versions
- [ ] Every step has command + expected output
- [ ] Commands are copy-paste ready (no placeholders)
- [ ] Ends with verifiable working state
- [ ] Links to next steps / deeper docs

### Quality

- [ ] Tested on fresh environment
- [ ] Works on all supported OS (or notes differences)
- [ ] Max 5-7 main steps
- [ ] No unnecessary explanation (save for README/tutorials)

## Patterns

### Minimal vs Full Setup

When project has optional features:

```markdown
## Minimal Setup (5 min)

Core functionality only:

\`\`\`bash
pip install project
project init
project run
\`\`\`

## Full Setup (15 min)

With all features (database, caching, etc.):

\`\`\`bash
pip install project[full]
project init --full
docker-compose up -d  # Start dependencies
project run
\`\`\`
```

### Multiple Installation Methods

```markdown
## Installation

### Option A: pip (Recommended)

\`\`\`bash
pip install project
\`\`\`

### Option B: From Source

\`\`\`bash
git clone https://github.com/org/project.git
cd project
pip install -e .
\`\`\`

### Option C: Docker

\`\`\`bash
docker run -p 8000:8000 org/project
\`\`\`
```

### Platform-Specific Steps

```markdown
### 3. Install FFmpeg

**Linux (Ubuntu/Debian):**
\`\`\`bash
sudo apt install ffmpeg
\`\`\`

**macOS:**
\`\`\`bash
brew install ffmpeg
\`\`\`

**Windows:**
Download from https://ffmpeg.org and add to PATH.
```

## Anti-Patterns

### Too Much Explanation

Bad:
```markdown
### 2. Create Virtual Environment

A virtual environment is an isolated Python environment that allows you to
install packages without affecting your system Python. This is important
because different projects may require different versions of packages...

\`\`\`bash
python -m venv venv
\`\`\`
```

Good:
```markdown
### 2. Create Virtual Environment

\`\`\`bash
python -m venv venv
source venv/bin/activate
\`\`\`
```

### Placeholders Without Instructions

Bad:
```markdown
\`\`\`bash
export API_KEY=<your-api-key>
\`\`\`
```

Good:
```markdown
\`\`\`bash
export API_KEY=your-api-key  # Get one at https://...
\`\`\`
```

### No Verification

Bad:
```markdown
### 5. Run the Server

\`\`\`bash
npm start
\`\`\`

### 6. Next Steps
...
```

Good:
```markdown
### 5. Run the Server

\`\`\`bash
npm start
\`\`\`

You should see:
\`\`\`
Server listening on port 3000
\`\`\`

Open http://localhost:3000 to verify.
```

### Too Many Steps

If you have more than 7 steps, consider:
- Automating some steps (setup script)
- Creating "Minimal" vs "Full" paths
- Moving optional steps to separate doc

## When to Create Separate QUICKSTART.md

Create separate file when:
- README Quick Start > 10 lines
- Multiple setup paths exist
- Platform-specific instructions needed
- Project has test/verify steps

Keep in README when:
- Setup is truly 3-4 commands
- Single path works for everyone
- No verification needed
