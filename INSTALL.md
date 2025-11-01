Install and apply

This document provides the minimal steps to recreate the environment on a fresh Arch-based system.

Prerequisites

- You have an Arch-based OS with sudo privileges.
- You have an AUR helper installed (this repo uses `yay` by default).

Install packages

Edit `scripts/install-packages.sh` if you prefer a different AUR helper (e.g., paru).

Run:

```bash
bash scripts/install-packages.sh
```

Export and apply configs

1. Copy files in `config/` to the corresponding locations under `$HOME` (the `export-configs.sh` helper attempts to do this interactively).
2. Run the included theme generator scripts (they live in `config/` or wherever you extracted them). For example:

```bash
# regenerate dircolors, starship, lsd, and konsole scheme
bash ~/.config/colors/generate-dircolors.sh && eval "$(dircolors ~/.config/colors/dircolors)"
bash ~/.config/colors/generate-lsd-colors.sh
bash ~/.config/colors/generate-konsole-colors.sh
```

Strip notebooks

```bash
bash scripts/sanitize-notebooks.sh
```

Push to GitHub

Update `scripts/push-to-github.sh` with your remote URL and run it to initialize the repo and push the first commit.
