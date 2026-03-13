# Documentation Sync Rules

## Core Principle

**Every code change must sync corresponding documentation.**

This is not optional. Outdated documentation is worse than no documentation because it actively misleads.

## When to Update

| Code Change | Doc Update Required |
|-------------|-------------------|
| New file/module | Create module doc |
| Modified behavior | Update module doc |
| New API/endpoint | Update API docs |
| Changed scripts | Sync scripts index |
| Architecture change | Update diagrams |
| Sprint progress | Update PLAN.md + TODO.md |

## How to Handle Outdated Docs

**Never directly delete documentation.** Instead:

1. Move to `docs/archive/` with classification:
   - `docs/archive/outdated/` — no longer accurate
   - `docs/archive/revised/` — replaced by newer version
   - `docs/archive/deprecated/` — feature removed
2. Name format: `YYYYMMDD-original_name-reason.md`

## Diagram Maintenance

If the project has architecture diagrams:
- Patch incrementally after structural changes
- Don't wait for user to ask — update proactively
- Keep diagram source files (`.elements.json`, `.excalidraw`) as truth

## Minimum Update

Even if a code change is minor, at minimum update the "last modified" or changelog section of the relevant doc.
