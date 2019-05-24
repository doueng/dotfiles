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
