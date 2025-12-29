# Quick Start

Get the oshankhz-claude-code plugin running in **under 2 minutes**.

## 📋 Prerequisites

Before you begin, ensure you have:

- [ ] Claude Code CLI installed and configured
- [ ] An active Claude Code session

## 🚀 Installation (~1 min)

Run these commands **inside Claude Code** (not in your terminal):

### 1. Add the Marketplace (~30 sec)

```
/plugin marketplace add OshanKHZ/oshankhz-claude-code
```

### 2. Install the Plugin (~30 sec)

```
/plugin install oshankhz-claude-code
```

## ✅ Verify It Works

Ask Claude:

```
Create a skill for me
```

If the skill-development skill activates and Claude starts guiding you through skill creation, the installation worked.

**Alternative verification:**

```
/help skills
```

You should see the plugin's skills listed.

## 🔧 Troubleshooting

### "Marketplace not found" error

Ensure you typed the marketplace name correctly:

```
/plugin marketplace add OshanKHZ/oshankhz-claude-code
```

### Plugin doesn't appear after install

Try restarting your Claude Code session:

```
/clear
```

Then verify with `/help skills`.

### Skills not activating

The skills activate based on natural language triggers. Try being more specific:

- "Create a new agent for my plugin"
- "Help me write a slash command"
- "I need to create a hook"

## 🆘 Need Help?

- [README](./README.md) - Full list of included skills and agents
- [CONTRIBUTING](./CONTRIBUTING.md) - How to contribute
- [GitHub Issues](https://github.com/OshanKHZ/oshankhz-claude-code/issues) - Report bugs or request features
