# OshanKHZ Claude Code

This is my personal Claude Code setup. These are the configurations I've validated and use daily. More skills, commands, and agents coming soon.

## Installation

Run these commands inside Claude Code (not in your terminal):

```
# Step 1: Add the marketplace
/plugin marketplace add OshanKHZ/oshankhz-claude-code

# Step 2: Install the plugin
/plugin install oshankhz-claude-code
```

> **Note:** After installation, skills won't appear in `~/.claude/skills/`. They're loaded directly from the marketplace. Test by asking Claude to "create a skill", for example - the skill-development skill should activate automatically.

## What's Included

### 🤖 01 - agents/

| Name | Purpose |
|------|---------|
| documentation-writer | Create accurate, demand-driven documentation following Diataxis principles |

### 👾 02 - skills/

#### dev-skills/ (Plugin Development)

| Name | Purpose |
|------|---------|
| skill-development | Create, edit, and validate skills with proper structure, frontmatter, and progressive disclosure |
| command-development | Build slash commands with dynamic arguments, file references, and bash execution |
| hook-development | Create event-driven automation with prompt-based and command hooks for validation and policies |
| agent-development | Design autonomous agents with triggering examples, system prompts, and tool restrictions |
| instructions-development | Initialize, sync, and organize CLAUDE.md with codebase patterns and modular rules |

#### Standalone Skills

| Name | Purpose |
|------|---------|
| documentation-standards | Diataxis-based templates, checklists, and examples for READMEs, APIs, tutorials, and ADRs |

## Local Development

```bash
git clone https://github.com/OshanKHZ/oshankhz-claude-code.git
cd oshankhz-claude-code

# Add as local marketplace
/plugin marketplace add /path/to/oshankhz-claude-code

# Install plugin
/plugin install oshankhz-claude-code
```

## Contributing

Found a bug or have a suggestion? Open an issue or submit a PR:
- [Issues](https://github.com/OshanKHZ/oshankhz-claude-code/issues)
- [Pull Requests](https://github.com/OshanKHZ/oshankhz-claude-code/pulls)

## License

MIT - Feel free to fork and customize for your own setup.
