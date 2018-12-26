source <(antibody init)
antibody bundle denysdovhan/spaceship-prompt
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

local ZSH_FOLDER=~/dotfiles/zsh/

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
