#!/usr/bin/env bash
set -euo pipefail

skill_dir="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
skill_file="$skill_dir/SKILL.md"

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

[[ -f "$skill_file" ]] || fail "SKILL.md is missing"
[[ "$(head -n 1 "$skill_file")" == "---" ]] || fail "SKILL.md must start with YAML frontmatter"

grep -q '^name: [a-z0-9][a-z0-9-]*[a-z0-9]$\|^name: [a-z0-9]$' "$skill_file" || fail "name is missing or invalid"
grep -q '^description: .\+' "$skill_file" || fail "description is missing"

name="$(sed -n 's/^name: //p' "$skill_file" | head -n 1)"
parent="$(basename "$skill_dir")"
[[ "$name" == "$parent" ]] || fail "name must match parent directory: $parent"
[[ ${#name} -le 64 ]] || fail "name exceeds 64 characters"
[[ "$name" != *--* ]] || fail "name contains consecutive hyphens"

for ref in phase-selection.md phase-contracts.md command-details.md specification-sources.md; do
  [[ -f "$skill_dir/references/$ref" ]] || fail "missing reference: references/$ref"
done

printf 'OK: %s passed structural validation\n' "$skill_file"
