arch_theme

This repository bundles my dotfiles and theme generator scripts so I can reproduce my desktop environment on other machines.

Repository contents

- config/                # place to store exported config snippets and small assets
- scripts/               # helper scripts to install packages, export configs, sanitize notebooks, and push to GitHub
- README.md              # this file
- INSTALL.md             # instructions to install packages and apply the theme
- LICENSE                # MIT license

Quick overview

1. Run scripts/install-packages.sh to install packages (uses pacman and yay). Edit it if you prefer a different AUR helper.
2. Run scripts/export-configs.sh to copy selected config files from the current host into `config/` for packaging.
3. Run scripts/sanitize-notebooks.sh to strip outputs from Jupyter notebooks before publishing.
4. Use scripts/push-to-github.sh to create a git repo and push to a remote (you must provide the remote URL and have appropriate credentials).

Notes

- This repository is intended as a reproducible collection of configs and generator scripts. It intentionally avoids storing secrets and large binary files.
- Before pushing, review all files in `config/` and remove machine-specific paths or credentials.
