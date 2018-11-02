# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...
export KEYTIMEOUT=1

# z
#. /usr/local/etc/profile.d/z.sh
# . ~/z/z.sh

# for pasting shell commands
alias "$"=""

# change language to english
export LANG="en_US.UTF-8"

# curl
alias curlo="curl -O"

# testing
alias -s text=vi

# tree
alias tree='tree -I node_modules'

# fasd
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp)"
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e nvim' # quick opening files with neovim
alias zo='a -e open'

# path
alias PATH="env | grep PATH | tr : '\n'"

# Get week number
alias week='date +%V'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LS_COLORS=gxBxhxDxfxhxhxhxhxcxcx

# vim 
# alias vi=vim
alias vi=nvim
# export EDITOR=/usr/bin/vim
# export VISUAL=/usr/bin/vim
export EDITOR=nvim
export VISUAL=nvim
export VIMRC=~/.config/nvim/init.vim


# dotfiles
alias zrc="vi ~/.zshrc"
alias vrc="vi ~/.config/nvim/init.vim"

# git
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gau="git add -u"
alias gl="git log"

# chmod
alias exe="chmod 755"

# leetcode
alias lc="leetcode"
alias lcl="leetcode list"
alias lcs="leetcode submit"

# valgrind
alias vg="valgrind"
alias vgfull="valgrind --leak-check=full"

bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward

# chrome
alias chrome="o -a Google\ Chrome"

# vs code
alias code="o -a Visual\ Studio\ Code"

#bindkey -s "\el" "clear\n"

# redirection > deletes file
set +o noclobber

# du disk usage
alias foldersize="du -dh"

# python
alias new_env="python3 -m venv"

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# which
alias which="which -a"

# mkdir
function mkdcd () {
	mkdir $1 && cd $1
}

export MAIL=dengstra@student.42.fr

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
