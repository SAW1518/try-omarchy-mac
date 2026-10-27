---
name: files
description: File manager - Thunar with the theme colors instead of Nautilus
type: project
updated: 2026-10-27
---

- The user doesn't want Nautilus (it clashes with Omarchy), but does want a separate GUI app, not Yazi in the terminal. **Thunar** was chosen (+ tumbler for thumbnails).
- Colors: `assets/thunar.css.tpl` → `~/.config/omarchy/themed/`. Omarchy renders user templates on every `omarchy theme set` into `~/.local/state/omarchy/current/theme/thunar.css`, and `~/.config/gtk-3.0/gtk.css` imports it. Everything is scoped to `window.thunar`. Omarchy only touches the GTK4 `gtk.css` (glass mode), so the GTK3 one is free.
- Shortcuts: SUPER+SHIFT+F opens Thunar, SUPER+ALT+SHIFT+F opens it in the terminal's folder. It gets the same transparency as Nautilus (`o.transparent_window("thunar")`) and is the default for folders (`xdg-mime`).
- `omarchy theme set` keeps the current wallpaper.
- The user hasn't said yet whether they like how it looks. If not, adjust the template and run the script again.
