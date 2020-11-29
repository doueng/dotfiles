function load_cursor
    set SHOW_CURSOR "\x1B[?25h"
    set HIDE_CURSOR "\x1B[?25l"

    printf $HIDE_CURSOR

    function hide_curstor_postexec --on-event fish_postexec
        printf "$HIDE_CURSOR"
    end

    function de_prevd --description "Move back in the directory history"
        __fish_move_last dirprev dirnext

        # Set direction for 'cd -'
        set -g __fish_cd_direction next

        commandline -f repaint
    end
end
