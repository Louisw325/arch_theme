#!/bin/bash
# Generate btop theme from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
BTOP_THEME_DIR="$HOME/.config/btop/themes"
BTOP_CONF="$HOME/.config/btop/btop.conf"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Create btop themes directory if it doesn't exist
mkdir -p "$BTOP_THEME_DIR"

# Source the theme
source "$THEME_FILE"

# Generate btop theme
OUTPUT_FILE="$BTOP_THEME_DIR/${THEME_NAME}.theme"

cat > "$OUTPUT_FILE" << EOF
# btop theme - Generated from $THEME_NAME

# Main background, empty for terminal default
theme[main_bg]=""

# Main text color (off-white)
theme[main_fg]="$FG"

# Title color for boxes (use PRIMARY_LIGHT as primary UI accent)
theme[title]="$PRIMARY_LIGHT"

# Highlight color for keyboard shortcuts (light blue)
theme[hi_fg]="$PRIMARY_LIGHT"

# Background color of selected item in processes box
theme[selected_bg]="$BG_LIGHTER"

# Foreground color of selected item in processes box
theme[selected_fg]="$FG"

# Color of inactive/disabled text
theme[inactive_fg]="$FG_DIM"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
# Use PRIMARY_LIGHT as main accent for UI elements
theme[proc_misc]="$PRIMARY_LIGHT"

# Cpu box outline color
theme[cpu_box]="$PRIMARY_LIGHT"

# Memory/disks box outline color
theme[mem_box]="$PRIMARY_LIGHT"

# Net up/down box outline color
theme[net_box]="$PRIMARY_LIGHT"

# Processes box outline color
theme[proc_box]="$PRIMARY_LIGHT"

# Box divider line and small boxes line color
theme[div_line]="$BG_LIGHTER"

# Temperature graph colors
theme[temp_start]="$SUCCESS"
theme[temp_mid]="$WARNING"
theme[temp_end]="$ERROR"

# CPU graph colors
theme[cpu_start]="$PRIMARY_LIGHT"
theme[cpu_mid]="$SUCCESS"
theme[cpu_end]="$ERROR"

# Mem/Disk free meter
theme[free_start]="$SUCCESS"
theme[free_mid]=""
theme[free_end]="$SUCCESS"

# Mem/Disk cached meter
theme[cached_start]="$PRIMARY_LIGHT"
theme[cached_mid]=""
theme[cached_end]="$PRIMARY_LIGHT"

# Mem/Disk available meter
theme[available_start]="$PRIMARY_LIGHT"
theme[available_mid]=""
theme[available_end]="$PRIMARY_LIGHT"

# Mem/Disk used meter
theme[used_start]="$WARNING"
theme[used_mid]="$ERROR"
theme[used_end]="$ERROR"

# Download graph colors
theme[download_start]="$SUCCESS"
theme[download_mid]=""
theme[download_end]="$SUCCESS"

# Upload graph colors
theme[upload_start]="$PRIMARY_LIGHT"
theme[upload_mid]=""
theme[upload_end]="$ACCENT_LIGHT"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="$PRIMARY_LIGHT"
theme[process_mid]="$PRIMARY_LIGHT"
theme[process_end]="$PRIMARY_LIGHT"
EOF

echo "✓ Generated btop theme: $OUTPUT_FILE"

# Update btop config to use the new theme
if [ -f "$BTOP_CONF" ]; then
    sed -i "s|^color_theme = .*|color_theme = \"$OUTPUT_FILE\"|" "$BTOP_CONF"
    echo "✓ Updated btop config to use $THEME_NAME theme"
fi

echo "✓ Based on theme: $THEME_NAME"
echo ""
echo "Restart btop to see the changes"
