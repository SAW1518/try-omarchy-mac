---
name: try-omarchy
description: The Try Omarchy VM, the shared folder, how keys arrive, and the last verified version
type: project
updated: 2026-10-27
---

- **App:** Try Omarchy (github.com/omacom/try-omarchy), an aarch64 QEMU VM on the Mac. It runs Omarchy 4 from the **edge** channel (the `quattro` branch of omacom/omarchy), with Hyprland configured in **Lua** (`~/.config/hypr/*.lua`).
- **Shared folder:** `~/bypass` on the Mac = `/mnt/mac` in the VM, linked as `~/bypass`. Anything that must survive the VM goes there.
- **When the VM is recreated:** only dotfiles (.ssh, .gitconfig…) are copied over; `~/.config` is lost, so the script has to run again. Claude Code is lost too: reinstall it with `mise use -g claude`.
- **Keys:** ⌘ = SUPER, ⌥ = ALT, ⌃ = CTRL. For the VM to catch ⌘⇧← and ⌘K, the app needs Accessibility permission on the Mac (System Settings → Privacy & Security → Accessibility). Without it, Rectangle or Alfred on the Mac grab those keys.
- **Try Omarchy adds its own config** through `~/.local/state/omarchy/toggles/hypr/zz-try-omarchy.lua`, which loads `/usr/share/try-omarchy/hyprland.lua`. Toggles load in alphabetical order, after `bindings.lua` and `input.lua`.

## Verified versions

| Date | Omarchy | Result |
|---|---|---|
| 2026-10-27 | 4.0.0.r7031.gcce8b1c | Tested in a container against the real Omarchy code with mocks (62 checks) |
| 2026-10-27 | 4.0.0.r7343.gbc220e7-1 | Run in the real VM: no errors; shortcuts, keyboard pc105, wallpaper and Thunar working |
