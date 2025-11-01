#!/usr/bin/env bash
# Strip outputs from Jupyter notebooks under config/ using nbstripout if available
set -euo pipefail

REPO_ROOT="$(dirname "$0")/.."
CONFIG_DIR="$REPO_ROOT/config"

if ! command -v nbstripout >/dev/null 2>&1; then
  echo "nbstripout not found. Installing via pip."
  pip install --user nbstripout
fi

echo "Stripping outputs from notebooks in $CONFIG_DIR"
find "$CONFIG_DIR" -name "*.ipynb" -print0 | xargs -0 -r nbstripout

echo "Notebook sanitization complete."
