# omarchy-mac

Makes [Omarchy](https://omarchy.org) 4, running in the [Try Omarchy](https://github.com/omacom/try-omarchy) VM on a Mac, feel like the Mac it runs on:

- **Rectangle** shortcuts (⌘⇧ + arrows for halves, ⌘⇧↩ maximize, ⌘⇧N / ⌘⇧⌦ thirds, ⌘⇧M / Insert two thirds), with the same gaps as Hyprland's tiling.
- **Alfred** shortcuts: ⌘Space opens Omarchy's app launcher, ⌃V opens clipboard history, plus a small Shimmering Obsidian–style menu (⌘⌥O).
- **Latin American keyboard**, fixing Try Omarchy's Apple keyboard model, which moves keys around on Latin American ISO MacBooks.
- **Thunar** instead of Nautilus, styled with the current Omarchy theme colors.
- Your **wallpaper** (drop it in `assets/wallpaper.jpg`).

Everything is reinstalled with one command after Try Omarchy updates or recreates the VM.

## Usage

Clone it into the folder shared with the VM (`~/bypass` here, `/mnt/mac` inside the VM). Then, **inside Omarchy**:

```bash
bash ~/bypass/omarchy-mac/migrate-to-omarchy.sh --dry-run   # show the Hyprland bindings it would add
bash ~/bypass/omarchy-mac/migrate-to-omarchy.sh             # install
bash ~/bypass/omarchy-mac/migrate-to-omarchy.sh --uninstall # undo
```

Optional variables: `KB_LAYOUT` (default `latam`, empty to skip), `VAULT` (Obsidian vault), `WIN_MODS` (default `SUPER + SHIFT`), `RECT_GAP` (fixed gap; default is Hyprland's), `WALLPAPER`.

If Hyprland reports a config error after the bindings are added, the script restores `bindings.lua` from the backup automatically.

## Claude Code

The project is set up for [Claude Code](https://claude.com/claude-code): `CLAUDE.md` has the update checklist, `memory/` is the project's memory (auto memory is off), and `update-skills.sh` copies Omarchy's own agent skills into `.claude/skills/` with paths fixed for this project.

Targets Omarchy 4 edge (Hyprland configured in Lua); last verified on `4.0.0.r7343.gbc220e7`.
# try-omarchy-mac
