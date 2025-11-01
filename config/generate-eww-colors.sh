#!/bin/bash
# Generate Eww SCSS variables from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
OUTPUT_FILE="$HOME/.config/eww/colors.scss"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Source the theme
source "$THEME_FILE"

# Generate SCSS file
cat > "$OUTPUT_FILE" << EOF
// Auto-generated from $THEME_FILE
// Theme: $THEME_NAME
// Generated: $(date)

// Primary colors
\$primary: $PRIMARY;
\$primary-dark: $PRIMARY_DARK;
\$primary-light: $PRIMARY_LIGHT;

// Accent colors
\$accent: $ACCENT;
\$accent-light: $ACCENT_LIGHT;
\$accent-dark: $ACCENT_DARK;

// Background colors
\$bg: $BG;
\$bg-light: $BG_LIGHT;
\$bg-lighter: $BG_LIGHTER;
\$bg-dark: $BG_DARK;

// Foreground/Text colors
\$fg: $FG;
\$fg-dim: $FG_DIM;
\$fg-dark: $FG_DARK;

// Status colors
\$success: $SUCCESS;
\$warning: $WARNING;
\$error: $ERROR;
\$info: $INFO;

// Special colors
\$urgent: $URGENT;
\$focused: $FOCUSED;
\$unfocused: $UNFOCUSED;

// Opacity values (0.0 - 1.0 for SCSS)
\$opacity-full: 1.0;
\$opacity-high: 0.9;
\$opacity-med: 0.78;
\$opacity-low: 0.59;

// Nord palette compatibility (if theme has them)
\$nord0: $BG;
\$nord1: $BG_LIGHT;
\$nord2: $BG_LIGHTER;
\$nord3: $UNFOCUSED;
\$nord4: $FG_DIM;
\$nord5: $FG_DARK;
\$nord6: $FG;
\$nord7: $PRIMARY_LIGHT;
\$nord8: $INFO;
\$nord9: $PRIMARY;
\$nord10: $FOCUSED;
\$nord11: $ACCENT;
\$nord12: $ACCENT_LIGHT;
\$nord13: $WARNING;
\$nord14: $SUCCESS;
\$nord15: $URGENT;
EOF

echo "✓ Generated Eww SCSS colors: $OUTPUT_FILE"
echo "✓ Based on theme: $THEME_NAME"
