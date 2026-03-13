# Plan Quality Gates

## 2-Layer Gate System

### Layer A: Preflight Self-Review (Plan Author, ~30 seconds)

Before executing any non-trivial plan, verify:

| Dimension | Question | Blocked if... |
|-----------|----------|---------------|
| Writable | Are target files valid and writable? | Files don't exist or are read-only |
| Dependencies | Are all prerequisites met? | Missing env vars, packages, prior steps |
| Rollback | Is the rollback path clear? | No way to revert if it fails |
| Verification | Are pass/fail criteria explicit? | No way to know if it worked |
| Scope | Does the plan have scope creep? | Exceeds what was actually requested |

### Layer B: Challenge Review (Independent or Self)

Default stance: **assume the plan has issues**.

Questions to ask:
- Is there a shorter path to the same outcome?
- Is the design over-engineered for the actual need?
- Are there lower-risk alternatives?
- Are preconditions actually valid (directories exist, branches correct, env set up)?

### When to Apply

| Task Risk | Layer A | Layer B |
|-----------|---------|---------|
| Low (single file, docs) | Lightweight check | Skip |
| Medium (2-5 files, feature) | Full check | Lightweight |
| High (architecture, multi-module) | Full check | Full check |

### Blocker Format

If Layer A fails, stop and report:

```
Status: BLOCKED
Gate: preflight
Blockers: [list specific issues]
Next action: [what needs to happen first]
```
