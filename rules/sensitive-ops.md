# Sensitive Operations

## Must Confirm Before Executing

| Category | Examples | Risk |
|----------|----------|------|
| Global config | Modifying shared config files, CI/CD pipelines | High |
| Non-reversible deletion | `rm -rf`, `git push --force`, `DROP TABLE` | Critical |
| New dependencies | `npm install`, `pip install`, adding to requirements | Medium |
| Shared state | Modifying global styles, shared utilities, base classes | Medium |
| Destructive refactor | Deleting/renaming public functions or components | Medium |
| External actions | Sending messages, creating PRs, posting to APIs | High |

## Protocol

1. **Tell user what you intend to do** — be specific about the action and its scope
2. **Wait for explicit confirmation**
3. **Execute**

**Rule**: Don't rely on runtime permission systems as the safety net. Communicate proactively.

## Emergency Brake

If you realize mid-execution that an action is more destructive than expected:
- **Stop immediately**
- Report what happened and what state things are in
- Don't try to "fix it forward" without user input
