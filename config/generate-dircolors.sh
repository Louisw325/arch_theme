#!/bin/bash
# Generate dircolors configuration from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
OUTPUT_FILE="$HOME/.config/colors/dircolors"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Source the theme
source "$THEME_FILE"

# Function to convert hex to ANSI 256 color code (approximate)
hex_to_ansi() {
    local hex="${1#\#}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    
    # Simple mapping to 256 colors
    if [ $r -eq $g ] && [ $g -eq $b ]; then
        # Grayscale
        if [ $r -lt 8 ]; then echo "16"
        elif [ $r -gt 248 ]; then echo "231"
        else echo $((232 + (r - 8) / 10))
        fi
    else
        # Color cube
        local rc=$(( (r < 95) ? 0 : (r - 55) / 40 ))
        local gc=$(( (g < 95) ? 0 : (g - 55) / 40 ))
        local bc=$(( (b < 95) ? 0 : (b - 55) / 40 ))
        echo $((16 + 36 * rc + 6 * gc + bc))
    fi
}

# Convert theme colors to ANSI codes
# Use PRIMARY_LIGHT for directory color so folders appear in the light blue accent
DIR_COLOR=$(hex_to_ansi "$PRIMARY_LIGHT")
EXEC_COLOR=$(hex_to_ansi "$ACCENT")
LINK_COLOR=$(hex_to_ansi "$ACCENT_LIGHT")
ARCHIVE_COLOR=$(hex_to_ansi "$WARNING")

# Generate dircolors file
cat > "$OUTPUT_FILE" << 'EOF'
# Configuration file for dircolors, a utility to help you set the
# LS_COLORS environment variable used by GNU ls with the --color option.

# Reset to normal
RESET 0
# Normal (non-filename) text
NORMAL 00
# Regular file
FILE 00
# Directory
EOF

echo "DIR 01;38;5;${DIR_COLOR}" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << EOF
# Symbolic link
LINK 01;38;5;${LINK_COLOR}
# Broken symbolic link
ORPHAN 01;38;5;$(hex_to_ansi "$ERROR")
# Fifo/pipe
FIFO 38;5;${ARCHIVE_COLOR}
# Socket
SOCK 01;38;5;${ARCHIVE_COLOR}
# Block device driver
BLK 38;5;${ARCHIVE_COLOR}
# Character device driver
CHR 38;5;${ARCHIVE_COLOR}
# Executable file
EXEC 01;38;5;${EXEC_COLOR}

# Archives
.tar 38;5;${ARCHIVE_COLOR}
.tgz 38;5;${ARCHIVE_COLOR}
.arc 38;5;${ARCHIVE_COLOR}
.arj 38;5;${ARCHIVE_COLOR}
.taz 38;5;${ARCHIVE_COLOR}
.lha 38;5;${ARCHIVE_COLOR}
.lz4 38;5;${ARCHIVE_COLOR}
.lzh 38;5;${ARCHIVE_COLOR}
.lzma 38;5;${ARCHIVE_COLOR}
.tlz 38;5;${ARCHIVE_COLOR}
.txz 38;5;${ARCHIVE_COLOR}
.tzo 38;5;${ARCHIVE_COLOR}
.t7z 38;5;${ARCHIVE_COLOR}
.zip 38;5;${ARCHIVE_COLOR}
.z 38;5;${ARCHIVE_COLOR}
.dz 38;5;${ARCHIVE_COLOR}
.gz 38;5;${ARCHIVE_COLOR}
.lrz 38;5;${ARCHIVE_COLOR}
.lz 38;5;${ARCHIVE_COLOR}
.lzo 38;5;${ARCHIVE_COLOR}
.xz 38;5;${ARCHIVE_COLOR}
.zst 38;5;${ARCHIVE_COLOR}
.tzst 38;5;${ARCHIVE_COLOR}
.bz2 38;5;${ARCHIVE_COLOR}
.bz 38;5;${ARCHIVE_COLOR}
.tbz 38;5;${ARCHIVE_COLOR}
.tbz2 38;5;${ARCHIVE_COLOR}
.tz 38;5;${ARCHIVE_COLOR}
.deb 38;5;${ARCHIVE_COLOR}
.rpm 38;5;${ARCHIVE_COLOR}
.jar 38;5;${ARCHIVE_COLOR}
.war 38;5;${ARCHIVE_COLOR}
.ear 38;5;${ARCHIVE_COLOR}
.sar 38;5;${ARCHIVE_COLOR}
.rar 38;5;${ARCHIVE_COLOR}
.alz 38;5;${ARCHIVE_COLOR}
.ace 38;5;${ARCHIVE_COLOR}
.zoo 38;5;${ARCHIVE_COLOR}
.cpio 38;5;${ARCHIVE_COLOR}
.7z 38;5;${ARCHIVE_COLOR}
.rz 38;5;${ARCHIVE_COLOR}
.cab 38;5;${ARCHIVE_COLOR}
.wim 38;5;${ARCHIVE_COLOR}
.swm 38;5;${ARCHIVE_COLOR}
.dwm 38;5;${ARCHIVE_COLOR}
.esd 38;5;${ARCHIVE_COLOR}

# Image formats
.jpg 38;5;$(hex_to_ansi "$INFO")
.jpeg 38;5;$(hex_to_ansi "$INFO")
.mjpg 38;5;$(hex_to_ansi "$INFO")
.mjpeg 38;5;$(hex_to_ansi "$INFO")
.gif 38;5;$(hex_to_ansi "$INFO")
.bmp 38;5;$(hex_to_ansi "$INFO")
.pbm 38;5;$(hex_to_ansi "$INFO")
.pgm 38;5;$(hex_to_ansi "$INFO")
.ppm 38;5;$(hex_to_ansi "$INFO")
.tga 38;5;$(hex_to_ansi "$INFO")
.xbm 38;5;$(hex_to_ansi "$INFO")
.xpm 38;5;$(hex_to_ansi "$INFO")
.tif 38;5;$(hex_to_ansi "$INFO")
.tiff 38;5;$(hex_to_ansi "$INFO")
.png 38;5;$(hex_to_ansi "$INFO")
.svg 38;5;$(hex_to_ansi "$INFO")
.svgz 38;5;$(hex_to_ansi "$INFO")
.mng 38;5;$(hex_to_ansi "$INFO")
.pcx 38;5;$(hex_to_ansi "$INFO")
.webp 38;5;$(hex_to_ansi "$INFO")

# Video formats
.mov 38;5;$(hex_to_ansi "$INFO")
.mpg 38;5;$(hex_to_ansi "$INFO")
.mpeg 38;5;$(hex_to_ansi "$INFO")
.m2v 38;5;$(hex_to_ansi "$INFO")
.mkv 38;5;$(hex_to_ansi "$INFO")
.webm 38;5;$(hex_to_ansi "$INFO")
.ogm 38;5;$(hex_to_ansi "$INFO")
.mp4 38;5;$(hex_to_ansi "$INFO")
.m4v 38;5;$(hex_to_ansi "$INFO")
.mp4v 38;5;$(hex_to_ansi "$INFO")
.vob 38;5;$(hex_to_ansi "$INFO")
.qt 38;5;$(hex_to_ansi "$INFO")
.nuv 38;5;$(hex_to_ansi "$INFO")
.wmv 38;5;$(hex_to_ansi "$INFO")
.asf 38;5;$(hex_to_ansi "$INFO")
.rm 38;5;$(hex_to_ansi "$INFO")
.rmvb 38;5;$(hex_to_ansi "$INFO")
.flc 38;5;$(hex_to_ansi "$INFO")
.avi 38;5;$(hex_to_ansi "$INFO")
.fli 38;5;$(hex_to_ansi "$INFO")
.flv 38;5;$(hex_to_ansi "$INFO")
.gl 38;5;$(hex_to_ansi "$INFO")
.dl 38;5;$(hex_to_ansi "$INFO")
.xcf 38;5;$(hex_to_ansi "$INFO")
.xwd 38;5;$(hex_to_ansi "$INFO")
.yuv 38;5;$(hex_to_ansi "$INFO")
EOF

echo "✓ Generated dircolors file: $OUTPUT_FILE"
echo "✓ Based on theme: $THEME_NAME"
echo ""
echo "To activate, add this to your ~/.zshrc:"
echo "  eval \"\$(dircolors ~/.config/colors/dircolors)\""
