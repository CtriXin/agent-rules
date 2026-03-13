# Git Worktree Parallel Development

## When to Use

- Parallel feature development that shouldn't interfere
- Experimental changes that might be discarded
- Multiple agents working on different features simultaneously

## Rules

1. **Default to worktree** for parallel needs — never make cross-directory changes to main repo while in a worktree
2. **Detached HEAD** → switch to a named branch before starting work
3. **Don't auto-delete** worktrees — user decides when to cleanup
4. Only cleanup when user explicitly says "merge and cleanup"
5. Each worktree = one feature/task, don't mix concerns

## Workflow

```bash
# Create worktree for a feature
git worktree add ../feature-x -b feature-x

# Work in the worktree
cd ../feature-x
# ... make changes ...

# When done, tell user — don't auto-merge
# User decides: merge, keep, or discard
```

## Merge Protocol

1. Run validation (lint, build, tests) in worktree first
2. Merge in user's specified order
3. Cleanup only on user's command
