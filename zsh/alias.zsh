# open
alias o="open"
alias oa="open -a"

# zsh
alias ezsh="exec zsh"

# path
alias PATH="env | grep PATH | tr : '\n'"

# Get week number
alias week="date +%V"

# ls
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lhG"

# vim
alias vi=nvim

# dotfiles
alias zrc="vi ~/.zshrc"
alias vrc="vi ~/.config/nvim/init.vim"
# colordiff
alias diff="colordiff"

# top
alias topm="top -o mem"
alias topc="top -o cpu"

# clipboard
alias pbc="pbcopy"
alias pbp="pbpaste"

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

# chrome
alias chrome="o -a Google\ Chrome"

# which
alias which="which -a"

# python
alias new_env="python3 -m venv"

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
alias tree='tree -I node_modules'

# emacs
alias emacs="o -a emacs $1"

# make
alias make="bear gmake"

# for pasting shell commands
alias "$"=""

# ocaml
eval $(opam env)
alias oc=ocamlopt
