function load_aliases
    # Wifi
    alias internet="nmcli con up id Javaplein"

    # cd
    alias ...="../.."
    alias dc="cd"
    alias cdd='cd $HOME/Downloads'

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
    alias vf='vi $HOME/.config/fish/config.fish'

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
    alias gau='git add -u'
    alias gl='git log'
    alias gb='git branch'
    alias gg='cd (git rev-parse --show-cdup)'
    alias gch='git checkout'
    alias gd='git diff'
    alias gs="git status"
    alias gr="git reset"
    alias gch="git checkout"
    alias gch-="git checkout -"
    alias gchm="git checkout master"

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
    alias restart_bluetooth="sudo systemctl restart bluetooth"
    alias airpods='echo "connect  38:EC:0D:87:88:D6" | bluetoothctl'
    alias sony='echo "connect  38:18:4C:D3:2C:F0" | bluetoothctl'

    # mpv
    alias mpv='devour.sh mpv'
end
