# Quickstart Template

A concrete example of a well-structured Quick Start guide following documentation standards.

---

# Quick Start

Get [PROJECT NAME] running in **under 10 minutes**.

## Prerequisites

Before you begin, ensure you have:

- [ ] Node.js 18+ installed ([download](https://nodejs.org))
- [ ] Git installed ([download](https://git-scm.com))
- [ ] A code editor (VS Code recommended)
- [ ] API key from [Service] ([get one here](https://...))

## Setup (~5 min)

### 1. Clone and Enter (~30 sec)

```bash
git clone https://github.com/org/project.git
cd project
```

### 2. Install Dependencies (~2 min)

```bash
npm install
```

You should see:

```
added 150 packages in 10s
```

### 3. Configure Environment (~1 min)

```bash
cp .env.example .env
```

Edit `.env` and add your API key:

```
API_KEY=your-api-key-here
```

### 4. Start the Server (~30 sec)

```bash
npm start
```

Expected output:

```
Server running on http://localhost:3000
```

## Verify It Works

Open http://localhost:3000 in your browser. You should see the welcome dashboard.

**Quick test:**

```bash
curl http://localhost:3000/health
```

Should return:

```json
{"status": "ok"}
```

## Troubleshooting

### "Module not found" error

```bash
rm -rf node_modules && npm install
```

### Port 3000 already in use

```bash
npm start -- --port 3001
```

### Connection refused

Check that the server is running and try again.

For more issues, see [Troubleshooting Guide](./docs/troubleshooting.md).

## Need Help?

- [Full Documentation](./docs/README.md) - Complete reference
- [Tutorial: First Project](./docs/tutorial.md) - Step-by-step learning
- [GitHub Issues](https://github.com/org/project/issues) - Report bugs
- [Discord Community](https://discord.gg/...) - Ask questions

---

## Why This Template Works

### Time Estimate Upfront

States "under 10 minutes" immediately - sets expectations.

### Checklist Prerequisites

Uses `- [ ]` format so readers can mentally check off requirements.

### Time Per Step

Each section shows approximate time (~30 sec, ~2 min) to help readers plan.

### Copy-Paste Ready

All commands work when copied directly - no placeholders to edit.

### Verification at Each Step

Shows expected output so readers know they're on track.

### Troubleshooting Section

Addresses top 2-3 common issues with solutions.

### "Need Help?" Instead of "Next Steps"

More actionable - tells readers where to get support.
