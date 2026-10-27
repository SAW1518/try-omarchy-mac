---
name: shortcuts
description: Which Mac shortcut maps to what in Omarchy, and the user's decisions
type: project
updated: 2026-10-27
---

User decisions (2026-10-27):
- **From Rectangle, only their 9 ⌘⇧ shortcuts**, not the factory ⌃⌥ ones. They go on SUPER+SHIFT: arrows = halves; Enter = maximize; N / Delete = first / last third; Insert / M = two thirds. `~/.local/bin/rectangle` does it: it floats the window and computes its position.
- **⌃V opens clipboard history**, like in Alfred (`{ panel = "omarchy.clipboard" }`). Paste stays on ⌘V.
- **⌘Space opens Apps** (`omarchy-shell omarchy.dock apps`, the Alfred-like launcher) and **⌘K opens the Omarchy menu**. It was the other way around first, and the user asked to swap them. The keybindings list is on ⌘⇧K.
- **Obsidian:** SUPER+ALT+O finds a note, SUPER+SHIFT+ALT+O opens the menu (`~/.local/bin/obsidian-menu`). Not working yet because the vault isn't in the VM (see [[pending]]).
- **Files:** ⌘⇧F opens Thunar instead of Nautilus; ⌘⌥⇧F opens it in the terminal's folder (see [[files]]).

Omarchy shortcuts that get replaced: swap windows (SUPER+SHIFT+arrows), editor (SUPER+SHIFT+N), music (SUPER+SHIFT+M) and the second browser shortcut (SUPER+SHIFT+Enter; the browser stays on SUPER+SHIFT+B).

History: the first version (2026-10-16) used `o.rebind`, which didn't exist in that release, and caused the red error bar. Now it uses `hl.unbind` + `o.bind` (`o.rebind` exists again in r7343). If `hyprctl configerrors` shows a new error, the script restores `bindings.lua`.

2026-10-27: with ⌘⇧N/⌘⇧M the windows looked "maximized", flush against the edges. The user wanted them to stay tiled, but dwindle can't do exact thirds. So they stay floating, but now use the same spacing as the tiling (gaps_out at the edges, gaps_in between windows, read from Hyprland) and account for the border. `RECT_GAP=N` forces a fixed gap. The user confirmed it looks good.
