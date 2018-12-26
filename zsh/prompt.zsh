
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  jobs          # Background jobs indicator
  exit_code     # Exit code section
)

# general
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false

# user
SPACESHIP_USER_COLOR=yellow
SPACESHIP_USER_COLOR_ROOT=red

# dir
SPACESHIP_DIR_COLOR=red
SPACESHIP_DIR_LOCK_SYMBOL=""

# jobs
SPACESHIP_JOBS_AMOUNT_PREFIX=" "

# vi
local SHOW_CURSOR="\x1B[?25h"
local HIDE_CURSOR="\x1B[?25l"
local UNDERSCORE_CURSOR="\E]50;CursorShape=2\C-G"

print -n $UNDERCORE_CURSOR
function zle-keymap-select zle-line-init zle-line-finish
{
	if [ $KEYMAP = vicmd ]; then
		print -n $SHOW_CURSOR
	else
		print -n $HIDE_CURSOR
	fi
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
