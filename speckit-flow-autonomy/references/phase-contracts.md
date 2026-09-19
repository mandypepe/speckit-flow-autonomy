# Phase contracts

## speckit.constitution

Input: governance updates, principle changes, or constitutional change requests.

Output: `.specify/memory/constitution.md`.

Validate that placeholders are resolved, version and date values are updated, and dependent templates or guidance remain aligned.

Next phase: `speckit.specify`.

## speckit.specify

Input: free-form feature description or a supported `--file [path]` source.

Outputs:

- `specs/<feature>/spec.md`
- `specs/<feature>/checklists/requirements.md`

Validate that the specification is complete, testable, bounded, focused on user value, and contains no more than three unresolved `[NEEDS CLARIFICATION]` markers.

Next phase: `speckit.clarify` when material ambiguity remains; otherwise `speckit.plan`.

## speckit.clarify

Input: existing `specs/<feature>/spec.md`, optionally selected with `--file [path]`.

Output: the same specification updated inline with recorded clarifications.

Validate that material ambiguity is resolved, contradictions and stale alternatives are removed, and remaining clarification markers are limited to the smallest justified set. Do not create a missing specification.

Next phase: `speckit.plan`.

## speckit.plan

Inputs:

- clarified `specs/<feature>/spec.md`
- `.specify/memory/constitution.md`

Outputs:

- `specs/<feature>/plan.md`
- `research.md`, `data-model.md`, `contracts/`, and `quickstart.md` when applicable

Validate the constitution gate, document technical assumptions, resolve design unknowns, and keep artifacts consistent with the specification and repository conventions.

Next phase: `speckit.tasks`.

## speckit.tasks

Mandatory inputs:

- `specs/<feature>/spec.md`
- `specs/<feature>/plan.md`

Optional inputs include `research.md`, `data-model.md`, `contracts/`, and `quickstart.md`.

Output: `specs/<feature>/tasks.md`.

Validate dependency order, immediate executability, user-story grouping, file paths, and the required task format:

```markdown
- [ ] T### [P?] [US#?] Description including file path
```

Next phase: `speckit.analyze` or `speckit.implement`.

## speckit.analyze

Inputs:

- `spec.md`
- `plan.md`
- `tasks.md`
- constitution

Output: read-only in-session report.

Validate coverage, ambiguity, duplication, inconsistencies, and constitution conflicts. Do not modify files. Treat conflicts with constitutional MUST requirements as CRITICAL.

Next phase: repair affected artifacts or run `speckit.checklist` when the analysis is acceptable.

## speckit.checklist

Input: current feature requirements, a checklist domain, and optional plan or task context. A supported `--file [path]` may target a specific specification.

Output: `specs/<feature>/checklists/<domain>.md`.

Validate requirement clarity, completeness, consistency, measurability, and coverage. Do not turn the checklist into implementation tests. Append rather than replace existing content.

Next phase: `speckit.implement`.

## speckit.implement

Mandatory input: `specs/<feature>/tasks.md`.

Outputs:

- code changes within planned scope
- updated completion markers in `tasks.md`

Validate prerequisites, checklist status, task dependencies, extension hooks, build and lint gates, and relevant ignore files. Do not mark a task complete until its work and checks pass.

Next phase: `speckit.converge` after a full implementation pass.

## speckit.taskstoissues

Input: completed `specs/<feature>/tasks.md`.

Output: GitHub issues.

Proceed only when the remote is a GitHub URL and the repository matches exactly. This command is auxiliary and does not alter the canonical lifecycle order.

## speckit.converge

Mandatory inputs:

- `specs/<feature>/spec.md`
- `specs/<feature>/plan.md`
- `specs/<feature>/tasks.md`

Optional input: `.specify/memory/constitution.md` and a supported `--file [path]` target.

Outputs:

- an in-session Convergence Findings report;
- a newly appended `## Phase N: Convergence` section in `tasks.md` only when findings exist.

Validate all functional requirements, success criteria, acceptance scenarios, plan decisions, and constitution MUST principles. Classify gaps as `missing`, `partial`, `contradicts`, or `unrequested`. Grade severity. Emit exactly one appended task per actionable finding.

Convergence is append-only. Never rewrite, delete, or renumber existing tasks. When no actionable finding exists, leave `tasks.md` byte-for-byte unchanged.

Next phase: `speckit.implement` when tasks were appended; otherwise code review or pull request.
