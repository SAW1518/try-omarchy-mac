---
name: vscode
description: VS Code migrated from the Mac - where the files came from, the ⌘ → ctrl translation, theme, what was left out
type: project
updated: 2026-10-27
---

- 2026-10-27: the user asked to bring "everything from VS Code" (keybindings, extensions, etc.). The Mac had VS Code 1.143; Omarchy's edge aarch64 repo has `visual-studio-code-bin` 1.143.1, so the real Microsoft build (marketplace, Copilot) works in the VM.
- Snapshot taken from the Mac's `~/Library/Application Support/Code/User/` into `assets/vscode/`. It does **not** update itself: if the user changes VS Code on the Mac, copy it again (`code --list-extensions > assets/vscode/extensions.txt`, and re-translate keybindings).
- **Keybindings:** ⌘ → ctrl, the usual VS Code Mac ↔ Linux mapping (⌘L → ctrl+l format, ⌘D → ctrl+d duplicate). ⌘ can't be used: Hyprland owns SUPER (SUPER+L cycles the layout). The removed default changes too: shift+alt+f on the Mac is ctrl+shift+i on Linux.
- **Theme:** kept One Dark Pro + black `colorCustomizations`, like the Mac. The flag `~/.local/state/omarchy/toggles/skip-vscode-theme-changes` stops Omarchy from switching it to its "Omarchy" theme on every theme change. If the user would rather follow Omarchy's theme, drop the toggle, `workbench.colorTheme` and `workbench.colorCustomizations`.
- **Left out of settings.json:** `terminal.integrated.env.osx` (Mac-only Fig/CodeWhisperer vars) and `yaml.schemas` (pointed to the Atlassian extension, not installed, with a personal Mac path). Added `"update.mode": "none"`, as Omarchy does (updates come from pacman).
- **Not migrated:** Project Manager's project list (Mac paths), `argv.json` (Omarchy writes its own with `password-store: gnome-libsecret`). Settings for `fluent-icons` and `background` are kept but do nothing: those extensions weren't installed on the Mac either.
- Order matters: `omarchy-install-editor-vscode` overwrites `settings.json`, so the script copies ours after it. Not set as Omarchy's default editor (`omarchy-default-editor code`); offered, no answer yet.
- 2026-10-27: run in the VM (Omarchy 4.0.0.r7343). VS Code was already installed, so the installer was skipped; the 20 extensions installed fine, settings/keybindings/chatLanguageModels were copied (the previous ones kept as `.bak-20261027-153242`), the theme toggle is in place, no Hyprland errors. Waiting for the user to check One Dark Pro, ⌃L and ⌃D.
