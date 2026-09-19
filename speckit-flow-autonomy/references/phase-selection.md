# Phase selection and navigation

## Intent routing

| User intent or workspace condition | Select |
|---|---|
| Update governance, principles, constitutional rules, or dependent governance templates | `speckit.constitution` |
| Turn a feature description or source file into a new specification | `speckit.specify` |
| Resolve material ambiguity in an existing specification | `speckit.clarify` |
| Produce technical design artifacts from a specification and constitution | `speckit.plan` |
| Turn a specification and plan into executable work items | `speckit.tasks` |
| Check consistency, coverage, duplication, or constitution conflicts without edits | `speckit.analyze` |
| Create requirement-quality checks for a domain | `speckit.checklist` |
| Execute an existing task list and update completed task markers | `speckit.implement` |
| Assess implemented code against artifacts and append tasks for remaining gaps | `speckit.converge` |
| Publish a completed task list as GitHub issues | `speckit.taskstoissues` |

## Canonical handoffs

| Current phase | Next valid phase or phases |
|---|---|
| `speckit.constitution` | `speckit.specify` |
| `speckit.specify` | `speckit.clarify` or `speckit.plan` |
| `speckit.clarify` | `speckit.plan` |
| `speckit.plan` | `speckit.tasks` |
| `speckit.tasks` | `speckit.analyze` or `speckit.implement` |
| `speckit.analyze` | `speckit.checklist` |
| `speckit.checklist` | `speckit.implement` |
| `speckit.implement` | `speckit.converge` |
| `speckit.converge` with appended tasks | `speckit.implement` |
| `speckit.converge` with no findings | Code review or pull request |

## Missing-prerequisite behavior

When a later phase is requested:

1. Check the phase's mandatory artifacts.
2. If one is absent, do not create a substitute from assumptions.
3. Recommend the closest preceding phase that produces the missing artifact.
4. Name the expected path.
5. Preserve an explicit `--file [path]` target when supported.

Examples:

- `clarify` without `spec.md` routes to `specify`.
- `plan` without `spec.md` routes to `specify`.
- `tasks` without `plan.md` routes to `plan`.
- `analyze` without `tasks.md` routes to `tasks`.
- `implement` without `tasks.md` routes to `tasks`.
- `converge` without a completed implementation task routes to `implement`.
