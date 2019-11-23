HISTFILE="$HOME/.zhistfile"
HISTSIZE=3000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END

# disable ctrl-s flow control
stty -ixon
