# Universal Agent Collaboration Rules

> Applicable to all projects, all AI models. Project-level CLAUDE.md / AGENT.md can override or extend.
> Detailed rule files in `rules/`. State management templates in `templates/.ai/`.

---

## 0. Startup Protocol

Every new session, read these IN ORDER before doing anything:

1. **AGENT.md / CLAUDE.md** — project rules (wins all conflicts)
2. **`.ai/manifest.json`** — current project state
3. **`.ai/plan/current.md`** — current task + breakpoints

Context loading by task size:
- Bug fix → plan + target file only
- New feature → above + architecture docs
- Architecture decision → everything

## 1. Communication & Response

- When user says "not right" / "that's not the issue", **stop immediately and pivot**. Ask "what's the actual situation?" before acting.
- Prefer action over repeated confirmation. If you can do it, do it. Only ask when truly uncertain.
- Keep technical terms in English, everything else in the user's language.

## 2. Thinking Mode

- **3+ step complex tasks** (architecture design, multi-file refactoring, complex debugging): use extended thinking / ultrathink.
- Simple Q&A, single-file edits: normal mode, don't waste tokens.
- Rule of thumb: involves 3+ file relationships simultaneously → ultrathink.

## 3. Iteration Discipline (6-Step Cycle)

Every iteration MUST complete all 6 steps:

1. **Read** — understand current state from plan/TODO/relevant files
2. **Plan** — decompose into small, verifiable steps
3. **Code** — execute the plan
4. **Review** — self-review the code
5. **Doc Sync** — update TODO, diagrams, plan docs
6. **Update Plan** — mark completed items, record decisions

**Key rule**: Plans must be actionable. Never leave a plan in "suggestion" state — either execute it or explicitly mark it as "shelved".

## 4. Plan Quality Gates

Non-trivial plans must pass a 5-dimension self-review before execution:

| Dimension | Question |
|-----------|----------|
| **Writable** | Do target files exist and are modifiable? |
| **Dependency closure** | Are all prerequisites met? |
| **Rollback** | Can we revert if it goes wrong? |
| **Verification** | How do we know it worked? |
| **Scope** | Is there scope creep or over-engineering? |

Then challenge: Is there a shorter path? Is this over-designed? Low-risk tasks (single file, docs) get lightweight challenge only.

## 5. Code Red Lines

### Hard Limits

| Metric | Threshold | Violation Action |
|--------|-----------|------------------|
| File lines | ≤ 800 | Split into multiple files |
| Function lines | ≤ 30 | Extract subfunctions |
| Nesting depth | ≤ 3 | Use early return / extract |
| Function params | ≤ 5 | Use options object |

If you **must** violate: add `// REDLINE_EXCEPTION: {reason}`

### Security Prohibitions (Absolute)

- `eval()` / `new Function()`
- `innerHTML =` (XSS risk)
- Unencapsulated `process.env` (use config layer)
- Hardcoded secrets/keys

## 6. Error Handling Protocol

1. **First error**: Use chain-of-thought reasoning to fix
2. **Second error (unresolved)**: System Mode 2 —
   - Analyze root cause systematically
   - Provide 3 alternative approaches with pros/cons
   - Let user choose
3. **Never retry the same error more than 2 times**

## 7. Documentation Sync

- **Every code change must sync corresponding documentation**
- Never directly delete docs — move outdated docs to `docs/archive/`
- After any module change, update the module's doc at minimum
- If scripts are modified, sync the scripts index

## 8. Sensitive Operations

The following require explicit user confirmation BEFORE execution:

- Global config modifications
- Non-reversible deletions (`rm -rf`, `git push --force`)
- Adding new dependencies
- Modifying global styles or shared configs
- Deleting/renaming existing functions or components

**Rule**: Tell user first, then execute. Don't rely on runtime permission fallback.

## 9. Git Worktree Parallel Development

- Parallel needs default to Git worktree, no cross-directory changes
- Detached HEAD → switch to named branch first
- Default: don't auto-delete worktrees
- Only cleanup when user explicitly says "merge and cleanup"

## 10. State Persistence

- **File system is the only reliable state source**
- Don't rely on session memory for critical state
- All task state must persist to files (TODO.md, PLAN.md, etc.)
- Plan file = single source of truth for current task

## 11. Multi-AI Handoff

When switching between AI models:
1. Record breakpoint in plan file with context
2. Change owner/assignee to new AI
3. Tell new AI: "Read PLAN + TODO, continue from breakpoint"

## 12. Responsibility Chain

| Phase | Owner | Duty |
|-------|-------|------|
| **Planning** | Strong model (Claude/GPT) | Explore, design, write plan |
| **Execution** | Coding model (Codex/Claude) | Execute per plan |
| **Confirmation** | Human | Final review, merge decision |

## 13. Cross-Agent Review (a2a)

Mandatory when: modifying business logic, shared infra, AI rules, or 2+ files.
Skip only for: pure docs, single-file cosmetic, test-only changes.
Verdicts: `pass` (done) / `contested` (address concerns) / `reject` (fix issues) / `blocked` (need context).

## 14. Rule Sync

When modifying rules/conventions themselves:
- Update AGENT.md in the affected section
- Add `<!-- Updated: YYYY-MM-DD by AgentName -->` marker
- Project rules override shared rules override global rules
