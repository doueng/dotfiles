# vim mode
bindkey -v

# backspace and ^h working even after
# returning from normal mode
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char

# history
bindkey "^k" history-beginning-search-backward
bindkey "^j" history-beginning-search-forward
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
