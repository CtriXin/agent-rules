# Rule Sync Principle

## When Rules Themselves Change

If any AI adds, modifies, or deprecates project conventions (style, naming, API patterns, security policy, architecture decisions):

1. **Must sync-update AGENT.md / CLAUDE.md** in the corresponding section
2. Add a change marker at the end of the modified section:
   ```markdown
   <!-- Updated: YYYY-MM-DD by AgentName — reason -->
   ```
3. If the change affects other projects using the same rules, propagate to the shared rules repo

## Rule Hierarchy

When conflicts exist between rule sources:

```
Project AGENT.md / CLAUDE.md  (highest priority — project-specific)
    ↓
Shared agent-rules repo       (defaults — technology-agnostic)
    ↓
Global ~/.claude/CLAUDE.md    (user preferences — lowest for project rules)
```

Project-level rules always override shared rules for that project.

## Adding New Rules

Before adding a new rule, verify:
- Is it **recurring**? (appeared in 2+ situations)
- Is it **actionable**? (tells the AI what to do, not just what to think)
- Is it **verifiable**? (can check if the rule was followed)
- Is it **not already covered** by an existing rule?

If yes to all → add to the appropriate rule file + update AGENT.md.

## Deprecating Rules

Never silently remove a rule. Instead:
1. Mark as deprecated with reason
2. Move to an archive section or file
3. Update any references
