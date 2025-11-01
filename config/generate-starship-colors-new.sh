#!/bin/bash
# Generate Starship theme colors from active theme

THEME_FILE="$HOME/.config/colors/active-theme.conf"
STARSHIP_CONFIG="$HOME/.config/starship.toml"
STARSHIP_TEMPLATE="$HOME/.config/colors/starship.toml.template"
BACKUP_DIR="$HOME/.config/colors/backups"

mkdir -p "$BACKUP_DIR"

if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

if [ -f "$STARSHIP_CONFIG" ]; then
    if ! grep -q "# Theme colors managed by" "$STARSHIP_CONFIG"; then
        cp "$STARSHIP_CONFIG" "$BACKUP_DIR/starship.toml.$(date +%Y%m%d_%H%M%S)"
        echo "✓ Backed up original starship.toml"
    fi
fi

source "$THEME_FILE"

cat > "$STARSHIP_TEMPLATE" << 'TEMPLATE_EOF'
#Location: ~/.config/starship.toml
# Theme colors managed by ~/.config/colors/switch-theme.sh

add_newline = true
command_timeout = 2000

format = """$env_var$os$username$hostname$kubernetes$directory$git_branch$git_status$python
$character
"""

[character]
# Use a connector arrow so the prompt line connects visually to the input
success_symbol = "╰─➜"
error_symbol = "╰─➜"

[env_var]
symbol = "╭╴"
variable = 'SHELL'
format = "$symbol"
disabled = false

[os]
format = '[$symbol](bold white) '   
disabled = false

[os.symbols]
Windows = ' '
Arch = '󰣇'
Ubuntu = ''
Macos = '󰀵'
Unknown = '󰠥'

[username]
style_user = 'bold {{PRIMARY}}'
style_root = 'bold {{ACCENT}}'
format = '[//]({{FG_DIM}}) [$user](bold {{PRIMARY_LIGHT}}) '
disabled = false
show_always = true

[hostname]
ssh_only = false
format = '[//]({{FG_DIM}}) [$hostname](bold {{INFO}}) '
disabled = false

[directory]
truncation_length = 0
truncation_symbol = '…/'
# Set a Nerd Font home glyph so home displays correctly when using a Nerd Font
home_symbol = ''
read_only = '  '
# Use PRIMARY_LIGHT for directory/path to make folders the light blue accent
format = '[//]({{FG_DIM}}) [$path](bold {{PRIMARY_LIGHT}})[$read_only]($read_only_style) '
style = 'bold {{PRIMARY_LIGHT}}'

[git_branch]
symbol = ' '
format = '[//]({{FG_DIM}}) [$symbol\[$branch\]](bold {{SUCCESS}}) '
style = 'bold {{SUCCESS}}'

[git_status]
disabled = true
format = '[ $all_status $ahead_behind](bold {{ACCENT}}) '
style = 'bold {{ACCENT}}'
conflicted = '🏳'
up_to_date = ''
untracked = ' '
ahead = '⇡${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
behind = '⇣${count}'
stashed = ' '
modified = ' '
staged = '[++\($count\)](green)'
renamed = '襁 '
deleted = ' '

[kubernetes]
format = 'via [󱃾 $context\($namespace\)](bold purple) '
disabled = false

[vagrant]
disabled = true

[docker_context]
disabled = true

[helm]
disabled = true

[python]
symbol = '󰌠'
python_binary = ['./venv/bin/python', 'python', 'python3', 'python2']
format = '[//]({{FG_DIM}}) [${symbol} ${pyenv_prefix}(${version} )(\($virtualenv\) )](bold {{INFO}}) '
style = 'bold {{INFO}}'

[nodejs]
disabled = true

[ruby]
disabled = true

[terraform]
disabled = true
TEMPLATE_EOF

sed "s/{{PRIMARY}}/${PRIMARY}/g; \
     s/{{PRIMARY_LIGHT}}/${PRIMARY_LIGHT}/g; \
     s/{{ACCENT}}/${ACCENT}/g; \
     s/{{SUCCESS}}/${SUCCESS}/g; \
     s/{{WARNING}}/${WARNING}/g; \
     s/{{ERROR}}/${ERROR}/g; \
     s/{{INFO}}/${INFO}/g; \
     s/{{FG_DIM}}/${FG_DIM}/g" "$STARSHIP_TEMPLATE" > "$STARSHIP_CONFIG"

echo "✓ Generated Starship configuration"
echo "✓ Theme: $THEME_NAME"
echo "  Primary: $PRIMARY | Accent: $ACCENT | Success: $SUCCESS | Info: $INFO"
