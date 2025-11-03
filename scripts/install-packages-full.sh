#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(dirname "$0")/.."
PKG_DIR="$REPO_ROOT/.package-lists"
AUR_HELPER=${AUR_HELPER:-yay}

if [ ! -d "$PKG_DIR" ]; then
  echo "Package list directory not found: $PKG_DIR"
  exit 1
fi

# Pacman packages (official repo)
PACMAN_PACKAGES=(
$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\n  /g' "$PKG_DIR/repo_explicit.txt")
)

# AUR / foreign packages
AUR_PACKAGES=(
$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\n  /g' "$PKG_DIR/foreign.txt")
)

# Flatpak apps (optional)
FLATPAK_APPS_FILE="$PKG_DIR/flatpak_apps.txt"
# Snap list (optional)
SNAP_LIST_FILE="$PKG_DIR/snap_list.txt"

# Pip user packages
PIP_USER_FILE="$PKG_DIR/pip_user.txt"

# NPM global modules
NPM_GLOBAL_FILE="$PKG_DIR/npm_global.txt"

echo "This script will install ${#PACMAN_PACKAGES[@]} pacman packages and ${#AUR_PACKAGES[@]} AUR packages (using $AUR_HELPER)."
read -p "Proceed? [y/N] " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."; exit 1
fi

# Update and install pacman packages
sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"

# Install AUR packages with helper
if [ -s "$PKG_DIR/foreign.txt" ]; then
  if command -v "$AUR_HELPER" >/dev/null 2>&1; then
    "$AUR_HELPER" -S --needed --noconfirm $(tr '\n' ' ' < "$PKG_DIR/foreign.txt")
  else
    echo "AUR helper $AUR_HELPER not found. Install yay or paru and re-run this script."; exit 1
  fi
fi

# Optional: flatpak
if [ -s "$FLATPAK_APPS_FILE" ]; then
  echo "Installing flatpak apps (requires flatpak remote set up)..."
  while IFS= read -r app; do
    flatpak install -y "$app" || true
  done < "$FLATPAK_APPS_FILE"
fi

# Optional: snap
if [ -s "$SNAP_LIST_FILE" ]; then
  echo "Installing snaps (requires snapd)..."
  while IFS= read -r line; do
    echo "snap entry: $line"
  done < "$SNAP_LIST_FILE"
fi

# pip user installs
if [ -s "$PIP_USER_FILE" ]; then
  echo "Installing pip (user) packages..."
  pip3 install --user -r "$PIP_USER_FILE"
fi

# npm global installs
if [ -s "$NPM_GLOBAL_FILE" ]; then
  echo "Installing npm global packages..."
  npm install -g $(tr '\n' ' ' < "$NPM_GLOBAL_FILE") || true
fi

echo "Install script finished. Review output for any failures."
