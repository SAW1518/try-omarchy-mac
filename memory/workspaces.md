---
name: workspaces
description: Workspace modes (tiling, scrolling, floating), ⌘L, and workspace 2 in floating mode
type: project
updated: 2026-10-27
---

- Hyprland in Omarchy has three modes per workspace: **dwindle** (tiling, the default), **scrolling** (columns you scroll through) and **floating** (loose windows, with a dock at the bottom). ⌘L cycles them, ⌘⌥L goes backwards. Each choice is saved in `~/.local/state/omarchy/workspace-layouts/<n>.lua`.
- 2026-10-27: the user noticed workspace 2 "behaved differently". It had been floating since 13:19, probably from pressing ⌘L out of Mac habit (address bar). They were told how to switch it back with ⌘L; nothing was changed.
- I offered to move "cycle workspace layout" to ⌘⇧L so it doesn't happen again. No answer yet.
- "Invert the layout": ⌘J flips the split between side by side and top/bottom. Swapping windows (formerly ⌘⇧+arrows) was replaced by Rectangle. I offered to put it on ⌘⌥+arrows (⌘⌃+arrows is taken by Omarchy groups) and they said **"not for now, leave it"**. Don't offer it again unless they ask.
