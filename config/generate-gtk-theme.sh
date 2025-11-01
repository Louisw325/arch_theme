#!/bin/bash
# Generate GTK theme settings from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
GTK3_CONFIG="$HOME/.config/gtk-3.0/settings.ini"
GTK4_CONFIG="$HOME/.config/gtk-4.0/settings.ini"

# Check if theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# Source the theme
source "$THEME_FILE"

# Function to write GTK config
write_gtk_config() {
    local theme_name="$1"
    local config_file="$2"
    
    mkdir -p "$(dirname "$config_file")"
    
    cat > "$config_file" << EOF
[Settings]
gtk-theme-name=${theme_name}
gtk-icon-theme-name=Nordzy-dark
gtk-cursor-theme-name=Nordzy-cursors
gtk-font-name=Sans 10
gtk-application-prefer-dark-theme=1
EOF
}

# Apply GTK theme based on the active color theme
case "$THEME_NAME" in
    "BloodMoon")
        GTK_THEME="Graphite-red-Dark"
        gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        write_gtk_config "$GTK_THEME" "$GTK3_CONFIG"
        write_gtk_config "$GTK_THEME" "$GTK4_CONFIG"
        echo "✓ Applied GTK theme: $GTK_THEME"
        ;;
    "Nord"|"Nordic")
        GTK_THEME="nordic-theme"
        gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        write_gtk_config "$GTK_THEME" "$GTK3_CONFIG"
        write_gtk_config "$GTK_THEME" "$GTK4_CONFIG"
        echo "✓ Applied GTK theme: $GTK_THEME"
        ;;
    *)
        echo "! No GTK theme mapping for: $THEME_NAME"
        echo "  Using default dark theme"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        ;;
esac
