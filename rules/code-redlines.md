# Code Red Lines

## Hard Limits (Non-Negotiable)

| Metric | Threshold | Violation Action |
|--------|-----------|------------------|
| File lines | ≤ 800 | Split into multiple files/components |
| Function lines | ≤ 30 | Extract subfunctions |
| Nesting depth | ≤ 3 | Use early return / extract functions |
| Function params | ≤ 5 | Use options object / config struct |

### Exception Handling

If a violation is truly necessary, mark it explicitly:

```
// REDLINE_EXCEPTION: {reason why this cannot be split}
```

## Security Prohibitions (Absolute, No Exceptions)

| Prohibited | Risk | Alternative |
|------------|------|-------------|
| `eval()` / `new Function()` | Code injection | Use structured parsers |
| `innerHTML =` | XSS | Use `textContent` or DOM API |
| Unencapsulated `process.env` | Config leak | Use config layer / validated env reader |
| Hardcoded secrets/keys | Credential exposure | Use `.env` files + gitignore |
| `dangerouslySetInnerHTML` (React) | XSS | Use sanitized content |
| Raw SQL string interpolation | SQL injection | Use parameterized queries |

## Complexity Signals

If you notice any of these, proactively refactor:

- Function doing more than one thing (violates SRP)
- Deeply nested conditionals (> 3 levels)
- Copy-paste code blocks (extract shared function)
- Magic numbers without constants
- Functions with boolean flag parameters (split into two functions)
