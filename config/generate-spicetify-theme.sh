#!/bin/bash
# Generate Spicetify theme config from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Source the theme
source "$THEME_FILE"

# Map theme names to Spicetify themes
case "$THEME_NAME" in
    "Nordic"|"Nord")
        SPICETIFY_THEME="Dribbblish"
        SPICETIFY_SCHEME="nord-dark"
        ;;
    "BloodMoon")
        SPICETIFY_THEME="Dreary"
        SPICETIFY_SCHEME="psycho"
        ;;
    *)
        echo "Warning: No Spicetify theme mapping for $THEME_NAME"
        echo "Using default Dribbblish theme"
        SPICETIFY_THEME="Dribbblish"
        SPICETIFY_SCHEME="nord-dark"
        ;;
esac

# Check if spicetify is installed
if ! command -v spicetify &> /dev/null; then
    echo "Warning: spicetify not found, skipping Spotify theme change"
    exit 0
fi

# Apply the Spicetify theme
echo "Applying Spicetify theme: $SPICETIFY_THEME with scheme: $SPICETIFY_SCHEME"
spicetify config current_theme "$SPICETIFY_THEME"
spicetify config color_scheme "$SPICETIFY_SCHEME"
spicetify apply

echo "✓ Spicetify theme applied: $SPICETIFY_THEME - $SPICETIFY_SCHEME"
