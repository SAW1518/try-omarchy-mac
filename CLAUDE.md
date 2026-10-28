# omarchy-mac

Brings my Mac setup (Rectangle and Alfred shortcuts, Latin American keyboard, theme, wallpaper, bar and file manager) to Omarchy, which runs in the **Try Omarchy** app, a VM on an Apple Silicon Mac.
I run it again **every time Try Omarchy updates or recreates the VM**, because recreating it wipes `~/.config`.

**Talk to me in Spanish, in plain words.** Keep the project files in English: the project is published to git.

## Memory

All of this project's memory lives **inside this folder**, in `memory/`. Don't use Claude Code's auto memory: it's turned off in `.claude/settings.json`. To read or save memories, follow the `project-memory` skill.

@memory/MEMORY.md

## Files

| File | Purpose |
|---|---|
| `migrate-to-omarchy.sh` | Main script. Runs **inside Omarchy**: `bash ~/bypass/omarchy-mac/migrate-to-omarchy.sh` (also takes `--dry-run` and `--uninstall`) |
| `update-skills.sh` | Copies Omarchy's skills into `.claude/skills/*-project` and fixes their paths |
| `assets/zzz-keyboard-pc.lua` | Keyboard fix: sets `kb_model` back to `pc105` (see `memory/keyboard.md`) |
| `assets/thunar.css.tpl` | Theme colors for Thunar, the file manager (see `memory/files.md`) |
| `assets/vscode/` | VS Code from the Mac: `settings.json`, `keybindings.json` (⌘ → ctrl), `chatLanguageModels.json`, `extensions.txt` (see `memory/vscode.md`) |
| `assets/pomodoro/` | Pomodoro widget for the bar; the script installs it as `<user>.pomodoro` (see `memory/bar.md`) |
| `assets/wallpaper.jpg` | Wallpaper (not in git) |
| `assets/keyboard-photo.jpeg` | Photo of my physical keyboard; use it to tell which key is which (not in git) |
| `.claude/skills/project-memory` | How to read and save memory in `memory/` |
| `.claude/skills/omarchy-project`, `omarchy-app-project`, `diagnose-crash-project` | Omarchy's skills adapted to this project; use them instead of the originals (generated, not in git) |
| `history/` | Full conversation where all this was built. Reference only: `grep` it, don't read it whole (not in git) |

The shared folder is `~/bypass` on the Mac. Inside Omarchy it's `/mnt/mac`, linked as `~/bypass`.

## Every time Try Omarchy updates

1. If the VM is new, install Claude Code first: `mise use -g claude`. Then `cd ~/bypass/omarchy-mac && claude`.
2. Check the version: `omarchy version`. If it differs from the last verified one (`memory/try-omarchy.md`), **before running the script** confirm that what it uses still exists. Omarchy edge changes fast:
   - `o.bind` in `/usr/share/omarchy/default/hypr/helpers.lua`, and `hl.unbind`.
   - `panel omarchy.clipboard` in `/usr/share/omarchy/default/omarchy/shortcuts`.
   - The commands `omarchy-shell omarchy.dock apps`, `omarchy-menu-keybindings`, `omarchy-setup-keyboard`, `omarchy-menu-select` and `omarchy-menu-input`.
   - `$OMARCHY_PATH/default/input-methods/typing_setup.py apply keyboard`.
   - Load order: toggles (`~/.local/state/omarchy/toggles/hypr/*.lua`) load after the user config, and Try Omarchy is still `zz-try-omarchy.lua`.
   - User templates in `~/.config/omarchy/themed/*.tpl` still get rendered (`omarchy-theme-set-templates`).
   - `omarchy-install-editor-vscode` still exists, and `omarchy-theme-set-vscode` still honors the `skip-vscode-theme-changes` toggle.
   - The replaced shortcuts are still the same: `grep -rn 'SUPER + SHIFT\|SUPER + K\|SUPER + SPACE' /usr/share/omarchy/default/hypr/bindings/`.
3. `bash migrate-to-omarchy.sh --dry-run`, then `bash migrate-to-omarchy.sh`.
4. Verify:
   - `hyprctl configerrors` is empty;
   - `hyprctl -j binds` has the `Rectangle:*` / `(was Alfred)` bindings;
   - `hyprctl -j getoption input:kb_model` is `pc105`;
   - `omarchy theme current` is Catppuccin and `omarchy theme bg current` is the wallpaper;
   - the bar shows the Pomodoro after the workspaces, the dock hides itself;
   - `grep -c "mac-migration: ble.sh" ~/.bashrc` is 2.
5. Ask me to try ⌘⇧←, ⌘⇧N, ⌘Space, ⌘K, ⌃V, ⌘⇧F (Thunar) and to type `? ¿ ñ ´ | ° < > @`. In a new terminal, gray suggestions as I type (→ accepts). In VS Code: One Dark Pro with a black background, ⌃L formats, ⌃D duplicates.
6. Refresh Omarchy's skills: `bash update-skills.sh`.
7. Save the verified version and anything new in `memory/try-omarchy.md`.

To change a shortcut, edit `lua_block` in the script and run it again. Don't hand-edit the block in `~/.config/hypr/bindings.lua`: the script rewrites it every time.

To customize Omarchy, also use the `omarchy-project` skill. Anything changed in `~/.config` that must last has to go into the script: recreating the VM wipes `~/.config`. Never edit `/usr/share/omarchy/` or `/usr/share/try-omarchy/`.

## Git

Before committing, check that nothing personal goes in: no names, emails, usernames, personal paths, session IDs or photos. `history/`, the `*-project` skill copies, `assets/wallpaper.jpg` and `assets/keyboard-photo.jpeg` are in `.gitignore`.
