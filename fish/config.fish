fish_add_path --append /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/uber/bin
fish_add_path "$HOME/.emacs.d/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path --append "$HOME/.aw/pex_resources/scripts/binaries"

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux KEYTIMEOUT 1
set -Ux LESS "-S -R"
set -Ux TERM kitty
set -Ux UBER_LDAP_UID engstrand
set -U SHOW_CURSOR "\x1B[?25h"
set -U HIDE_CURSOR "\x1B[?25l"
set -U fish_greeting
set -U fish_escape_delay_ms 10
set -U fish_color_valid_path

set_prompt_cwd
function change_prompt_cwd --on-variable PWD
    set_prompt_cwd
end

printf $HIDE_CURSOR
function hide_cursor_postexec --on-event fish_postexec
    printf $HIDE_CURSOR
end

load_aliases

# Disable all syntax colors
for color in (set | grep -Eo '^fish_color_[a-zA-Z0-9_]+')
    set $color normal
end

set fish_color_autosuggestion green
