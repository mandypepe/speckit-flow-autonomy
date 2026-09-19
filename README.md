# speckit-flow-autonomy
Selects and executes the correct Spec Kit phase from user intent and workspace artifacts without requiring a mandatory orchestrator. Use when working with speckit constitution, specify, clarify, plan, tasks, analyze, checklist, implement, converge, or task-to-issue flows.
## Skill Installation Paths by Vendor
To make speckit-flow-autonomy available to a supported AI development tool, place its skill files in the corresponding project, personal, or global skills directory listed below. Each vendor uses different directory conventions for discovering skills.
This guide documents where supported AI development tools look for skills, organized by vendor and scope.

### Globant CODA

Globant CODA installs skills locally in the user's home directory:

- **Skills:** `~/.coda/skills/`

### GitHub Copilot

GitHub Copilot supports project-specific and global skill locations.

#### Project Scope

Skills are stored in the repository root:
`.github/skills/<skill-name>/SKILL.md`

#### Global Scope

**macOS/Linux:**

```text
~/.copilot/skills/
~/.config/github-copilot/skills/
```

**Windows:**
```text
%USERPROFILE%\.copilot\skills\
%APPDATA%\github-copilot\skills\
```

### Claude Code and Claude Desktop

Claude stores skills in different locations depending on their scope.

#### Personal or Global Scope

***macOS/Linux:***
```text
~/.claude/skills/
```
**Windows:**
```text
%USERPROFILE%\.claude\skills\
C:\Users\<username>\.claude\skills\
```
#### Project Scope
All platforms:
```text
.claude/skills/
```
This directory should be located in the root of the project repository.
###  Gemini and Antigravity
Gemini and Antigravity support project, legacy, global, and product-specific skill locations.
Project or Workspace Scope:

***Primary path:***
```text
.agents/skills/
```
This directory should be located in the root of the project repository.
Legacy path:
```text
.agents/skills/
```
***Global Scope:***
```text
~/.gemini/config/skills/
```
**Windows:**
```text
%USERPROFILE%\.gemini\config\skills\
```
This global path is recognized across Antigravity IDE, Antigravity CLI, and core agent environments.
#### Antigravity Product-Specific Scope
***macOS/Linux:***
```text
~/.gemini/antigravity/skills/
```
**Windows:**
```text
%USERPROFILE%\.gemini\antigravity\skills\
```
This structure keeps the existing README focused while clearly separating each vendor and distinguishing project, personal, global, and product-specific scopes.
