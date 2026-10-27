#!/usr/bin/env bash
#
# update-skills.sh — copies the skills that ship with Omarchy (omarchy,
# omarchy-app, diagnose-crash) into this project and fixes their paths for it.
#
# Run it INSIDE OMARCHY after every update:
#
#   bash ~/bypass/omarchy-mac/update-skills.sh
#
# The originals live in $OMARCHY_PATH/default/agents/skills and ~/.claude/skills
# only holds links to them, which don't work from the Mac or survive a new VM.
# The copies here are real files named with a -project suffix so they don't clash
# with the originals (personal skills win over project ones with the same name).
# They're not committed to git (see .gitignore): they belong to Omarchy.

set -euo pipefail

SRC="${OMARCHY_PATH:-/usr/share/omarchy}/default/agents/skills"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$PROJECT_DIR/.claude/skills"
VERSION=$(omarchy version 2>/dev/null || echo "unknown version")

[[ -d $SRC ]] || { echo "$SRC not found: run this inside Omarchy." >&2; exit 1; }

NOTE="> **omarchy-mac project copy**, taken from Omarchy $VERSION by \`update-skills.sh\`.
> Differences from the original:
> - Try Omarchy wipes \`~/.config\` when it recreates the VM. Anything that must last goes in the project: shortcuts in \`lua_block\` of \`~/bypass/omarchy-mac/migrate-to-omarchy.sh\`, files in \`~/bypass/omarchy-mac/assets/\` (installed by that script). Editing \`~/.config\` directly is fine for trying things out, but then move it into the script.
> - Don't hand-edit the \`-- >>> mac-migration\` block in \`~/.config/hypr/bindings.lua\`: the script rewrites it.
> - New projects go in \`~/bypass/omarchy-mac/apps/<name>\`, not \`~/Work\`, which is also lost with the VM.
> - If \`omarchy version\` is no longer $VERSION, run \`update-skills.sh\` again."

for skill in omarchy omarchy-app diagnose-crash; do
  [[ -d $SRC/$skill ]] || { echo "Omarchy no longer ships the $skill skill; skipping it." >&2; continue; }
  out="$DEST/$skill-project"
  rm -rf "$out"
  cp -rL "$SRC/$skill" "$out"
  chmod -R u+w "$out"

  # Suffixed name, and the note right after the frontmatter.
  sed -i "0,/^name: $skill\$/s//name: $skill-project/" "$out/SKILL.md"
  awk -v note="$NOTE" 'NR > 1 && !done && /^---$/ { print; print ""; print note; done = 1; next } { print }' \
    "$out/SKILL.md" >"$out/SKILL.md.tmp"
  mv "$out/SKILL.md.tmp" "$out/SKILL.md"
done

# Paths that don't work in this project.
[[ ! -f $DEST/omarchy-app-project/SKILL.md ]] ||
  sed -i 's#`~/Work/<name>`#`~/bypass/omarchy-mac/apps/<name>`#g' "$DEST/omarchy-app-project/SKILL.md"

echo "Skills copied to $DEST (Omarchy $VERSION):"
ls -1 "$DEST"
