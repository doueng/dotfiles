
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  #char          # Prompt character
)

SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_VI_MODE_INSERT="❯"
SPACESHIP_VI_MODE_NORMAL="❮"
SPACESHIP_VI_MODE_COLOR=green
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false

local INSERT_MODE_COLOR=green
local NORMAL_MODE_COLOR=red

zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        SPACESHIP_VI_MODE_COLOR=$NORMAL_MODE_COLOR
    else
        SPACESHIP_VI_MODE_COLOR=$INSERT_MODE_COLOR
    fi
    zle reset-prompt
}

zle-line-init () {
    SPACESHIP_VI_MODE_COLOR=$INSERT_MODE_COLOR
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

