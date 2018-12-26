# function zle-keymap-select zle-line-init zle-line-finish
# {
#   case $KEYMAP in
# 	  vicmd)      print -n '\033[2 q';; # block cursor
# 	  viins|main) print -n '\033[8 q';; # line cursor
#   esac
# }

# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select

# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
	bindkey -M $m $c select-quoted
  done
done

# ci{, ci(
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
	bindkey -M $m $c select-bracketed
  done
done

# surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
