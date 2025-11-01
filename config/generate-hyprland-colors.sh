#!/bin/bash
# Generate Hyprland color definitions from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
OUTPUT_FILE="$HOME/.config/hypr/colors.conf"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Source the theme
source "$THEME_FILE"

# Generate Hyprland color config
cat > "$OUTPUT_FILE" << EOF
# Auto-generated Hyprland colors from $THEME_FILE
# Theme: $THEME_NAME
# Generated: $(date)

# Hyprland color format: rgb(RRGGBB) or rgba(RRGGBBAA)
# Variables in Hyprland use \$ prefix

# Primary colors
\$primary = ${PRIMARY}
\$primary_dark = ${PRIMARY_DARK}
\$primary_light = ${PRIMARY_LIGHT}

# Accent colors
\$accent = ${ACCENT}
\$accent_light = ${ACCENT_LIGHT}
\$accent_dark = ${ACCENT_DARK}

# Background colors
\$bg = ${BG}
\$bg_light = ${BG_LIGHT}
\$bg_lighter = ${BG_LIGHTER}
\$bg_dark = ${BG_DARK}

# Foreground/Text colors
\$fg = ${FG}
\$fg_dim = ${FG_DIM}
\$fg_dark = ${FG_DARK}

# Status colors
\$success = ${SUCCESS}
\$warning = ${WARNING}
\$error = ${ERROR}
\$info = ${INFO}

# Special colors
\$urgent = ${URGENT}
\$focused = ${FOCUSED}
\$unfocused = ${UNFOCUSED}

# Border colors with alpha
\$border_active = rgba(${PRIMARY#\#}ff)
\$border_inactive = rgba(${UNFOCUSED#\#}aa)

# Shadow color with alpha (very dark with transparency)
\$shadow = rgba(${BG_DARK#\#}ee)
EOF

echo "✓ Generated Hyprland colors: $OUTPUT_FILE"
echo "✓ Based on theme: $THEME_NAME"

# Update GTK_THEME environment variable in hyprland.conf based on theme
case "$THEME_NAME" in
    "BloodMoon")
        GTK_THEME_NAME="Graphite-red-Dark"
        ;;
    "Nord"|"Nordic")
        GTK_THEME_NAME="Nordic"
        ;;
    *)
        GTK_THEME_NAME="Adwaita-dark"
        ;;
esac

# Update the GTK_THEME line in hyprland.conf
if [ -f "$HYPRLAND_CONFIG" ]; then
    sed -i "s/^env = GTK_THEME,.*/env = GTK_THEME, $GTK_THEME_NAME/" "$HYPRLAND_CONFIG"
    echo "✓ Updated Hyprland GTK_THEME to: $GTK_THEME_NAME"
fi
