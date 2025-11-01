#!/bin/bash
# Generate Konsole colorscheme from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
KONSOLE_DIR="$HOME/.local/share/konsole"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Create Konsole directory if it doesn't exist
mkdir -p "$KONSOLE_DIR"

# Source the theme
source "$THEME_FILE"

# Function to convert hex to RGB
hex_to_rgb() {
    local hex="${1#\#}"
    printf "%d,%d,%d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

# Convert colors to RGB
BG_RGB=$(hex_to_rgb "$BG")
BG_LIGHT_RGB=$(hex_to_rgb "$BG_LIGHT")
FG_RGB=$(hex_to_rgb "$FG")
FG_DIM_RGB=$(hex_to_rgb "$FG_DIM")
PRIMARY_RGB=$(hex_to_rgb "$PRIMARY")
ACCENT_RGB=$(hex_to_rgb "$ACCENT")
SUCCESS_RGB=$(hex_to_rgb "$SUCCESS")
WARNING_RGB=$(hex_to_rgb "$WARNING")
ERROR_RGB=$(hex_to_rgb "$ERROR")
INFO_RGB=$(hex_to_rgb "$INFO")
URGENT_RGB=$(hex_to_rgb "$URGENT")

# Generate Konsole colorscheme
OUTPUT_FILE="$KONSOLE_DIR/${THEME_NAME}.colorscheme"

cat > "$OUTPUT_FILE" << EOF
[Background]
Color=$BG_RGB
RandomHueRange=360
RandomSaturationRange=100

[BackgroundFaint]
Color=$BG_RGB
RandomHueRange=360
RandomSaturationRange=100

[BackgroundIntense]
Color=$BG_LIGHT_RGB
RandomHueRange=360
RandomSaturationRange=100

[Color0]
Color=$BG_LIGHT_RGB

[Color0Faint]
Color=$BG_LIGHT_RGB

[Color0Intense]
Color=$BG_LIGHT_RGB

[Color1]
Color=$ACCENT_RGB

[Color1Faint]
Color=$ACCENT_RGB

[Color1Intense]
Color=$ERROR_RGB

[Color2]
Color=$SUCCESS_RGB

[Color2Faint]
Color=$SUCCESS_RGB

[Color2Intense]
Color=$SUCCESS_RGB

[Color3]
Color=$WARNING_RGB

[Color3Faint]
Color=$WARNING_RGB

[Color3Intense]
Color=$WARNING_RGB

[Color4]
Color=$PRIMARY_RGB

[Color4Faint]
Color=$PRIMARY_RGB

[Color4Intense]
Color=$INFO_RGB

[Color5]
Color=$URGENT_RGB

[Color5Faint]
Color=$URGENT_RGB

[Color5Intense]
Color=$URGENT_RGB

[Color6]
Color=$INFO_RGB

[Color6Faint]
Color=$INFO_RGB

[Color6Intense]
Color=$INFO_RGB

[Color7]
Color=$FG_RGB

[Color7Faint]
Color=$FG_DIM_RGB

[Color7Intense]
Color=$FG_RGB

[Foreground]
Color=$FG_RGB
RandomHueRange=360
RandomSaturationRange=100

[ForegroundFaint]
Color=$FG_DIM_RGB
RandomHueRange=360
RandomSaturationRange=100

[ForegroundIntense]
Color=$FG_RGB
RandomHueRange=360
RandomSaturationRange=100

[General]
Anchor=0.5,0.5
Blur=true
ColorRandomization=false
Description=$THEME_NAME
FillStyle=Tile
Opacity=0.38
Wallpaper=
WallpaperFlipType=NoFlip
WallpaperOpacity=1
EOF

echo "✓ Generated Konsole colorscheme: $OUTPUT_FILE"
echo "✓ Based on theme: $THEME_NAME"
echo ""
echo "To apply in Konsole:"
echo "  Settings → Edit Current Profile → Appearance → Color Scheme → Select '$THEME_NAME'"
