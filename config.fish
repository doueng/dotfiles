fish_add_path /usr/local/bin
fish_add_path /opt/uber/bin
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.aw/pex_resources/scripts/binaries"

set -U EDITOR nvim
set -U VISUAL nvim
set -U KEYTIMEOUT 1
set -U LESS "-S -R"
set -U TERM kitty
set -U SHOW_CURSOR "\x1B[?25h"
set -U HIDE_CURSOR "\x1B[?25l"
set -U fish_greeting ''
set -U fish_escape_delay_ms 10
set -U fish_color_valid_path

alias git /usr/local/bin/git
alias basename /usr/bin/basename
alias kill /bin/kill

function hide_curstor_postexec --on-event fish_postexec
    printf $HIDE_CURSOR
end

load_aliases

# Disable all syntax colors
for color in (set | grep -Eo '^fish_color_[a-zA-Z0-9_]+')
    set $color normal
end

set fish_color_autosuggestion green
