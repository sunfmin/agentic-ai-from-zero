#!/usr/bin/env bash
# Lint tutorial chapter files for the conventions in CONTEXT.md and the PRD.
#
# Five rules, in order:
#   1. Chapter file names match NN-slug.md (zero-padded, lowercase ASCII slug)
#   2. Each chapter file's first non-title line is a well-formed calibration header
#   3. zh/ files do not contain disallowed Chinese terms (e.g. 技能 for "skill")
#   4. zh/ and en/ have the same chapter file names (mirror translation)
#   5. STATUS.md has a row for every chapter file
#
# Exits non-zero if any rule is violated. Prints each violation to stderr.

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ZH_DIR="$ROOT/tutorial/zh"
EN_DIR="$ROOT/tutorial/en"
STATUS_FILE="$ROOT/STATUS.md"

FAIL=0

err() {
    echo "FAIL: $*" >&2
    FAIL=1
}

list_chapters() {
    # List chapter files in a directory: any file matching [0-9][0-9]-*.md
    local dir="$1"
    [[ -d "$dir" ]] || return 0
    find "$dir" -maxdepth 1 -name '[0-9][0-9]-*.md' -type f -print 2>/dev/null | sort
}

# Rule 1: file-name regex
check_file_names() {
    for dir in "$ZH_DIR" "$EN_DIR"; do
        [[ -d "$dir" ]] || continue
        # Look at every .md in dir except README.md
        find "$dir" -maxdepth 1 -name '*.md' -type f ! -name 'README.md' | while read -r f; do
            name="$(basename "$f")"
            if ! [[ "$name" =~ ^[0-9]{2}-[a-z0-9-]+\.md$ ]]; then
                echo "RULE1 $f: file name does not match NN-slug.md"
            fi
        done
    done
}

# Rule 2: calibration header
check_calibration_header() {
    # en pattern: _Last calibrated: YYYY-MM, against Claude Code vX.Y_ (or 'never')
    while read -r f; do
        [[ -z "$f" ]] && continue
        header="$(awk 'NR>1 && NF>0 {print; exit}' "$f")"
        if ! echo "$header" | grep -qE '^_Last calibrated: ([0-9]{4}-[0-9]{2}, against Claude Code v[0-9A-Za-z.]+|never)_$'; then
            echo "RULE2 $f: calibration header malformed or missing — got: '$header'"
        fi
    done < <(list_chapters "$EN_DIR")

    # zh pattern: _上次校对：YYYY-MM，对齐 Claude Code vX.Y_ (or 'never')
    while read -r f; do
        [[ -z "$f" ]] && continue
        header="$(awk 'NR>1 && NF>0 {print; exit}' "$f")"
        if ! echo "$header" | grep -qE '^_上次校对：([0-9]{4}-[0-9]{2}，对齐 Claude Code v[0-9A-Za-z.]+|never)_$'; then
            echo "RULE2 $f: calibration header malformed or missing — got: '$header'"
        fi
    done < <(list_chapters "$ZH_DIR")
}

# Rule 3: disallowed Chinese terms in zh files
check_disallowed_terms() {
    # Per CONTEXT.md: "skill" is never translated to "技能" in zh prose.
    [[ -d "$ZH_DIR" ]] || return 0
    find "$ZH_DIR" -maxdepth 1 -name '*.md' -type f | while read -r f; do
        if grep -nH '技能' "$f" 2>/dev/null; then
            echo "RULE3 $f contains '技能' — use 'skill' (untranslated) per CONTEXT.md"
        fi
    done
}

# Rule 4: zh/en chapter-file-name parity
check_parity() {
    local zh_names en_names
    zh_names="$(list_chapters "$ZH_DIR" | xargs -n1 basename 2>/dev/null | sort)"
    en_names="$(list_chapters "$EN_DIR" | xargs -n1 basename 2>/dev/null | sort)"
    if [[ "$zh_names" != "$en_names" ]]; then
        echo "RULE4 zh/ and en/ chapter file names diverge:"
        diff <(echo "$zh_names") <(echo "$en_names") | sed 's/^/  /'
    fi
}

# Rule 5: every chapter file has a STATUS.md row
check_status_rows() {
    if [[ ! -f "$STATUS_FILE" ]]; then
        echo "RULE5 STATUS.md not found at repo root"
        return
    fi
    while read -r f; do
        [[ -z "$f" ]] && continue
        slug="$(basename "$f" .md)"
        if ! grep -qF "$slug" "$STATUS_FILE"; then
            echo "RULE5 STATUS.md missing row for chapter '$slug'"
        fi
    done < <(list_chapters "$ZH_DIR")
}

# Collect violations from all checks
violations=""
violations+="$(check_file_names)"$'\n'
violations+="$(check_calibration_header)"$'\n'
violations+="$(check_disallowed_terms)"$'\n'
violations+="$(check_parity)"$'\n'
violations+="$(check_status_rows)"$'\n'

# Print non-empty violations
trimmed="$(echo "$violations" | grep -v '^$' || true)"
if [[ -n "$trimmed" ]]; then
    echo "$trimmed" >&2
    echo "" >&2
    echo "Lint failed." >&2
    exit 1
fi

echo "Lint passed."
