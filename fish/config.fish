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
set -Ux CARGO_BUILD_TARGET_DIR "$HOME/.cargo/target"
set -U SHOW_CURSOR "\x1B[?25h"
set -U HIDE_CURSOR "\x1B[?25l"
set -U fish_greeting ''
set -U fish_escape_delay_ms 10
set -U fish_color_valid_path
set -U fish_key_bindings fish_vi_key_bindings

set_prompt_cwd
function change_prompt_cwd --on-variable PWD
    set_prompt_cwd
end

printf $HIDE_CURSOR
function hide_cursor_postexec --on-event fish_postexec
    printf $HIDE_CURSOR
end

function hide_cursor_cancel_command
    __fish_cancel_commandline
    set fish_bind_mode insert
    printf $HIDE_CURSOR
end

load_aliases

# Disable all syntax colors
for color in (set | grep -Eo '^fish_color_[a-zA-Z0-9_]+')
    set $color normal
end

set fish_color_autosuggestion green

# https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
if status --is-interactive
    set _fishprompt_aid "fish"$fish_pid
    set _fishprompt_started 0
    # empty if running; or a numeric exit code; or CANCEL
    set _fishprompt_postexec ""

    functions -c fish_prompt _fishprompt_saved_prompt
    set _fishprompt_prompt_count 0
    set _fishprompt_disp_count 0
    function _fishprompt_start --on-event fish_prompt
        set _fishprompt_prompt_count (math $_fishprompt_prompt_count + 1)
        # don't use post-exec, because it is called *before* omitted-newline output
        if [ -n "$_fishprompt_postexec" ]
            printf "\033]133;D;%s;aid=%s\007" "$_fishprompt_postexec" $_fishprompt_aid
        end
        printf "\033]133;A;aid=%s;cl=m\007" $_fishprompt_aid
    end

    function fish_prompt
        set _fishprompt_disp_count (math $_fishprompt_disp_count + 1)
        printf "\033]133;P;k=i\007%b\033]133;B\007" (string join "\n" (_fishprompt_saved_prompt))
        set _fishprompt_started 1
        set _fishprompt_postexec ""
    end

    function _fishprompt_preexec --on-event fish_preexec
        if [ "$_fishprompt_started" = 1 ]
            printf "\033]133;C;\007"
        end
        set _fishprompt_started 0
    end

    function _fishprompt_postexec --on-event fish_postexec
        set _fishprompt_postexec $status
    end

    function __fishprompt_cancel --on-event fish_cancel
        set _fishprompt_postexec CANCEL
        _fishprompt_start
    end

    function _fishprompt_exit --on-process %self
        if [ "$_fishprompt_started" = 1 ]
            printf "\033]133;Z;aid=%s\007" $_fishprompt_aid
        end
    end

    if functions -q fish_right_prompt
        functions -c fish_right_prompt _fishprompt_saved_right_prompt
        function fish_right_prompt
            printf "\033]133;P;k=r\007%b\033]133;B\007" (string join "\n" (_fishprompt_saved_right_prompt))
        end
    end
end
