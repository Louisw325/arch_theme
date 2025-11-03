#!/usr/bin/env bash
# Self-contained installer script generated from the current laptop.
# Usage: scp this file to a fresh machine and run: bash install-packages-bundled.sh
set -euo pipefail

AUR_HELPER=${AUR_HELPER:-yay}

# Packages from official repos
PACMAN_PACKAGES=(
"alsa-utils"
"base"
"base-devel"
"bc"
"blueberry"
"blueman"
"bluetui"
"bluez-utils"
"brightnessctl"
"btop"
"calibre"
"cava"
"chrono-date"
"cmake"
"cpio"
"devtools"
"discord"
"dolphin"
"dosfstools"
"efibootmgr"
"eog"
"evince"
"fastfetch"
"fcron"
"firefox"
"gcolor3"
"gimp"
"git"
"github-cli"
"gnome-calendar"
"gobject-introspection"
"gparted"
"grub"
"gtk4-layer-shell"
"htop"
"hypridle"
"hyprland"
"hyprland-protocols"
"hyprlock"
"hyprpaper"
"hyprpicker"
"hyprpolkitagent"
"intel-gpu-tools"
"jack-example-tools"
"kate"
"konsole"
"lib32-nvidia-utils"
"libappindicator"
"libnotify"
"libreoffice-still"
"linux"
"linux-firmware"
"lsd"
"lsof"
"mako"
"mesa-utils"
"meson"
"nano"
"networkmanager"
"network-manager-applet"
"nmap"
"noto-fonts-emoji"
"nvtop"
"openssh"
"otf-aurulent-nerd"
"otf-codenewroman-nerd"
"otf-comicshanns-nerd"
"otf-commit-mono-nerd"
"otf-droid-nerd"
"otf-firamono-nerd"
"otf-font-awesome"
"otf-geist-mono-nerd"
"otf-hasklig-nerd"
"otf-hermit-nerd"
"otf-monaspace-nerd"
"otf-opendyslexic-nerd"
"otf-overpass-nerd"
"pavucontrol"
"pipewire"
"pipewire-alsa"
"pipewire-jack"
"pipewire-pulse"
"playerctl"
"polkit-kde-agent"
"power-profiles-daemon"
"python-matplotlib"
"python-pip"
"qjackctl"
"qt5-wayland"
"rclone"
"reflector"
"rofi"
"rpi-imager"
"sassc"
"sddm"
"sof-firmware"
"starship"
"steam"
"surge-xt"
"swayidle"
"swaync"
"swayosd"
"swww"
"texlive-context"
"texlive-fontsextra"
"texlive-fontsrecommended"
"texlive-latexextra"
"texlive-luatex"
"texmaker"
"texstudio"
"tk"
"ttf-0xproto-nerd"
"ttf-3270-nerd"
"ttf-agave-nerd"
"ttf-anonymouspro-nerd"
"ttf-arimo-nerd"
"ttf-bigblueterminal-nerd"
"ttf-bitstream-vera-mono-nerd"
"ttf-cascadia-code"
"ttf-cascadia-code-nerd"
"ttf-cascadia-mono-nerd"
"ttf-cousine-nerd"
"ttf-d2coding-nerd"
"ttf-daddytime-mono-nerd"
"ttf-dejavu-nerd"
"ttf-envycoder-nerd"
"ttf-fantasque-nerd"
"ttf-fira-code"
"ttf-firacode-nerd"
"ttf-gohu-nerd"
"ttf-go-nerd"
"ttf-hack-nerd"
"ttf-heavydata-nerd"
"ttf-iawriter-nerd"
"ttf-ibmplex-mono-nerd"
"ttf-inconsolata-go-nerd"
"ttf-inconsolata-lgc-nerd"
"ttf-inconsolata-nerd"
"ttf-intone-nerd"
"ttf-iosevka-nerd"
"ttf-iosevkaterm-nerd"
"ttf-iosevkatermslab-nerd"
"ttf-jetbrains-mono-nerd"
"ttf-lekton-nerd"
"ttf-liberation-mono-nerd"
"ttf-lilex-nerd"
"ttf-martian-mono-nerd"
"ttf-meslo-nerd"
"ttf-monofur-nerd"
"ttf-monoid-nerd"
"ttf-mononoki-nerd"
"ttf-mplus-nerd"
"ttf-nerd-fonts-symbols"
"ttf-nerd-fonts-symbols-mono"
"ttf-noto-nerd"
"ttf-profont-nerd"
"ttf-proggyclean-nerd"
"ttf-recursive-nerd"
"ttf-roboto-mono-nerd"
"ttf-sharetech-mono-nerd"
"ttf-sourcecodepro-nerd"
"ttf-space-mono-nerd"
"ttf-terminus-nerd"
"ttf-tinos-nerd"
"ttf-ubuntu-mono-nerd"
"ttf-ubuntu-nerd"
"ttf-victor-mono-nerd"
"ttf-zed-mono-nerd"
"wget"
"wine"
"winetricks"
"wireplumber"
"wmctrl"
"wob"
"woff2-font-awesome"
"wofi"
"xcolor"
"xdg-desktop-portal-gtk"
"xdg-desktop-portal-hyprland"
"xdotool"
"yad"
"zsh"
"zsh-syntax-highlighting"
)

# AUR packages
AUR_PACKAGES=(
"amdvlk"
"cbonsai"
"cbonsai-debug"
"cmatrix-git"
"displaylink-debug"
"evdi-amd-vmap-texture-debug"
"eww"
"lib32-amdvlk"
"nordzy-cursors"
"otf-font-awesome-5"
"protontricks"
"python-vdf"
"ruby-fusuma"
"ruby-fusuma-plugin-sendkey"
"ruby-revdev"
"ruby-revdev-debug"
"sddm-theme-sugar-candy-git"
"snapd"
"spicetify-cli"
"spotify"
"syshud-debug"
"syspower"
"syspower-debug"
"ttf-font-awesome-5"
"ttf-ms-fonts"
"ttf-orbitron"
"visual-studio-code-bin"
"wlogout"
"yay-bin"
"yay-bin-debug"
)

# Flatpak apps
FLATPAK_APPS=(
)

# Snap list (snap packages are optional and require snapd)
SNAP_PACKAGES=(
"bare"
"copilot-desktop"
"core22"
"core24"
"gnome-46-2404"
"gtk-common-themes"
"kf5-core22"
"mesa-2404"
"snapd"
)

# pip user packages
PIP_USER=(
)

# npm global modules
NPM_GLOBAL=(
)

# ---- installer operations ----
read -p "This will install packages. Continue? [y/N] " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."; exit 1
fi

# update and install pacman packages
sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"

# install AUR packages using the helper
if [ ${#AUR_PACKAGES[@]} -gt 0 ]; then
  if command -v "$AUR_HELPER" >/dev/null 2>&1; then
    $AUR_HELPER -S --needed --noconfirm "${AUR_PACKAGES[@]}"
  else
    echo "AUR helper $AUR_HELPER not found. Install yay or paru, or set AUR_HELPER env var."; exit 1
  fi
fi

# flatpak installs
if [ ${#FLATPAK_APPS[@]} -gt 0 ]; then
  for app in "${FLATPAK_APPS[@]}"; do
    flatpak install -y "$app" || true
  done
fi

# snap installs (skipped if snapd not installed)
if command -v snap >/dev/null 2>&1 && [ ${#SNAP_PACKAGES[@]} -gt 0 ]; then
  for s in "${SNAP_PACKAGES[@]}"; do
    snap install "$s" || true
  done
fi

# pip user installs
if [ ${#PIP_USER[@]} -gt 0 ]; then
  pip3 install --user "${PIP_USER[@]}"
fi

# npm global installs
if [ ${#NPM_GLOBAL[@]} -gt 0 ]; then
  npm install -g "${NPM_GLOBAL[@]}" || true
fi

echo "Bundled installer finished. Review output for errors and re-run any failed parts manually." 
