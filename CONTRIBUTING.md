# Contributing

Thanks for your interest in contributing to oshankhz-claude-code!

## Ways to Contribute

- Report bugs
- Suggest new skills or improvements
- Submit pull requests
- Improve documentation

## Reporting Bugs

1. Check [existing issues](https://github.com/OshanKHZ/oshankhz-claude-code/issues) first
2. Open a new issue with:
   - Clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Claude Code version

## Development Setup

```bash
# Clone the repo
git clone https://github.com/OshanKHZ/oshankhz-claude-code.git
cd oshankhz-claude-code
```

Then in Claude Code:

```
/plugin install --plugin-dir /path/to/oshankhz-claude-code
```

This loads your local copy for development.

## Validation Scripts

Before submitting changes, run the relevant validation scripts:

```bash
# Validate skills
./02\ -\ skills/dev-skills/skill-development/scripts/validate-skill.sh path/to/SKILL.md

# Validate agents
./02\ -\ skills/dev-skills/agent-development/scripts/validate-agent.sh path/to/agent.md

# Validate commands
./02\ -\ skills/dev-skills/command-development/scripts/validate-command.sh path/to/command.md

# Validate hooks
./02\ -\ skills/dev-skills/hook-development/scripts/validate-hook-schema.sh path/to/settings.json
```

## Pull Request Process

1. Fork the repo
2. Create a branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Run validation scripts
5. Commit with clear message
6. Push and open PR

## Code of Conduct

- Be respectful and inclusive
- Accept constructive feedback
- Focus on what's best for the community

## Questions?

Open an issue with the `question` label.
