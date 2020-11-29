set SHOW_CURSOR "\x1B[?25h"
set HIDE_CURSOR "\x1B[?25l"

function hide_curstor_postexec --on-event fish_postexec
    printf "$HIDE_CURSOR"
end

set fish_color_autosuggestion grey
set fish_greeting ''
set fish_escape_delay_ms 10
# This is set with --underline by default
set fish_color_valid_path

load_aliases
