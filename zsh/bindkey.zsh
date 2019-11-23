# make delete work
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
# history
bindkey -M viins "^k" vi-cmd-mode
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# alt-k
bindkey -M viins "^[k" clear-screen
bindkey -M vicmd "^[k" clear-screen
bindkey -M viins "^[[C" clear-screen
bindkey -M vicmd "^[[C" clear-screen

# vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
