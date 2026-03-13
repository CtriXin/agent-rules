#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# Agent Rules — One-Click Setup
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/CtriXin/agent-rules/main/setup.sh | bash
#   OR
#   cd your-project && bash /path/to/agent-rules/setup.sh
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

# ── Colors ──────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; }
err()  { echo -e "  ${RED}✗${NC} $1"; }
info() { echo -e "  ${CYAN}→${NC} $1"; }

# ── Header ──────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}═══════════════════════════════════════${NC}"
echo -e "${BOLD}  Agent Rules — Project Setup${NC}"
echo -e "${BOLD}═══════════════════════════════════════${NC}"
echo ""

# ── Detect source (local clone or remote) ───────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}" 2>/dev/null)" && pwd 2>/dev/null || echo "")"
REMOTE_BASE="https://raw.githubusercontent.com/CtriXin/agent-rules/main"
USE_REMOTE=false
TMPDIR_CLEANUP=""

if [[ -z "$SCRIPT_DIR" ]] || [[ ! -f "$SCRIPT_DIR/AGENT_RULES.md" ]]; then
    USE_REMOTE=true
    info "Downloading from GitHub..."
    SCRIPT_DIR=$(mktemp -d)
    TMPDIR_CLEANUP="$SCRIPT_DIR"

    # Download all needed files
    mkdir -p "$SCRIPT_DIR/templates/.ai/plan" \
             "$SCRIPT_DIR/templates/.ai/startup" \
             "$SCRIPT_DIR/templates/.ai/summaries" \
             "$SCRIPT_DIR/templates/.ai/modules/_template"

    curl -fsSL "$REMOTE_BASE/AGENT_RULES.md" -o "$SCRIPT_DIR/AGENT_RULES.md"
    curl -fsSL "$REMOTE_BASE/templates/.ai/manifest.json" -o "$SCRIPT_DIR/templates/.ai/manifest.json"
    curl -fsSL "$REMOTE_BASE/templates/.ai/workflow.md" -o "$SCRIPT_DIR/templates/.ai/workflow.md"
    curl -fsSL "$REMOTE_BASE/templates/.ai/plan/current.md" -o "$SCRIPT_DIR/templates/.ai/plan/current.md"
    curl -fsSL "$REMOTE_BASE/templates/.ai/startup/STARTUP_BRIEF.md" -o "$SCRIPT_DIR/templates/.ai/startup/STARTUP_BRIEF.md"
    curl -fsSL "$REMOTE_BASE/templates/.ai/modules/_template/doc.md" -o "$SCRIPT_DIR/templates/.ai/modules/_template/doc.md"
    ok "Downloaded"
fi

TARGET_DIR="$(pwd)"
echo -e "  ${DIM}Target: ${TARGET_DIR}${NC}"
echo ""

# ── Check: is this a project directory? ─────────────────────────
if [[ ! -f "$TARGET_DIR/package.json" ]] && \
   [[ ! -f "$TARGET_DIR/pyproject.toml" ]] && \
   [[ ! -f "$TARGET_DIR/Cargo.toml" ]] && \
   [[ ! -f "$TARGET_DIR/go.mod" ]] && \
   [[ ! -f "$TARGET_DIR/Makefile" ]] && \
   [[ ! -d "$TARGET_DIR/.git" ]] && \
   [[ ! -f "$TARGET_DIR/README.md" ]]; then
    warn "This doesn't look like a project directory."
    echo -n "  Continue anyway? [y/N] "
    read -r answer
    [[ "$answer" =~ ^[Yy] ]] || { echo "  Aborted."; exit 0; }
fi

# ── Step 1: Create .ai/ structure ───────────────────────────────
echo -e "${BOLD}Step 1: State management (.ai/)${NC}"

CONFLICTS=()

if [[ -d "$TARGET_DIR/.ai" ]]; then
    warn ".ai/ already exists — will merge without overwriting"
fi

# Copy each file, skip if exists
copy_if_new() {
    local src="$1" dst="$2" label="$3"
    mkdir -p "$(dirname "$dst")"
    if [[ -f "$dst" ]]; then
        warn "${label} — already exists, ${YELLOW}skipped${NC}"
        CONFLICTS+=("$dst")
    else
        cp "$src" "$dst"
        ok "${label}"
    fi
}

copy_if_new "$SCRIPT_DIR/templates/.ai/manifest.json" \
            "$TARGET_DIR/.ai/manifest.json" \
            ".ai/manifest.json"

copy_if_new "$SCRIPT_DIR/templates/.ai/workflow.md" \
            "$TARGET_DIR/.ai/workflow.md" \
            ".ai/workflow.md"

copy_if_new "$SCRIPT_DIR/templates/.ai/plan/current.md" \
            "$TARGET_DIR/.ai/plan/current.md" \
            ".ai/plan/current.md"

copy_if_new "$SCRIPT_DIR/templates/.ai/startup/STARTUP_BRIEF.md" \
            "$TARGET_DIR/.ai/startup/STARTUP_BRIEF.md" \
            ".ai/startup/STARTUP_BRIEF.md"

copy_if_new "$SCRIPT_DIR/templates/.ai/modules/_template/doc.md" \
            "$TARGET_DIR/.ai/modules/_template/doc.md" \
            ".ai/modules/_template/doc.md"

# Ensure summaries dir exists
mkdir -p "$TARGET_DIR/.ai/summaries"
ok ".ai/summaries/ (directory)"

echo ""

# ── Step 2: Handle CLAUDE.md / AGENT.md ─────────────────────────
echo -e "${BOLD}Step 2: AI rules file${NC}"

HAS_CLAUDE=false
HAS_AGENT=false
RULES_INSTALLED=false

[[ -f "$TARGET_DIR/CLAUDE.md" ]] && HAS_CLAUDE=true
[[ -f "$TARGET_DIR/AGENT.md" ]] && HAS_AGENT=true

if $HAS_CLAUDE && $HAS_AGENT; then
    # Both exist
    warn "Both CLAUDE.md and AGENT.md exist"
    warn "Agent rules saved as ${CYAN}AGENT_RULES.md${NC} — merge manually"
    cp "$SCRIPT_DIR/AGENT_RULES.md" "$TARGET_DIR/AGENT_RULES.md"
    RULES_INSTALLED=true

elif $HAS_CLAUDE; then
    # Only CLAUDE.md exists
    warn "CLAUDE.md exists — will NOT overwrite"

    # Check if it already contains agent rules
    if grep -q "Iteration Discipline" "$TARGET_DIR/CLAUDE.md" 2>/dev/null; then
        info "CLAUDE.md already contains agent rules, skipping"
    else
        cp "$SCRIPT_DIR/AGENT_RULES.md" "$TARGET_DIR/AGENT_RULES.md"
        ok "Saved as AGENT_RULES.md (reference copy)"
        echo ""
        echo -e "  ${YELLOW}┌─────────────────────────────────────────────────┐${NC}"
        echo -e "  ${YELLOW}│${NC}  To merge, add this line to your CLAUDE.md:     ${YELLOW}│${NC}"
        echo -e "  ${YELLOW}│${NC}                                                 ${YELLOW}│${NC}"
        echo -e "  ${YELLOW}│${NC}  ${CYAN}> See AGENT_RULES.md for collaboration rules${NC}  ${YELLOW}│${NC}"
        echo -e "  ${YELLOW}│${NC}                                                 ${YELLOW}│${NC}"
        echo -e "  ${YELLOW}│${NC}  Or copy specific sections into CLAUDE.md       ${YELLOW}│${NC}"
        echo -e "  ${YELLOW}└─────────────────────────────────────────────────┘${NC}"
        RULES_INSTALLED=true
    fi

elif $HAS_AGENT; then
    # Only AGENT.md exists
    warn "AGENT.md exists — will NOT overwrite"
    cp "$SCRIPT_DIR/AGENT_RULES.md" "$TARGET_DIR/CLAUDE.md"
    ok "Created CLAUDE.md with agent rules"
    info "AGENT.md (existing) + CLAUDE.md (new) will both be loaded"
    RULES_INSTALLED=true

else
    # Neither exists — fresh install
    cp "$SCRIPT_DIR/AGENT_RULES.md" "$TARGET_DIR/CLAUDE.md"
    ok "Created CLAUDE.md with agent rules"
    RULES_INSTALLED=true
fi

echo ""

# ── Step 3: Update .gitignore ───────────────────────────────────
echo -e "${BOLD}Step 3: .gitignore${NC}"

if [[ -f "$TARGET_DIR/.gitignore" ]]; then
    IGNORE_ADDITIONS=()

    # Check each pattern
    for pattern in ".ai/summaries/" ".ai/plan/current.md"; do
        if ! grep -qF "$pattern" "$TARGET_DIR/.gitignore" 2>/dev/null; then
            IGNORE_ADDITIONS+=("$pattern")
        fi
    done

    if [[ ${#IGNORE_ADDITIONS[@]} -gt 0 ]]; then
        echo "" >> "$TARGET_DIR/.gitignore"
        echo "# Agent state (session-specific, don't commit)" >> "$TARGET_DIR/.gitignore"
        for p in "${IGNORE_ADDITIONS[@]}"; do
            echo "$p" >> "$TARGET_DIR/.gitignore"
        done
        ok "Added ${#IGNORE_ADDITIONS[@]} patterns to .gitignore"
    else
        ok ".gitignore already has agent patterns"
    fi
else
    cat > "$TARGET_DIR/.gitignore" <<'GITIGNORE'
# Agent state (session-specific, don't commit)
.ai/summaries/
.ai/plan/current.md
GITIGNORE
    ok "Created .gitignore with agent patterns"
fi

echo ""

# ── Summary ─────────────────────────────────────────────────────
echo -e "${BOLD}═══════════════════════════════════════${NC}"
echo -e "${BOLD}  Setup Complete${NC}"
echo -e "${BOLD}═══════════════════════════════════════${NC}"
echo ""
echo -e "  ${GREEN}Installed:${NC}"
echo "    .ai/manifest.json        — project state"
echo "    .ai/workflow.md           — execution flow"
echo "    .ai/plan/current.md      — task plan template"
echo "    .ai/startup/STARTUP_BRIEF.md — session brief"
echo "    .ai/modules/_template/   — module doc template"
echo "    .ai/summaries/           — review outputs"
$RULES_INSTALLED && echo "    CLAUDE.md or AGENT_RULES.md — AI rules"
echo ""

if [[ ${#CONFLICTS[@]} -gt 0 ]]; then
    echo -e "  ${YELLOW}Skipped (already exist):${NC}"
    for f in "${CONFLICTS[@]}"; do
        echo "    ${f#$TARGET_DIR/}"
    done
    echo ""
fi

if $HAS_CLAUDE || $HAS_AGENT; then
    echo -e "  ${YELLOW}Action needed:${NC}"
    $HAS_CLAUDE && echo "    Review CLAUDE.md — merge agent rules if not present"
    $HAS_AGENT && echo "    Review AGENT.md — check for conflicts with new CLAUDE.md"
    [[ -f "$TARGET_DIR/AGENT_RULES.md" ]] && echo "    AGENT_RULES.md is a reference — merge or delete after review"
    echo ""
fi

echo -e "  ${DIM}Next: Open the project in your AI editor. The agent will"
echo -e "  read .ai/manifest.json on startup and follow the rules.${NC}"
echo ""

# ── Cleanup temp dir if remote mode ─────────────────────────────
if [[ -n "$TMPDIR_CLEANUP" ]]; then
    rm -rf "$TMPDIR_CLEANUP"
fi

exit 0
