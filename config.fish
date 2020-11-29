fish_add_path /usr/local/bin
fish_add_path /opt/uber/bin
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.aw/pex_resources/scripts/binaries"


set -U EDITOR nvim
set -U VISUAL nvim
set -U KEYTIMEOUT 1
set -U LESS "-S -R"
set -U TERMINAL kitty
set -U SHOW_CURSOR "\x1B[?25h"
set -U HIDE_CURSOR "\x1B[?25l"

function hide_curstor_postexec --on-event fish_postexec
    printf "$HIDE_CURSOR"
end

set fish_greeting ''
set fish_escape_delay_ms 10
# This is set with --underline by default
set fish_color_valid_path

load_aliases

# Disable all syntax colors
for color in (set | grep -Eo '^fish_color_[a-zA-Z0-9_]+')
    set $color normal
end

set fish_color_autosuggestion green
