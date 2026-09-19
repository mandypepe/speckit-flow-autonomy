---
name: speckit-flow-autonomy
description: Selects and executes the correct Spec Kit phase from user intent and workspace artifacts without requiring a mandatory orchestrator. Use when working with speckit constitution, specify, clarify, plan, tasks, analyze, checklist, implement, converge, or task-to-issue flows.
license: Proprietary
compatibility: Requires a Spec Kit workspace with .github/agents or .github/prompts flow definitions and the corresponding .specify scripts and artifacts.
metadata:
  author: "ATTG API GatewayHub"
  version: "1.0.0"
---

# Spec Kit flow autonomy

## Purpose

Navigate and execute Spec Kit phases autonomously. Treat `.github/agents/*.agent.md` and `.github/prompts/*.prompt.md` as the authoritative local flow definitions. Do not require `speckit.orchestrator` as a mandatory entry point.

## Authority and precedence

Apply this precedence order:

1. The matching `.github/agents/*.agent.md` controls execution behavior.
2. The matching `.github/prompts/*.prompt.md` acts as the command wrapper and supplies phase-specific instructions.
3. This skill controls phase discovery, navigation, prerequisite checks, and handoffs.
4. `.specify/memory/constitution.md` governs repository principles and MUST-level constraints.

If two sources conflict, preserve the higher-precedence source for its assigned responsibility. Do not use this navigation skill to override execution behavior defined in an `agent.md` file.

## Operating rules

- Infer the requested phase from user intent, an explicit slash command, an optional `--file [path]`, and the current artifacts under `.specify/` and `specs/`.
- Never ask the user to switch agents manually.
- Use a supplied `--file [path]` when the selected phase supports it. Otherwise infer the active feature from workspace artifacts.
- Validate prerequisites before executing a phase.
- If a required artifact is missing, stop. Name the missing artifact and recommend the nearest preceding phase that creates it.
- Do not fabricate artifacts, skip required prerequisites, or infer file contents that have not been read.
- After each completed phase, suggest the next valid phase from the canonical handoff map.
- Treat `speckit.taskstoissues` as an auxiliary command, not a phase in the canonical nine-phase lifecycle.

## Canonical phase order

1. `speckit.constitution`
2. `speckit.specify`
3. `speckit.clarify`
4. `speckit.plan`
5. `speckit.tasks`
6. `speckit.analyze`
7. `speckit.checklist`
8. `speckit.implement`
9. `speckit.converge`

The order is directional. The handoff map may permit an optional phase to be bypassed, such as `speckit.specify` to `speckit.plan`, but no phase may run before its own required artifacts exist.

## Execution workflow

1. Read the user request and extract an explicit phase, `--file` target, feature description, and requested outcome.
2. Inspect `.github/agents/` and `.github/prompts/` for the matching phase definition.
3. Inspect `.specify/` and `specs/` only as needed to identify the active feature and prerequisite artifacts.
4. Select the phase using `references/phase-selection.md`.
5. Validate the phase contract in `references/phase-contracts.md`.
6. Execute the matching agent and prompt instructions directly.
7. Validate the documented outputs. Do not report success from command exit status alone when output artifacts must exist.
8. Return the phase result, artifact paths, blocking findings, and next valid phase.

## Safety gates

- `speckit.analyze` is read-only. Do not modify project artifacts during analysis.
- `speckit.checklist` evaluates requirement quality, not implementation behavior.
- `speckit.implement` requires `tasks.md` and follows task dependencies. Update completed task checkboxes only after the work and validation pass.
- `speckit.converge` runs only after an implementation pass has completed at least one task. It may append a new convergence phase to `tasks.md`, but it must not rewrite, renumber, or delete existing tasks.
- `speckit.taskstoissues` runs only when the Git remote is a GitHub URL and identifies the exact repository intended by the user.

## Reference loading

Read only the references needed for the selected phase:

- `references/phase-selection.md` for intent routing and handoffs.
- `references/phase-contracts.md` for inputs, outputs, prerequisite gates, and validation.
- `references/command-details.md` for documented scripts, formats, hooks, and phase-specific constraints.
- `references/specification-sources.md` for the external SKILL.md format sources used to structure this skill.

## Response contract

Report:

- selected phase and why it matches the request;
- prerequisite status;
- commands or flow definition executed;
- created, updated, or analyzed artifacts;
- validation outcome and precise blockers;
- next valid phase.

Never claim that a phase completed when a required command failed, a required artifact is absent, or a documented validation remains unresolved.
