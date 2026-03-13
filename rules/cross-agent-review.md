# Cross-Agent Review (a2a)

## When Cross-Agent Review is MANDATORY

Another AI model must review your work if ANY of these conditions are true:

| Condition | Why |
|-----------|-----|
| Modifying business logic code | Catch logic errors across model blindspots |
| Modifying shared infrastructure (scripts, build, config) | High blast radius |
| Modifying AI rules or protocols themselves | Rules changes affect all future sessions |
| More than 2 files affected | Complexity threshold |
| Adding dependencies or changing build | Supply chain + compatibility risk |
| Architecture or state machine changes | Structural decisions need diverse review |

## When You Can Skip

- Pure documentation changes
- Single-file cosmetic fixes
- Test-only changes (no business logic)

If skipping, record in review file: `cross-agent review: skipped | reason: low_risk_doc_only`

## Review Verdicts

| Verdict | Meaning | Next Action |
|---------|---------|-------------|
| `pass` | Approved | Mark task completed |
| `contested` | Reviewer has concerns | Address concerns, re-review |
| `reject` | Significant issues found | Task stays in progress, fix issues |
| `blocked` | Cannot review (missing context) | Provide context, re-request |

Only `pass` allows marking a task as `completed`.

## Review Output Format

Save review to `.ai/summaries/{task_id}-review.md` with:
- Files reviewed
- Issues found (or "none")
- Verdict
- Reviewer model name and timestamp
