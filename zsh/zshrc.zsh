ZSH_FOLDER=~/dotfiles/zsh/

source $ZSH_FOLDER/antibody_plugins.sh
source $ZSH_FOLDER/cursor.zsh
source $ZSH_FOLDER/man.zsh
source $ZSH_FOLDER/vim.zsh
source $ZSH_FOLDER/setopt.zsh
source $ZSH_FOLDER/bindkey.zsh
source $ZSH_FOLDER/export.zsh
source $ZSH_FOLDER/alias.zsh
source $ZSH_FOLDER/functions.zsh
source $ZSH_FOLDER/completion.zsh
source $ZSH_FOLDER/prompt.zsh
source $ZSH_FOLDER/fzf.zsh

# remove path duplicates
typeset -aU path
