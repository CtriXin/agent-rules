# AGENTS.md - Codex Bootstrap

> This file is auto-loaded by Codex CLI.
> Treat it as a bootstrap entry, not the long-form rule source.

## Startup Order

1. Read the primary rule file in this order:
   - `AGENT.md`
   - `CLAUDE.md`
   - `AGENT_RULES.md`
2. Read `.ai/manifest.json`
3. Read `.ai/plan/current.md`
4. If present, read `.ai/startup/STARTUP_BRIEF.md`
5. Read `.ai/workflow.md`
6. If present, read `AI_BOOTSTRAP.md`

## Conflict Rules

- Project-specific rules win over shared defaults.
- If multiple rule files exist, prefer `AGENT.md`, then `CLAUDE.md`, then `AGENT_RULES.md`.
- `.ai/plan/current.md` is the current task source of truth.

## Codex Expectations

- Execute plans, don't leave them in suggestion state.
- If another AI currently owns the task, ask before taking over.
- Before non-trivial execution, self-check writable scope, dependency closure, rollback path, verification plan, and blast radius.
- Update docs and plan files in the same pass when behavior changes.

## TODO Management

- On plan phase or new task, list TODOs in **four-quadrant format** (Urgent+Important / Important+Not Urgent / Urgent+Not Important / Neither) in `.ai/plan/TODO.md`.
- Each item: `- [ ] description (source: @codex, created: YYYY-MM-DD)`
- On completion: `- [x] description (source: @codex, created: ..., completed: YYYY-MM-DD)`
- At plan start, archive `[x]` items to `docs/archive/todo-archive-YYYY-MM.md` (append-only, never delete).

## Release Handoff

- Both `Codex` and `Claude` must append a short landed-change record to `./.ai/agent-release-notes.md` after each completed iteration stage.
- Keep `./.ai/agent-release-notes.md` in the project's `.gitignore`; treat it as local release-prep context, not source code.
- Each record should include:
  - timestamp
  - agent name
  - landed commit/tag/release, if any
  - changed file scope
  - concise summary of what actually landed
  - reusable release-note bullets
  - validation run and result
- Before preparing a version bump or GitHub release, `Codex` should read this file first and build release notes from it.

## Health Check

If the project exposes a standard validation command, run it before or after edits as appropriate.
