#!/usr/bin/env bash
# Interactive helper to copy selected config files from the current host into this repo's config/ directory.
set -euo pipefail

DEST_DIR="$(dirname "$0")/../config"
mkdir -p "$DEST_DIR"

declare -a candidates=(
  "$HOME/.config/colors/active-theme.conf"
  "$HOME/.config/colors/generate-*.sh"
  "$HOME/.config/starship.toml"
  "$HOME/.config/lsd/colors.yaml"
  "$HOME/.config/btop/themes/"
  "$HOME/.local/share/konsole/"
)

echo "Exporting suggested config files to $DEST_DIR"
for path in "${candidates[@]}"; do
  # expand globs
  for f in $(eval echo $path); do
    if [ -e "$f" ]; then
      target="$DEST_DIR/$(basename "$f")"
      if [ -d "$f" ]; then
        echo "Copying directory $f -> $DEST_DIR/$(basename "$f")"
        rm -rf "$DEST_DIR/$(basename "$f")" && cp -a "$f" "$DEST_DIR/"
      else
        echo "Copying $f -> $target"
        cp -a "$f" "$target"
      fi
    fi
  done
done

echo "Export complete. Review files under $DEST_DIR and move any sensitive content into config/private/."
