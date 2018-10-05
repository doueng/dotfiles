#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...
export KEYTIMEOUT=1

# z
#. /usr/local/etc/profile.d/z.sh
. ~/z/z.sh

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LS_COLORS=gxBxhxDxfxhxhxhxhxcxcx

# vim 
alias vi=nvim
alias vim=nvim
export EDITOR=nvim
export VISUAL=nvim


# dotfiles
alias zrc="vi ~/.zshrc"
alias vrc="vi ~/.vimrc"
alias krc="vi ~/Library/Preferences/kitty/kitty.conf"
alias arc="vi ~/.alacritty.yml"

# git
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"

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

#bindkey -s "\el" "clear\n"

# redirection > deletes file
set +o noclobber

# du disk usage
alias foldersize="du -dh"

# python
alias new_env="python3 -m venv"

# android
alias adb="/Users/Admin/Downloads/platform-tools/adb"
alias androidDownloadFolder="/storage/emulated/0/download"

# random number
# seq 20 | gshuf

# Anaconda
#export PATH="/Users/Admin/anaconda2/bin:$PATH"
# conda
# source activate interview
# source deactivate

export PATH="/usr/local/opt/texinfo/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
