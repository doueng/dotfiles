function fish_vi_cursor --on-variable fish_bind_mode
    if set -q __last_fish_bind_mode
        and test $__last_fish_bind_mode = $fish_bind_mode
        return
    end
    set -g __last_fish_bind_mode $fish_bind_mode
    set SHOW_CURSOR "\x1B[?25h"
    set HIDE_CURSOR "\x1B[?25l"

    switch $fish_bind_mode
        case insert
            printf $HIDE_CURSOR
        case default
            printf $SHOW_CURSOR
            printf '\e]50;CursorShape=0\x7'
        case "*"
            printf $SHOW_CURSOR
            printf '\e]50;CursorShape=0\x7'
    end
end
