#!/usr/bin/env bash
# Content lint for LQC Jekyll site.
#
# Catches four classes of bugs that recurred in community edits:
#   1. ERROR: regular files in docs/Events/ without a .md extension
#      (Jekyll silently skips them, causing invisible duplicate drafts).
#   2. ERROR: .md files whose front matter declares parent: "Upcoming Events"
#      or "Past Events" but which live outside docs/Events/
#      (breaks URL structure and nav hierarchy).
#   3. WARN:  duplicate nav_order values among sibling event pages
#      (same parent, same nav_order -> unstable ordering).
#   4. WARN:  docs/Events/*.md containing TBD or TBC placeholders
#      (stale drafts left past the event date).
#
# Usage: bash .github/scripts/content-lint.sh
# Exits 1 on ERRORs, 0 otherwise. Warnings always print but never fail.

set -u
errors=0

# --- Check 1: extensionless files under docs/Events/ -------------------------
if [ -d docs/Events ]; then
  while IFS= read -r f; do
    case "$f" in
      *.md) ;;
      *)
        echo "ERROR: $f is missing .md extension — Jekyll will not render it as a page."
        errors=$((errors + 1))
        ;;
    esac
  done < <(find docs/Events -type f)
fi

# --- Check 2: event pages outside docs/Events/ -------------------------------
while IFS= read -r f; do
  case "$f" in
    docs/Events/*) ;;
    *)
      echo "ERROR: $f declares 'parent: Upcoming Events' or 'parent: Past Events' but is not under docs/Events/."
      errors=$((errors + 1))
      ;;
  esac
done < <(grep -rlE '^parent: (Upcoming Events|Past Events)$' --include='*.md' docs/ 2>/dev/null || true)

# --- Check 3: duplicate nav_order among siblings -----------------------------
# Extract parent|nav_order|file from the first YAML block of each event page.
dup=$(
  for f in docs/Events/*.md; do
    [ -f "$f" ] || continue
    awk -v file="$f" '
      BEGIN { infm=0; seen=0; parent=""; nav="" }
      /^---[[:space:]]*$/ { if (!seen) { infm=1; seen=1; next } else { exit } }
      infm && /^parent:[[:space:]]*/    { sub(/^parent:[[:space:]]*/, ""); parent=$0 }
      infm && /^nav_order:[[:space:]]*/ { sub(/^nav_order:[[:space:]]*/, ""); nav=$0 }
      END { if (parent != "" && nav != "") printf "%s|%s|%s\n", parent, nav, file }
    ' "$f"
  done | sort
)
if [ -n "$dup" ]; then
  collisions=$(printf '%s\n' "$dup" | awk -F'|' '{ key=$1"|"$2; c[key]++; files[key]=files[key]" "$3 } END { for (k in c) if (c[k]>1) printf "%s =>%s\n", k, files[k] }')
  if [ -n "$collisions" ]; then
    echo "WARN: duplicate (parent, nav_order) pairs among event pages:"
    printf '  %s\n' "$collisions" | sed 's/^  /  /'
  fi
fi

# --- Check 4: TBD / TBC placeholders in event body ---------------------------
while IFS= read -r f; do
  [ -n "$f" ] && echo "WARN: $f still contains TBD/TBC placeholder text."
done < <(grep -rilE '\b(TBD|TBC)\b' --include='*.md' docs/Events/ 2>/dev/null || true)

if [ "$errors" -gt 0 ]; then
  echo "content-lint: $errors error(s)." >&2
  exit 1
fi
exit 0
