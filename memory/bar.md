---
name: bar
description: Theme, bar widgets and dock that the script restores - Catppuccin, Pomodoro, world clock, dock autohide
type: project
updated: 2026-10-28
---

- 2026-10-28: before moving the project to another Mac (M1), the VM had things done outside the script that would have been lost: theme **Catppuccin**, a **Pomodoro** bar widget (a plugin in `~/.config/omarchy/plugins/<user>.pomodoro`, made in an earlier session), **world clock cities** on `omarchy.elsewhen` and **dock autohide**. All of them are in the script now (`set_theme`, `install_bar`).
- The plugin lives in `assets/pomodoro/` with `__USER__` in place of the username (kept out of git); the script replaces it with `$USER`.
- `omarchy bar put` fails right after copying a new plugin, because the shell hasn't discovered it yet. The script retries for up to 10 seconds.
- `omarchy bar set omarchy.elsewhen zones ...` also writes a `cities` array next to `zones`. That's Omarchy's doing and harmless.
- `THEME=` and `CLOCK_ZONES=` override the defaults; empty leaves them alone.
