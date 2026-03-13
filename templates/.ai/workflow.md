# Unified Execution Workflow

> This file defines the execution flow for ALL AI models working on this project.
> Read `rules/iteration.md` in the agent-rules repo for detailed step descriptions.

## Workflow: 6-Step Cycle

```
Read State → Plan → Code → Review → Doc Sync → Update Plan
    ↑                                                  │
    └──────────────────────────────────────────────────┘
```

## Quick Reference

| Step | Action | Artifact |
|------|--------|----------|
| 1. Read | Load manifest + plan + brief | — |
| 2. Plan | Decompose into verifiable steps | `.ai/plan/current.md` |
| 2.5 | Quality gate (if non-trivial) | Pass/Block decision |
| 3. Code | Execute plan steps | Modified source files |
| 4. Review | Self-review + a2a if needed | `.ai/summaries/*-review.md` |
| 5. Doc Sync | Update TODO + diagrams + docs | PLAN.md, TODO.md, diagrams |
| 6. Update | Mark completed, record decisions | `.ai/plan/current.md` |

## State Transitions

```
idle → in_progress → reviewing → completed
                  ↘ blocked (if gate fails)
```

## File System = Truth

All state lives in files. Don't rely on session memory.

- `.ai/manifest.json` = project state
- `.ai/plan/current.md` = task state
- TODO.md / PLAN.md = high-level progress
