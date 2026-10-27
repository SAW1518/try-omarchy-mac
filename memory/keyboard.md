---
name: keyboard
description: latam keyboard and why kb_model must be forced to pc105 under Try Omarchy
type: project
updated: 2026-10-27
---

- The layout is `latam`. The script sets it through Omarchy's own mechanism (`typing_setup.py apply keyboard`), which also syncs Fcitx5.
- **Problem (2026-10-27):** `?` came out as `_`. Cause: Try Omarchy sets `kb_model=applealu_<iso|ansi|jis>` (`/usr/share/try-omarchy/apple-keyboard-input.lua`). With that model XKB loads `macintosh_vndr/latam` ("Spanish (Latin American, Macintosh)"), which places keys differently from the labels on this keyboard. Plain `latam` (`pc+latam`) does match the photo.
- **Fix:** `assets/zzz-keyboard-pc.lua` → `~/.local/state/omarchy/toggles/hypr/`, with `hl.config({ input = { kb_model = "pc105" } })`. It's named `zzz-` so it loads after `zz-try-omarchy.lua`. The script installs it.
- To check which key types a character: `xkbcli how-to-type --model pc105 --layout latam '?'`.
- Right Option acts as AltGr: `@` = right Option + Q.
- Not confirmed yet: `| °` (key next to 1) and `< >` (key next to Z). On Mac ISO keyboards inside a VM they sometimes come out swapped (see [[pending]]).
