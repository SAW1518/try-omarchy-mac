/* Thunar with the Omarchy theme colors.
   Omarchy renders ~/.local/state/omarchy/current/theme/thunar.css from this
   template on every theme change; ~/.config/gtk-3.0/gtk.css imports it.
   Everything is scoped to window.thunar so other GTK3 apps are untouched. */

window.thunar,
window.thunar scrolledwindow,
window.thunar viewport,
window.thunar .view,
window.thunar iconview,
window.thunar treeview.view {
  background-color: {{ background }};
  color: {{ foreground }};
}

window.thunar .view:selected,
window.thunar iconview:selected,
window.thunar treeview.view:selected,
window.thunar .view:selected:focus,
window.thunar iconview:selected:focus {
  background-color: {{ mix background accent 0.35 }};
  color: {{ bright_foreground }};
}

window.thunar .view:hover,
window.thunar iconview:hover {
  background-color: {{ lighter_background }};
}

window.thunar rubberband,
window.thunar .rubberband {
  background-color: {{ mix background accent 0.25 }};
  border: 1px solid {{ accent }};
}

/* Sidebar */
window.thunar .sidebar,
window.thunar .sidebar .view,
window.thunar .sidebar treeview.view,
window.thunar placessidebar,
window.thunar placessidebar list,
window.thunar placessidebar row {
  background-color: {{ dark_background }};
  color: {{ light_foreground }};
}

window.thunar .sidebar .view:selected,
window.thunar placessidebar row:selected {
  background-color: {{ selection }};
  color: {{ accent }};
}

/* Bars: menu, toolbar, location and status */
window.thunar headerbar,
window.thunar menubar,
window.thunar toolbar,
window.thunar .toolbar,
window.thunar .location-bar,
window.thunar statusbar,
window.thunar .statusbar {
  background: {{ dark_background }};
  color: {{ foreground }};
  border-color: {{ lighter_background }};
  box-shadow: none;
  text-shadow: none;
}

window.thunar statusbar,
window.thunar .statusbar {
  color: {{ dark_foreground }};
}

window.thunar menubar > menuitem:hover {
  background: {{ lighter_background }};
  color: {{ accent }};
  box-shadow: none;
}

window.thunar button {
  background: transparent;
  color: {{ foreground }};
  border-color: transparent;
  box-shadow: none;
  text-shadow: none;
  -gtk-icon-shadow: none;
}

window.thunar button:hover {
  background: {{ lighter_background }};
}

window.thunar button:checked,
window.thunar button:active {
  background: {{ selection }};
  color: {{ accent }};
}

window.thunar entry {
  background: {{ lighter_background }};
  color: {{ foreground }};
  border-color: {{ muted }};
  box-shadow: none;
}

window.thunar entry:focus {
  border-color: {{ accent }};
}

/* List view headers, separators and tabs */
window.thunar treeview.view header button {
  background: {{ dark_background }};
  color: {{ dark_foreground }};
  border-color: {{ lighter_background }};
}

window.thunar paned > separator,
window.thunar separator {
  background: {{ lighter_background }};
}

window.thunar notebook > header {
  background: {{ dark_background }};
  border-color: {{ lighter_background }};
}

window.thunar notebook > header tab {
  color: {{ dark_foreground }};
}

window.thunar notebook > header tab:checked {
  color: {{ accent }};
  box-shadow: inset 0 -2px {{ accent }};
}

window.thunar scrollbar {
  background: transparent;
  border: none;
}

window.thunar scrollbar slider {
  background: {{ muted }};
}
