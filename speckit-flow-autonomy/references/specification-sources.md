# SKILL.md specification sources

This skill was structured against the following references reviewed for SKILL.md format and file organization:

- Agent Skills specification: https://agentskills.io/specification
- Anthropic skill format review: https://deepwiki.com/anthropics/skills/2.2-skill.md-format-specification
- OpenAI skill format review: https://deepwiki.com/openai/skills/7.1-skill.md-format-specification
- Skills Directory SKILL.md format: https://www.skillsdirectory.com/docs/skill-md-format
- Skills Directory file structure: https://www.skillsdirectory.com/docs/skill-file-structure
- Agensi SKILL.md reference: https://www.agensi.io/learn/skill-md-format-reference

Portability decisions applied here:

- `name` and `description` remain required top-level frontmatter fields.
- `license`, `compatibility`, and `metadata` use documented optional fields.
- `author` and `version` are stored under `metadata` rather than as top-level extensions.
- Product-specific optional frontmatter such as `argument-hint`, `user-invocable`, `when_to_use`, and `context` is omitted.
- Detailed instructions are split into `references/` for progressive loading.
