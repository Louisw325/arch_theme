#!/bin/bash#!/bin/bash

# Generate Starship theme colors from active theme# Generate Starship theme colors from active theme

# This script uses a clean template approach with placeholders

THEME_FILE="$HOME/.config/colors/active-theme.conf"

THEME_FILE="$HOME/.config/colors/active-theme.conf"STARSHIP_CONFIG="$HOME/.config/starship.toml"

STARSHIP_CONFIG="$HOME/.config/starship.toml"BACKUP_DIR="$HOME/.config/colors/backups"

STARSHIP_TEMPLATE="$HOME/.config/colors/starship.toml.template"

BACKUP_DIR="$HOME/.config/colors/backups"# Create backup directory

mkdir -p "$BACKUP_DIR"

# Create backup directory

mkdir -p "$BACKUP_DIR"# Check if theme file exists

if [ ! -f "$THEME_FILE" ]; then

# Check if theme file exists    echo "Error: Theme file not found: $THEME_FILE"

if [ ! -f "$THEME_FILE" ]; then    exit 1

    echo "Error: Theme file not found: $THEME_FILE"fi

    exit 1

fi# Backup existing starship.toml

if [ -f "$STARSHIP_CONFIG" ]; then

# Backup existing starship.toml if not a generated file    cp "$STARSHIP_CONFIG" "$BACKUP_DIR/starship.toml.$(date +%Y%m%d_%H%M%S)"

if [ -f "$STARSHIP_CONFIG" ]; thenfi

    if ! grep -q "# Theme colors managed by" "$STARSHIP_CONFIG"; then

        cp "$STARSHIP_CONFIG" "$BACKUP_DIR/starship.toml.$(date +%Y%m%d_%H%M%S)"# Source the theme

        echo "✓ Backed up original starship.toml"source "$THEME_FILE"

    fi

fi# Update Starship colors in-place using sed

# This preserves the structure and only updates color values

# Source the theme

source "$THEME_FILE"# Update username colors

sed -i "s/style_user = 'bold #[0-9A-Fa-f]\{6\}'/style_user = 'bold ${PRIMARY}'/" "$STARSHIP_CONFIG"

# Create the template if it doesn't existsed -i "s/style_root = 'bold #[0-9A-Fa-f]\{6\}'/style_root = 'bold ${ACCENT}'/" "$STARSHIP_CONFIG"

cat > "$STARSHIP_TEMPLATE" << 'TEMPLATE_EOF'

#Location: ~/.config/starship.toml# Update username format color

#What_is_starship: https://starship.rs/sed -i "s/\[\$user\](bold #[0-9A-Fa-f]\{6\})/[\$user](bold ${PRIMARY_LIGHT})/" "$STARSHIP_CONFIG"

# Theme colors managed by ~/.config/colors/switch-theme.sh

# Update hostname color

add_newline = truesed -i "s/\[\$hostname\](bold #[0-9A-Fa-f]\{6\})/[\$hostname](bold ${INFO})/" "$STARSHIP_CONFIG"

command_timeout = 2000

# Update directory colors

format = """$env_var$os$username$hostname$kubernetes$directory$git_branch$git_status$pythonsed -i "s/style = 'bold #[0-9A-Fa-f]\{6\}'/style = 'bold ${WARNING}'/" "$STARSHIP_CONFIG"

$character

"""# Update directory path color in format string

sed -i "s/\[\$path\](bold #[0-9A-Fa-f]\{6\})/[\$path](bold ${PRIMARY})/" "$STARSHIP_CONFIG"

[character]

success_symbol = "╰⎯"# Update directory separator color

error_symbol = "╰⎯"sed -i "s/\[\/\/\](#[0-9A-Fa-f]\{6\})/[\/\/](${FG_DIM})/" "$STARSHIP_CONFIG"



[env_var]# Update git branch colors  

symbol = "╭╴"sed -i "s/\[git_branch\]/[git_branch]\nstyle = 'bold ${SUCCESS}'/" "$STARSHIP_CONFIG" 2>/dev/null || true

variable = 'SHELL'

format = "$symbol"# Update git status colors

disabled = falsesed -i "s/\[git_status\]/[git_status]\nstyle = 'bold ${ACCENT}'/" "$STARSHIP_CONFIG" 2>/dev/null || true



[os]# Update Python colors

format = '[$symbol](bold white) '   sed -i "s/\[\(\\\\\\\\\\\\(\\\$virtualenv\)\](bold #[0-9A-Fa-f]\{6\})/[(\$virtualenv)](bold ${INFO})/" "$STARSHIP_CONFIG"

disabled = falsesed -i "s/symbol = '󰌠 '/symbol = '󰌠 '\nstyle = 'bold ${PRIMARY}'/" "$STARSHIP_CONFIG" 2>/dev/null || true



[os.symbols]echo "✓ Updated Starship configuration: $STARSHIP_CONFIG"

Windows = ' 'echo "✓ Based on theme: $THEME_NAME"

Arch = '󰣇'echo "✓ Backup saved to: $BACKUP_DIR"

Ubuntu = ''echo ""

Macos = '󰀵'echo "The changes will take effect in new terminal sessions."

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
home_symbol = ' '
read_only = '  '
format = '[//]({{FG_DIM}}) [$path](bold {{PRIMARY}})[$read_only]($read_only_style) '
style = 'bold {{PRIMARY}}'

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

# Generate the final config by replacing placeholders
sed "s/{{PRIMARY}}/${PRIMARY}/g; \
     s/{{PRIMARY_LIGHT}}/${PRIMARY_LIGHT}/g; \
     s/{{PRIMARY_DARK}}/${PRIMARY_DARK}/g; \
     s/{{ACCENT}}/${ACCENT}/g; \
     s/{{SUCCESS}}/${SUCCESS}/g; \
     s/{{WARNING}}/${WARNING}/g; \
     s/{{ERROR}}/${ERROR}/g; \
     s/{{INFO}}/${INFO}/g; \
     s/{{FG}}/${FG}/g; \
     s/{{FG_DIM}}/${FG_DIM}/g; \
     s/{{BG}}/${BG}/g" "$STARSHIP_TEMPLATE" > "$STARSHIP_CONFIG"

echo "✓ Generated Starship configuration: $STARSHIP_CONFIG"
echo "✓ Based on theme: $THEME_NAME"
echo "✓ Using template: $STARSHIP_TEMPLATE"
echo ""
echo "Colors applied:"
echo "  Primary: $PRIMARY"
echo "  Accent: $ACCENT"
echo "  Success: $SUCCESS"
echo "  Info: $INFO"
echo "  Separator: $FG_DIM"
echo ""
echo "Run 'exec zsh' or open a new terminal to see changes."
