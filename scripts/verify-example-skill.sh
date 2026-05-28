#!/usr/bin/env bash
# Verify a review-writing example skill by installing it into a sandboxed
# Claude Code config directory, running a non-interactive session against
# the fixture draft, and asserting the response references at least one of
# the four principle codes (P1..P4).
#
# Usage:
#   scripts/verify-example-skill.sh review-writing-v1
#   scripts/verify-example-skill.sh review-writing-v2
#
# This script costs Claude Code API time to run. Per ADR-0002 + PRD Testing
# Decisions, it is a manual-run script — not part of any commit-time CI.
# Run it before bumping the calibration header on chapter 6 or chapter 7.
#
# Requirements:
#   - claude (Claude Code CLI) installed and logged in
#   - the user's normal Claude Pro / Max / API auth is active
#
# Side-effect isolation:
#   - Uses a temporary CLAUDE_CONFIG_DIR so the real ~/.claude/skills/ is
#     untouched.
#   - Cleans up on exit via trap.

set -euo pipefail

SKILL_NAME="${1:-}"
if [[ -z "$SKILL_NAME" ]]; then
    echo "usage: $0 <review-writing-v1|review-writing-v2>" >&2
    exit 2
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_DIR="$ROOT/tutorial/skills/$SKILL_NAME"
FIXTURE="$SKILL_DIR/fixture-draft.md"

if [[ ! -d "$SKILL_DIR" ]]; then
    echo "FAIL: skill directory not found at $SKILL_DIR" >&2
    exit 1
fi
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
    echo "FAIL: SKILL.md not found in $SKILL_DIR" >&2
    exit 1
fi
if [[ ! -f "$FIXTURE" ]]; then
    # v2 may reuse v1's fixture; fall back to that
    FIXTURE="$ROOT/tutorial/skills/review-writing-v1/fixture-draft.md"
    if [[ ! -f "$FIXTURE" ]]; then
        echo "FAIL: no fixture-draft.md available" >&2
        exit 1
    fi
fi

if ! command -v claude >/dev/null 2>&1; then
    echo "FAIL: 'claude' not found on PATH. Install Claude Code first." >&2
    exit 1
fi

SANDBOX="$(mktemp -d)"
trap 'rm -rf "$SANDBOX"' EXIT

mkdir -p "$SANDBOX/skills"
# Copy the skill folder into the sandbox skills/ tree.
cp -R "$SKILL_DIR" "$SANDBOX/skills/$SKILL_NAME"

# Prepare a workspace directory with the fixture so Claude operates on it.
WORKSPACE="$SANDBOX/workspace"
mkdir -p "$WORKSPACE"
cp "$FIXTURE" "$WORKSPACE/draft.md"

echo "Sandbox: $SANDBOX"
echo "Skill:   $SKILL_NAME"
echo "Fixture: $(basename "$FIXTURE")"
echo ""

# Run Claude Code non-interactively. The exact flag for one-shot non-interactive
# mode is CLAUDE_CONFIG_DIR-aware; consult `claude --help` if this stops working.
OUTPUT="$(
    cd "$WORKSPACE"
    CLAUDE_CONFIG_DIR="$SANDBOX" claude --print "Review the draft in draft.md against your writing principles." 2>&1
)"

echo "--- Claude output ---"
echo "$OUTPUT"
echo "---------------------"

# Assert: output mentions at least one principle code (P1..P4).
if echo "$OUTPUT" | grep -qE '\bP[1-4]\b'; then
    echo ""
    echo "PASS: response references at least one principle code."
    exit 0
else
    echo ""
    echo "FAIL: response did not reference any of P1..P4. Skill may not have triggered." >&2
    exit 1
fi
