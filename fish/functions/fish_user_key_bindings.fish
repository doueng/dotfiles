function fish_user_key_bindings
    bind -M insert \co de_prevd
    bind -M insert \ci nextd-or-complete
    bind -M insert '!' bind_bang
    bind -M insert '$' bind_dollar
    bind -M insert \cf accept-autosuggestion execute
    bind -M insert \cl /usr/bin/clear commandline -f repaint
    bind -M insert \cc hide_cursor_cancel_command
    bind -M default \cc hide_cursor_cancel_command
    fzf_key_bindings
end
