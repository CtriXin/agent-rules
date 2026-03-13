# Multi-AI Handoff Protocol

## When Switching AI Models Mid-Task

1. **Record breakpoint** in `.ai/plan/current.md`:
   ```markdown
   ## Breakpoint
   - Step completed: 3 of 7
   - Current state: [what's done, what's pending]
   - Files modified: [list]
   - Blockers: [if any]
   - Next action: [exact next step]
   ```

2. **Update ownership**:
   - Change `owner` field in plan to new AI name
   - Add handoff timestamp

3. **Brief the next AI**:
   > "Read AGENT.md + .ai/plan/current.md, continue from the breakpoint."

## Responsibility Chain

| Phase | Best Suited For | Examples |
|-------|----------------|---------|
| **Research & Planning** | Strong reasoning model (Claude Opus, GPT-5) | Architecture design, trade-off analysis, ambiguous problems |
| **Execution** | Fast coding model (Claude Sonnet, Codex) | Implementation per plan, batch refactoring, test writing |
| **Review** | Different model than author | Cross-agent review, fresh-eyes on code |
| **Confirmation** | Human | Merge decision, deployment, sensitive actions |

## Task Ownership Rules

- Each task has exactly ONE owner at a time
- If task owner ≠ current AI → **ask user before continuing**
- Don't silently take over another AI's in-progress work
- Record who did what in the plan's "Modified By" section

## Startup Brief for New AI

When handing off, generate `.ai/startup/STARTUP_BRIEF.md`:
- Project context (2-3 sentences)
- Current task and progress
- Key decisions already made
- Known constraints and blockers
- Exact next step

Keep it under 500 words — the new AI can expand from source files if needed.
