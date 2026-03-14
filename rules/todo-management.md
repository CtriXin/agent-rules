# TODO Management Rules

> Ensures all agents maintain a structured, traceable TODO system using the Eisenhower Matrix (four quadrants).

## Core Principle

**File system is the single source of truth for TODOs.** Agents must not rely on memory or session state.

---

## 1. Four-Quadrant Default Behavior

When an agent enters **Plan phase** or receives a **new task**, it MUST:

1. Read existing TODOs from `.ai/plan/TODO.md` (project-level)
2. List all relevant TODOs in **four-quadrant format**
3. Write updates back to the TODO file

### Quadrant Format

```markdown
## Urgent + Important
- [ ] item (source: @claude, created: 2026-03-14)

## Important + Not Urgent
- [ ] item (source: @codex, created: 2026-03-14)

## Urgent + Not Important
- [ ] item (source: @user, created: 2026-03-14)

## Not Urgent + Not Important
- [ ] item (source: @claude, created: 2026-03-14)
```

### Required Metadata Per Item

| Field | Required | Example |
|-------|----------|---------|
| `source` | Yes | `@claude`, `@codex`, `@user`, `@openclaw` |
| `created` | Yes | `2026-03-14` |
| `completed` | On completion | `2026-03-14` |
| `context` | Optional | Brief note on why this matters |

---

## 2. Lifecycle: Checkbox Iteration

TODO items follow a strict lifecycle:

```
[ ] pending  →  [x] completed (add completed date)  →  archived (moved to archive file)
```

### On Completion

When marking a TODO as done:
```markdown
- [x] Implement OAuth usage query (source: @claude, created: 2026-03-12, completed: 2026-03-14)
```

### Archive Trigger

At the **start of each plan phase**, the agent MUST:
1. Scan `.ai/plan/TODO.md` for completed items (`[x]`)
2. Move them to `docs/archive/todo-archive-YYYY-MM.md` (monthly shard)
3. Remove them from the active TODO file

---

## 3. Archive Format

Archive files are **append-only, never deleted**. Monthly shards for traceability.

```markdown
# TODO Archive — 2026-03

## Archived: 2026-03-14
- [x] Fix token cache keyed by account UUID (source: @claude, created: 2026-03-10, completed: 2026-03-14)
- [x] Add API key provider usage section (source: @codex, created: 2026-03-11, completed: 2026-03-13)

## Archived: 2026-03-12
- [x] Wire synthesizer fallback chain (source: @claude, created: 2026-03-08, completed: 2026-03-12)
```

### Archive Rules

- One file per month: `todo-archive-YYYY-MM.md`
- Group by archive date, newest first
- Preserve all metadata (source, created, completed)
- **Never delete archive files** — they are the historical record
- Archive location: `docs/archive/` (create if not exists)

---

## 4. Scope

| Scope | TODO File | Archive Location |
|-------|-----------|-----------------|
| Project-level | `.ai/plan/TODO.md` | `docs/archive/todo-archive-YYYY-MM.md` |
| Global (cross-project) | `~/.openclaw/TODO.md` | Managed separately per global rules |

### Global TODO Sync

When a TODO clearly belongs to the global kanban (`~/.openclaw/TODO.md`), the agent should:
1. Add it to the global file with proper source tag
2. Reference it in the project TODO with a note: `(see global TODO)`

---

## 5. Integration with Iteration Cycle

This rule extends **Section 3 (Iteration Discipline)**:

- **Step 1 (Read)**: Read `.ai/plan/TODO.md`, archive completed items
- **Step 2 (Plan)**: List new TODOs in four-quadrant format
- **Step 5 (Doc Sync)**: Update TODO status, mark completions
- **Step 6 (Update Plan)**: Ensure TODO file reflects current state
