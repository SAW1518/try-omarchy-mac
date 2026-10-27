---
name: pending
description: What is left to test or solve
type: project
updated: 2026-10-27
---

- [ ] User to confirm that with `pc105` these come out right: `? ¿ ¡ ´ ¨ + * [ { ] } - _ ñ @`, and especially `| °` and `< >`. If `|°` and `<>` are swapped, fix it in `assets/zzz-keyboard-pc.lua` (e.g. with `kb_options` or a custom keymap). See [[keyboard]].
- [ ] Obsidian: the vault isn't in the VM. Sync it (e.g. `omarchy-install-service-dropbox`) and run the script with `VAULT=/path`. Obsidian isn't installed in the VM either (`omarchy-pkg-add obsidian`).
- [ ] Confirm Try Omarchy has Accessibility permission on the Mac, so ⌘⇧← and ⌘K aren't grabbed by the Mac.
- [ ] Old memories about this topic remain in the Mac's own Claude Code memory folder (`~/.claude/projects/<home folder>/memory/`). The user wants all context here; they can be deleted from the Mac.
- [ ] Workspace 2 is still floating; the user knows ⌘L switches it back. Still open whether to move that shortcut to ⌘⇧L. See [[workspaces]].
- [ ] User to say whether they like Thunar with the theme colors (popup menus and dialogs aren't styled). See [[files]].
