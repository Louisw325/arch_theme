#!/bin/bash
# Generate VS Code theme from active color theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
BACKUP_DIR="$HOME/.config/colors/backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Backup VS Code settings
if [ -f "$VSCODE_SETTINGS" ]; then
    cp "$VSCODE_SETTINGS" "$BACKUP_DIR/vscode-settings.json.$(date +%Y%m%d_%H%M%S)"
fi

# Source the theme
source "$THEME_FILE"

# Determine VS Code color theme based on active theme
case "$THEME_NAME" in
    "BloodMoon")
        VSCODE_THEME="Dracula"
        ;;
    "Nord"|"Nordic")
        VSCODE_THEME="Nord Deep"
        ;;
    *)
        VSCODE_THEME="Default Dark+"
        ;;
esac

# Create a Python script to update VS Code settings.json properly
python3 << PYTHON_SCRIPT
import json
import sys

settings_file = "$VSCODE_SETTINGS"

try:
    with open(settings_file, 'r') as f:
        settings = json.load(f)
except:
    settings = {}

# Update theme
settings["workbench.colorTheme"] = "$VSCODE_THEME"

# Update terminal colors
settings["workbench.colorCustomizations"] = {
    "terminal.background": "$BG",
    "terminal.foreground": "$FG",
    "terminalCursor.background": "$PRIMARY",
    "terminalCursor.foreground": "$PRIMARY",
    "terminal.ansiBlack": "$BG_LIGHT",
    "terminal.ansiRed": "$ACCENT",
    "terminal.ansiGreen": "$SUCCESS",
    "terminal.ansiYellow": "$WARNING",
    "terminal.ansiBlue": "$PRIMARY",
    "terminal.ansiMagenta": "$PRIMARY",
    "terminal.ansiCyan": "$INFO",
    "terminal.ansiWhite": "$FG_DIM",
    "terminal.ansiBrightBlack": "$BG_LIGHTER",
    "terminal.ansiBrightRed": "$ERROR",
    "terminal.ansiBrightGreen": "$SUCCESS",
    "terminal.ansiBrightYellow": "$WARNING",
    "terminal.ansiBrightBlue": "$ACCENT",
    "terminal.ansiBrightMagenta": "$ACCENT",
    "terminal.ansiBrightCyan": "$INFO",
    "terminal.ansiBrightWhite": "$FG"
}

# Write back to file
with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=4)

print(f"✓ Updated VS Code theme to: $VSCODE_THEME")
print(f"✓ Updated terminal colors for theme: $THEME_NAME")
PYTHON_SCRIPT

echo "✓ VS Code settings updated"
echo ""
echo "Restart VS Code or reload window (Ctrl+Shift+P → 'Reload Window') to see changes"
