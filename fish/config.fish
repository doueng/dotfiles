set SHOW_CURSOR "\x1B[?25h"
set HIDE_CURSOR "\x1B[?25l"

printf $HIDE_CURSOR

function fish_vi_cursor --on-variable fish_bind_mode
    if set -q __last_fish_bind_mode
        and test $__last_fish_bind_mode = $fish_bind_mode
        return
    end
    set -g __last_fish_bind_mode $fish_bind_mode

    switch $fish_bind_mode
        case insert
            printf $HIDE_CURSOR
        case default
            printf $SHOW_CURSOR
            printf '\e]50;CursorShape=0\x7'
        case "*"
            printf $SHOW_CURSOR
            printf '\e]50;CursorShape=0\x7'
    end
end

function hide_curstor_postexec --on-event fish_postexec
	printf "$HIDE_CURSOR"
end

function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function de_nextd --description "Move forward in the directory history"

    __fish_move_last dirnext dirprev

    # Set direction for 'cd -'
    set -g __fish_cd_direction prev

    commandline -f repaint
end

function de_prevd --description "Move back in the directory history"
    __fish_move_last dirprev dirnext

    # Set direction for 'cd -'
    set -g __fish_cd_direction next

    commandline -f repaint
end


set fish_color_autosuggestion grey

alias dc="cd"
alias l="ls -lh"
alias la="ls -lha"
alias vf="vi $HOME/.config/fish/config.fish"
alias vi="nvim $argv"
alias gs="git status"
alias gr="git reset"
alias gch="git checkout"
alias gch-="git checkout -"
alias gchm="git checkout master"
alias internet="nmcli con up id Javaplein"
alias restart_bluetooth="sudo systemctl restart bluetooth"

# cd
alias ...="../.."
alias dc="cd"
alias cdd='cd $HOME/Downloads'

# zsh
alias ezsh="exec zsh"

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
alias zrc='vi $HOME/.zshrc'
alias vrc='vi $HOME/.config/nvim/init.vim'

# colordiff
alias diff="colordiff"

# top
alias topm="top -o %MEM"
alias topc="top -o %CPU"

# clipboard
alias copy="xclip -selection c"
alias paste="xclip -selection c -o"

# git
alias gcl='git clone'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gau='git add -u'
alias gl='git log'
alias gb='git branch'
alias gg='cd (git rev-parse --show-cdup)'
alias gch='git checkout'
alias gd='git diff'

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
#eval "(fasd --init posix-alias zsh-hook zsh-ccomp)"
#alias a='fasd -a'        # any
#alias s='fasd -si'       # show / search / select
#alias d='fasd -d'        # directory
#alias f='fasd -f'        # file
##alias sd='fasd -sid'     # interactive directory selection
#alias sf='fasd -sif'     # interactive file selection
#alias z='fasd_cd -d'     # cd, same functionality as j in autojump
#alias zz='fasd_cd -d -i' # cd with interactive selection
#alias v='f -e nvim'      # quick opening files with neovim

# tree
alias tree="tree -I node_modules"

# make that produces compile_commands.json
# needed for rtags in emacs
alias bm="bear make -j"

# trash-cli
alias trash="trash-put"

# logout without being at login shell
alias logoutf='pkill -KILL -u $USER'

# system info
alias battery="acpi"

# gdb
alias gdb="gdb -q"

# git bare
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# bluetooth
alias airpods='echo "connect  38:EC:0D:87:88:D6" | bluetoothctl'
alias sony='echo "connect  38:18:4C:D3:2C:F0" | bluetoothctl'

# mpv
alias mpv='devour.sh mpv'


set fish_greeting ''
set fish_escape_delay_ms 10
# This is set with --underline by default
set fish_color_valid_path

bind -M insert \co 'cd -; commandline -f repaint'
#bind -M insert \co 'de_prevd'
#bind -M insert \ci 'de_nextd'
bind -M insert '!' bind_bang
bind -M insert '$' bind_dollar
bind -M insert \cf accept-autosuggestion execute
