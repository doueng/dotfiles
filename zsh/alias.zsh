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
case $(uname) in
    Darwin)
        alias ls="ls -G"
    ;;
    Linux)
        alias ls="ls --color"
    ;;
esac
alias l="ls -lh"
alias sl="l"
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
alias copy="wl-copy"
alias paste="wl-paste"

# git
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gau="git add -u"
alias gl="git log"
alias gg='cd $(git rev-parse --show-cdup)'

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
alias v='f -e nvim'      # quick opening files with neovim

# curl
alias curlo="curl -O"

# tree
alias tree="tree -I node_modules"

# emacs
alias e="emacsclient -c -n $1"
alias ee="emacsclient -e $1"

# make that produces compile_commands.json
# needed for rtags in emacs
alias gbm="bear gmake -j"
alias bm="bear make -j"

# for pasting shell commands
alias "$"=""

# ocaml
#eval $(opam env)
alias oc=ocamlopt

# yay
alias yayuninstall="yay -Rns $1"
alias yaygitupdate="yay -Syu --devel --timeupdate"
alias yayprune="yay -Yc"

# trash-cli
alias trash="trash-put"

# logout without being at login shell
alias logoutf="pkill -KILL -u $USER"

# system info
alias battery="acpi"

# update 
alias updateantibody="antibody bundle < $ZSH_FOLDER/antibody_plugins.txt > $ZSH_FOLDER/antibody_plugins.sh"
