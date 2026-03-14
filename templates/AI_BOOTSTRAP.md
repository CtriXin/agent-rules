# AI_BOOTSTRAP.md - Cross-AI Entry

## Applies To

- Claude
- Codex
- Gemini
- Other AI tools that do not auto-load local project rules

## Mandatory Read Order

1. Read the primary rule file: `AGENT.md` or `CLAUDE.md` or `AGENT_RULES.md`
2. Read `.ai/manifest.json`
3. Read `.ai/plan/current.md`
4. If present, read `.ai/startup/STARTUP_BRIEF.md`
5. Read `.ai/workflow.md`

## Execution Rules

- State planned file impact before non-trivial edits.
- Follow red lines: file <= 800 lines, function <= 30 lines, nesting <= 3, params <= 5.
- If behavior changes, update the corresponding docs in the same pass.
- If a task is medium or high risk, perform review before marking it complete.
- Do not rely on session memory for task state; persist key context in files.

## TODO Management

- On plan phase or new task, list TODOs in **four-quadrant format** in `.ai/plan/TODO.md`.
- Each item: `- [ ] description (source: @agent, created: YYYY-MM-DD)`
- On completion: mark `[x]`, add completed date.
- At plan start, archive completed items to `docs/archive/todo-archive-YYYY-MM.md` (monthly shard, append-only).

## Delivery Format

1. Changed files and behavior
2. Key tradeoffs
3. Validation status
4. Remaining risks or skipped items

## Fallback

If local rules are not auto-loaded, copy the relevant parts of the primary rule file into the prompt and continue from the project files.
