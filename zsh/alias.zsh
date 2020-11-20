# sway
alias swrc="vi ~/.config/sway/config"

# cd
alias ...="../.."
alias dc="cd"
alias cdd="cd ~/Downloads"

# zsh
alias ezsh="exec zsh"

# path
alias PATH="env | grep PATH | tr : '\n'"

# Get week number
alias week="date +%V"

# ls
alias ls="ls --color"
alias sl="ls"
alias ll="ls -lh"
alias l="ll"
alias la="ls -a"
alias lla="l -a"

# vim
alias vi=nvim

# dotfiles
alias zrc="vi ~/.zshrc"
alias vrc="vi ~/.config/nvim/init.vim"

# colordiff
alias diff="colordiff"

# top
alias topm="top -o %MEM"
alias topc="top -o %CPU"

# clipboard
alias copy="xclip -selection c"
alias paste="xclip -selection c -o"

# git
alias gr='git restore'
alias grs='git restore --staged'
alias grh='git reset head~ --soft'
alias gcl='git clone'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gs='git status'
alias gau='git add -u'
alias gl='git log'
alias gg='cd $(git rev-parse --show-cdup)'
alias gch='git checkout'
alias gchm='git checkout master'
alias gb='git --no-pager branch'
alias gd='git diff'
alias gdm='git diff master'
alias gdh='git diff head'
alias gdh~='git diff head~'
alias gclean='git clean -fd'

# chmod
alias exe="chmod 755"

# leetcode
alias lc="leetcode"
alias lcl="leetcode list"
alias lcs="leetcode submit"

# valgrind
alias vg="valgrind"
alias vgfull="valgrind --leak-check=full"

# which
alias wa="which -a"

# python
alias new_venv="python3 -m venv"

# tree
alias tree="tree -I node_modules"

# emacs
alias e="emacsclient -c -n $1"
alias ee="emacsclient -e $1"

# make that produces compile_commands.json
# needed for rtags in emacs
alias bm="bear make -j"

# for pasting shell commands
alias "$"=""

# ocaml
#eval $(opam env)
#alias oc=ocamlopt

# yay
alias yayuninstall="yay -Rns $1"
alias yaygitupdate='yay -Syu --devel --timeupdate'
alias yayprune='yay -Yc'

# trash-cli
alias trash='trash-put'

# logout without being at login shell
alias logoutf="pkill -KILL -u $USER"

# system info
alias battery='acpi'

# update 
alias updateantibody="antibody bundle < $ZSH_FOLDER/antibody_plugins.txt > $ZSH_FOLDER/antibody_plugins.sh"

# gdb
alias gdb='gdb -q'

# chrome
alias dedup='chrome.js dedup --yes'

# toolbox
alias toolbox='TERM=xterm-256color toolbox'
