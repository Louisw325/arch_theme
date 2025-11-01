#!/usr/bin/env bash
# Generate lsd (modern ls) color configuration from active theme
# This script prefers hex (truecolor) entries but will fall back to
# xterm-256 indices if the installed `lsd` does not emit truecolor.

set -euo pipefail

THEME_FILE="$HOME/.config/colors/active-theme.conf"
LSD_DIR="$HOME/.config/lsd"

if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

mkdir -p "$LSD_DIR"
source "$THEME_FILE"

# hex_to_256: accurate mapping to xterm-256 (used as fallback)
hex_to_256() {
    local hex="${1#\#}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))

    if [ "$r" -eq "$g" ] && [ "$g" -eq "$b" ]; then
        if [ "$r" -lt 8 ]; then
            echo 16; return
        elif [ "$r" -gt 248 ]; then
            echo 231; return
        else
            local numer=$(( (r - 8) * 23 + 123 ))
            echo $(( 232 + numer / 247 ))
            return
        fi
    fi

    local ir=$(( (r * 5 + 127) / 255 ))
    local ig=$(( (g * 5 + 127) / 255 ))
    local ib=$(( (b * 5 + 127) / 255 ))
    if [ $ir -lt 0 ]; then ir=0; elif [ $ir -gt 5 ]; then ir=5; fi
    if [ $ig -lt 0 ]; then ig=0; elif [ $ig -gt 5 ]; then ig=5; fi
    if [ $ib -lt 0 ]; then ib=0; elif [ $ib -gt 5 ]; then ib=5; fi
    echo $(( 16 + 36 * ir + 6 * ig + ib ))
}

# Prepare values
PRIMARY_HEX="$PRIMARY"
ACCENT_HEX="$ACCENT"
SUCCESS_HEX="$SUCCESS"
WARNING_HEX="$WARNING"
ERROR_HEX="$ERROR"
INFO_HEX="$INFO"
FG_HEX="$FG"
FG_DIM_HEX="$FG_DIM"
URGENT_HEX="$URGENT"

PRIMARY_256=$(hex_to_256 "$PRIMARY_HEX")
ACCENT_256=$(hex_to_256 "$ACCENT_HEX")
SUCCESS_256=$(hex_to_256 "$SUCCESS_HEX")
WARNING_256=$(hex_to_256 "$WARNING_HEX")
ERROR_256=$(hex_to_256 "$ERROR_HEX")
INFO_256=$(hex_to_256 "$INFO_HEX")
FG_256=$(hex_to_256 "$FG_HEX")
FG_DIM_256=$(hex_to_256 "$FG_DIM_HEX")
URGENT_256=$(hex_to_256 "$URGENT_HEX")

OUTPUT_FILE="$LSD_DIR/colors.yaml"
BACKUP_FILE="$OUTPUT_FILE.bak.$(date +%s)"

if [ -f "$OUTPUT_FILE" ]; then
    cp "$OUTPUT_FILE" "$BACKUP_FILE"
    echo "Backed up existing colors.yaml -> $(basename "$BACKUP_FILE")"
fi

# Write a hex-based colors.yaml (preferred)
cat > "$OUTPUT_FILE" << EOF
# lsd colors - Generated from $THEME_NAME theme
# Using hex (truecolor) values where possible
user: "$PRIMARY_HEX"
group: "$ACCENT_HEX"
permission:
  read: "$SUCCESS_HEX"
  write: "$WARNING_HEX"
  exec: "$ACCENT_HEX"
  exec-sticky: "$URGENT_HEX"
  no-access: "$FG_DIM_HEX"
  octal: "$FG_DIM_HEX"
  acl: "$INFO_HEX"
  context: "$INFO_HEX"
date:
  hour-old: "$FG_HEX"
  day-old: "$FG_DIM_HEX"
  older: "$FG_DIM_HEX"
size:
  none: "$FG_DIM_HEX"
  small: "$SUCCESS_HEX"
  medium: "$WARNING_HEX"
  large: "$ERROR_HEX"
inode:
  valid: "$FG_DIM_HEX"
  invalid: "$ERROR_HEX"
links:
  valid: "$ACCENT_HEX"
  invalid: "$ERROR_HEX"
tree-edge: "$FG_DIM_HEX"
git-status:
  default: "$FG_HEX"
  unmodified: "$FG_HEX"
  ignored: "$FG_DIM_HEX"
  new-in-index: "$SUCCESS_HEX"
  new-in-workdir: "$SUCCESS_HEX"
  typechange: "$WARNING_HEX"
  deleted: "$ERROR_HEX"
  renamed: "$ACCENT_HEX"
  modified: "$WARNING_HEX"
  conflicted: "$URGENT_HEX"
file-type:
  file:
    exec-uid: "$WARNING_HEX"
    uid-no-exec: "$WARNING_HEX"
    exec-no-uid: "$ACCENT_HEX"
    no-exec-no-uid: "$FG_HEX"
  dir:
    uid: "$PRIMARY_HEX"
    no-uid: "$PRIMARY_HEX"
  pipe: "$WARNING_HEX"
  symlink:
    default: "$ACCENT_HEX"
    broken: "$ERROR_HEX"
    missing-target: "$ERROR_HEX"
  block-device: "$WARNING_HEX"
  char-device: "$WARNING_HEX"
  socket: "$INFO_HEX"
  special: "$WARNING_HEX"
EOF

echo "Wrote hex-based $OUTPUT_FILE — testing whether lsd emits truecolor escapes..."

# Test lsd output for truecolor (38;2;R;G;B) vs 256-index (38;5;N)
TEST_OUT=$(lsd --color=always | head -n 5 | cat -v || true)

if echo "$TEST_OUT" | grep -q "38;2;"; then
    echo "✓ lsd emitted truecolor escapes. Hex colors will be used."
    exit 0
fi

echo "ℹ lsd did not emit truecolor escapes. Falling back to xterm-256 indices."

# write numeric fallback file
cat > "$OUTPUT_FILE" << EOF
# lsd colors - Generated from $THEME_NAME theme
# Using xterm-256 indices (fallback)
user: $PRIMARY_256
group: $ACCENT_256
permission:
  read: $SUCCESS_256
  write: $WARNING_256
  exec: $ACCENT_256
  exec-sticky: $URGENT_256
  no-access: $FG_DIM_256
  octal: $FG_DIM_256
  acl: $INFO_256
  context: $INFO_256
date:
  hour-old: $FG_256
  day-old: $FG_DIM_256
  older: $FG_DIM_256
size:
  none: $FG_DIM_256
  small: $SUCCESS_256
  medium: $WARNING_256
  large: $ERROR_256
inode:
  valid: $FG_DIM_256
  invalid: $ERROR_256
links:
  valid: $ACCENT_256
  invalid: $ERROR_256
tree-edge: $FG_DIM_256
git-status:
  default: $FG_256
  unmodified: $FG_256
  ignored: $FG_DIM_256
  new-in-index: $SUCCESS_256
  new-in-workdir: $SUCCESS_256
  typechange: $WARNING_256
  deleted: $ERROR_256
  renamed: $ACCENT_256
  modified: $WARNING_256
  conflicted: $URGENT_256
file-type:
  file:
    exec-uid: $WARNING_256
    uid-no-exec: $WARNING_256
    exec-no-uid: $ACCENT_256
    no-exec-no-uid: $FG_256
  dir:
    uid: $PRIMARY_256
    no-uid: $PRIMARY_256
  pipe: $WARNING_256
  symlink:
    default: $ACCENT_256
    broken: $ERROR_256
    missing-target: $ERROR_256
  block-device: $WARNING_256
  char-device: $WARNING_256
  socket: $INFO_256
  special: $WARNING_256
EOF

echo "✓ Wrote fallback xterm-256 colors to $OUTPUT_FILE (backup kept as $(basename "$BACKUP_FILE"))."

exit 0
