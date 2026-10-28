---
name: terminal
description: Terminal in Omarchy - Foot vs Ghostty, and ble.sh autosuggestions like Warp
type: project
updated: 2026-10-28
---

- This VM's default terminal is **Foot** (`foot`). Ghostty is installed too.
- The user asked about the difference. Recommended staying on Foot: lighter, which matters in the VM, and tiling covers the lack of tabs. Ghostty has tabs and splits, renders on the GPU (virtual in the VM) and also exists for the Mac.
- They haven't asked to switch. If they do, it's in the Omarchy menu (⌘K); to make it last, move it into the script.

## Autosuggestions (ble.sh)

- 2026-10-28: the user likes Warp's autocomplete and asked for it here. Chose **ble.sh** (AUR `blesh-git`) over fish (Omarchy's bash aliases) and Warp itself (heavy, GPU, ignores Omarchy themes).
- `install_blesh` in the script installs it and adds two lines tagged `# mac-migration: ble.sh` to `~/.bashrc`: `source ... --noattach` right before Omarchy's `rc`, and `ble-attach` at the end. Each run replaces them; `--uninstall` removes them (the package stays).
- Someone had added untagged ble.sh lines (Spanish comments) to `~/.bashrc` by hand without installing the package; they were removed, backup at `~/.bashrc.bak-before-blesh`.
- **How to apply:** to tweak ble.sh (colors, keys), add `bleopt`/`ble-bind` lines to the script, not to `~/.bashrc` by hand.
