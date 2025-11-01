#!/usr/bin/env bash
# Install packages for the arch_theme environment
# Uses pacman for official repos and yay for AUR packages. Edit if you prefer paru.
set -euo pipefail

AUR_HELPER=${AUR_HELPER:-yay}

# Pacman packages
PACMAN_PACKAGES=(
  starship
  lsd
  btop
  konsole
  zsh
  fd
  bat
  ripgrep
  fzf
  python
  python-pip
  git
)

# AUR packages (install with yay)
AUR_PACKAGES=(
  nerd-fonts-complete
  # add more AUR packages used by your dotfiles here
)

echo "== Installing pacman packages =="
sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"

echo "== Installing AUR packages with ${AUR_HELPER} =="
if command -v "$AUR_HELPER" >/dev/null 2>&1; then
  sudo -u "$USER" "$AUR_HELPER" -S --needed --noconfirm "${AUR_PACKAGES[@]}"
else
  echo "AUR helper $AUR_HELPER not found. Install it or set AUR_HELPER to your helper (yay/paru)."
  exit 1
fi

echo "Packages installed. Please run scripts/export-configs.sh and then the generator scripts to apply themes."
