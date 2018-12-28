local SHOW_CURSOR="\x1B[?25h"
local HIDE_CURSOR="\x1B[?25l"
local UNDERSCORE_CURSOR="\E]50;CursorShape=2\C-G"

print -n $HIDE_CURSOR
function zle-keymap-select zle-line-init zle-line-finish
{
	print -n $UNDERSCORE_CURSOR
	if [ $KEYMAP = vicmd ]; then
		print -n $SHOW_CURSOR
	else
		print -n $HIDE_CURSOR
	fi
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
