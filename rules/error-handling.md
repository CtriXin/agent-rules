# Error Handling Protocol

## Escalation Ladder

### Attempt 1: Chain-of-Thought Fix
- Read the error message carefully
- Trace the root cause through the code
- Apply a targeted fix
- Verify the fix resolves the issue

### Attempt 2: System Mode 2 (if first fix didn't work)
- Stop trying the same approach
- Analyze the root cause systematically
- Present **3 alternative approaches**, each with:
  - What it does
  - Pros
  - Cons
  - Risk level
- Let user choose which approach to take

### Hard Stop: Never retry the same error more than 2 times.

If both attempts fail on the same error, you MUST escalate to the user with a clear summary:
- What you tried (both attempts)
- Why each failed
- What you think the actual root cause is
- What information or access you're missing

## Anti-Patterns (Never Do These)

- Retry the same command in a loop hoping it works
- Suppress errors with empty catch blocks
- Add `try/catch` that swallows exceptions silently
- Blame external factors without evidence
- Delete files or state to "reset" around an error
