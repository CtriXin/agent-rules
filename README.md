# Agent Rules

Universal AI collaboration rules extracted from production projects. Technology-agnostic, reusable across any codebase.

## Quick Start

### One-liner (remote, no clone needed)

```bash
cd your-project && curl -fsSL https://raw.githubusercontent.com/CtriXin/agent-rules/main/setup.sh | bash
```

### Local (if you already cloned)

```bash
cd your-project && bash /path/to/agent-rules/setup.sh
```

The script will:
- Create `.ai/` state management structure
- Add rules as `CLAUDE.md` (or `AGENT_RULES.md` if CLAUDE.md exists)
- Add `AGENTS.md` for Codex startup
- Add `AI_BOOTSTRAP.md` for cross-AI startup
- **Never overwrite** existing `CLAUDE.md`, `AGENT.md`, `AGENTS.md`, or `AI_BOOTSTRAP.md`
- Update `.gitignore` for session-specific files
- Show warnings for any conflicts

## Structure

```
agent-rules/
├── AGENT_RULES.md          # Complete rule set (single file, all-in-one)
├── rules/                  # Individual rule files (granular)
│   ├── startup.md          # Session startup protocol (mandatory 3-read)
│   ├── iteration.md        # 6-step iteration cycle
│   ├── todo-management.md  # Four-quadrant TODO + archive lifecycle
│   ├── plan-quality.md     # Plan quality gates (preflight + challenge)
│   ├── code-redlines.md    # Code quality hard limits + security
│   ├── error-handling.md   # Error escalation protocol (max 2 retries)
│   ├── documentation.md    # Documentation sync rules
│   ├── sensitive-ops.md    # Sensitive operation guardrails
│   ├── worktree.md         # Git worktree parallel development
│   ├── cross-agent-review.md  # a2a review trigger rules
│   ├── multi-ai-handoff.md    # Multi-AI task handoff protocol
│   └── rule-sync.md        # Rules for modifying rules
├── templates/              # Copy to your project
│   ├── AGENTS.md           # Codex bootstrap entry
│   ├── AI_BOOTSTRAP.md     # Cross-AI startup guide
│   └── .ai/                # State management infrastructure
│       ├── manifest.json   # Project state (single source of truth)
│       ├── workflow.md     # Execution flow reference
│       ├── plan/
│       │   ├── current.md  # Current task plan template
│       │   └── TODO.md     # Four-quadrant TODO template
│       ├── startup/
│       │   └── STARTUP_BRIEF.md  # Session recovery brief
│       ├── summaries/      # Review outputs go here
│       └── modules/
│           └── _template/
│               └── doc.md  # Module documentation template
├── docs/
│   ├── agent-rules-overview.md
│   └── diagrams/
│       ├── README.md
│       └── agent-rules-overview.elements.json
└── LICENSE
```

## Two Layers

| Layer | Purpose | Where |
|-------|---------|-------|
| **Rules** | Behavioral constraints — what AI must/must not do | `AGENT_RULES.md` + `rules/` |
| **Templates** | State infrastructure and startup entry files | `templates/` |

Rules tell the AI HOW to behave. Templates give it WHERE to persist state.

## Rule Categories

| Rule | What It Enforces |
|------|-----------------|
| Startup | Read project state before doing anything |
| Iteration | 6-step cycle, plans must be landed not just suggested |
| Plan Quality | 5-dimension preflight + challenge review |
| Code Red Lines | File ≤800 lines, function ≤30 lines, no eval/innerHTML |
| Error Handling | Max 2 retries, then 3 options for user |
| Documentation | Every code change syncs docs, never delete (archive) |
| Sensitive Ops | Confirm before destructive/irreversible actions |
| Worktree | Git worktree for parallel, don't auto-delete |
| Cross-Agent Review | When a2a review is mandatory vs skippable |
| Multi-AI Handoff | Breakpoint protocol for switching models |
| Rule Sync | How to modify rules without breaking things |
| TODO Management | Four-quadrant TODOs, checkbox lifecycle, monthly archive |

## 中文导览

- 稳定入口: [`docs/agent-rules-overview.md`](docs/agent-rules-overview.md)
- 最新中文流程图: [`docs/diagrams/agent-rules-system-map-20260313-110304.elements.json`](docs/diagrams/agent-rules-system-map-20260313-110304.elements.json)

## License

MIT
