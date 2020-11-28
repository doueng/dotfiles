set fish_color_autosuggestion grey
set fish_greeting ''
set fish_escape_delay_ms 10
# This is set with --underline by default
set fish_color_valid_path

bind -M insert \co 'de_prevd'
bind -M insert \ci 'nextd-or-complete'
bind -M insert '!' bind_bang
bind -M insert '$' bind_dollar
bind -M insert \cf accept-autosuggestion execute

load_cursor
load_aliases
