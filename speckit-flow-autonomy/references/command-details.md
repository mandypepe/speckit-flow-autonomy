# Command details

## specify

Check `hooks.before_specify` in `.specify/extensions.yml` when the file exists. Generate a two-to-four-word short name, then use the repository script:

```bash
.specify/scripts/bash/create-new-feature.sh --json --short-name "<name>" "<feature>"
```

Add `--timestamp` only when `branch_numbering=timestamp`; otherwise follow the configured numbering mode. Validate the returned `BRANCH_NAME`, `SPEC_FILE`, and `FEATURE_NUM`. Iterate specification quality checks up to the limit defined by the local agent or prompt. If critical questions remain, follow the local clarification behavior.

## clarify

Use:

```bash
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
```

Assess material ambiguity in scope, data, UX, non-functional requirements, integrations, and edge cases. Follow the local flow's question limit and save each accepted clarification inline.

## plan

Run `before_plan` hooks when present, then:

```bash
.specify/scripts/bash/setup-plan.sh --json
```

Use its `FEATURE_SPEC`, `IMPL_PLAN`, `SPECS_DIR`, `BRANCH`, and `HAS_GIT` values. Generate the artifacts required by the local agent. Update Copilot context with:

```bash
.specify/scripts/bash/update-agent-context.sh copilot
```

## tasks

Run `before_tasks` hooks when present, then:

```bash
.specify/scripts/bash/check-prerequisites.sh --json
```

Organize tasks into setup, foundational work, user stories, and polish. Use `[P]` only for genuinely parallel work without dependency or file conflicts. Include tests when the specification requires them.

## analyze

Run:

```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Return a read-only report with finding ID, severity, location, recommendation, requirement-to-task coverage, and the metrics requested by the local flow. Limit findings according to the local agent definition.

## checklist

Run:

```bash
.specify/scripts/bash/check-prerequisites.sh --json
```

Use sequential `CHK###` identifiers. Follow the local question limits. At least 80 percent of checklist items should include traceability references when that rule exists in the authoritative local phase definition.

## implement

Run `before_implement` hooks when present, followed by:

```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Assess checklist completion when `checklists/` exists. Follow the authoritative local agent when pending items require a user decision. Execute tasks in dependency order, respect safe `[P]` concurrency, update completed items, and run `after_implement` hooks.

## converge

Run `before_converge` hooks when present, then:

```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Confirm `spec.md`, `plan.md`, and `tasks.md` exist and that `tasks.md` contains at least one completed task. Build a traceable intent inventory, assess only the artifact-defined code scope, and emit findings before writing.

When findings exist, calculate the maximum existing task ID and next phase number. Append tasks using:

```markdown
- [ ] T### <imperative description> per <source-ref> (<gap-type>)
```

Order constitutional MUST conflicts first. Do not append an empty convergence phase. Run `after_converge` hooks when present.
