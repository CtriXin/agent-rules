# Startup Protocol

## Mandatory Reads (Non-Negotiable)

Every new session, AI agent must read these files IN ORDER before doing anything:

1. **AGENT.md / CLAUDE.md** — Project-level AI rules (single source of truth for cooperation)
2. **`.ai/manifest.json`** — Current project state (single source of truth for state)
3. **`.ai/plan/current.md`** — Current task details and breakpoints

**Rule**: Do NOT proceed without finishing these 3 reads. If conflicts arise between files, AGENT.md wins.

## Extended Startup (if files exist)

4. `.ai/startup/STARTUP_BRIEF.md` — Compressed context summary for resuming work
5. `.ai/workflow.md` — Execution flow conventions
6. Run health check / lint / build to verify project is in working state

## Context Loading Progression

Load documents based on task complexity — don't over-read for simple tasks:

| Task Type | What to Load |
|-----------|-------------|
| Bug fix / small edit | Plan file + target module doc only |
| New feature | Above + relevant architecture sections |
| Architecture decision | Everything above + full project guide |
| Cross-module refactor | Full project state + all affected module docs |

## Session Recovery

If continuing from a previous session:
1. Read `.ai/startup/STARTUP_BRIEF.md` (compressed summary)
2. Read `.ai/plan/current.md` for breakpoint context
3. Expand detailed logs (e.g., `SIGNAL_LOG.md`) only on demand
4. Don't re-read everything if the brief covers it
