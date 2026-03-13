# Iteration Discipline

## 6-Step Cycle (Mandatory)

Every iteration must complete all 6 steps. Skipping any step is a protocol violation.

### Step 1: Read State
- Read plan file (PLAN.md / TODO.md / current task doc)
- Understand current state and breakpoints
- Check for red line constraints
- If task has a different owner → ask user before continuing

### Step 2: Plan
- Decompose task into small, verifiable steps
- Pre-estimate list of files to be modified
- Fill in plan with meta info + checklist

### Step 3: Code
- Execute the plan, obeying code red lines
- One logical change per step, don't bundle unrelated changes

### Step 4: Review
- Self-review code for correctness, security, and style
- Cross-agent review for medium/high risk changes

### Step 5: Documentation Sync
- Update TODO with completed items
- Update architecture diagrams if structure changed
- Update module docs if behavior changed
- Update PLAN.md with current sprint status

### Step 6: Update Plan
- Check off `[x]` completed steps
- Record modified files
- Record key decisions in memory/context section
- On completion: mark status as done

## Key Principle

**Plans must be actionable.** Never leave a plan in "suggestion" state.
- Either execute immediately
- Or explicitly mark as "shelved" with a reason

Don't wait for the user to remind you to update docs or diagrams — do it automatically after every iteration.
