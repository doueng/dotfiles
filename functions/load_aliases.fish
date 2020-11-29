function load_aliases
    # Wifi
    alias internet='nmcli con up id Javaplein'

    # cd
    alias ...='../..'
    alias dc='cd'
    alias cdd='cd $HOME/Downloads'

    # Get week number
    alias week='date +%V'

    # ls
    alias ls='ls -G'
    alias sl='ls'
    alias ll='ls -lh'
    alias l='ll'
    alias la='ls -a'
    alias lla='l -a'

    # vim
    alias vi=nvim

    # dotfiles
    alias vf='vi $HOME/.config/fish/config.fish'

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
    alias gs='git status'
    alias gr='git restore'
    alias gch='git checkout'
    alias gch-='git checkout -'
    alias gchm='git checkout master'
    alias gdm='git diff master'

    # chmod
    alias exe='chmod 755'

    # leetcode
    alias lc='leetcode'
    alias lcl='leetcode list'
    alias lcs='leetcode submit'

    # which
    alias wa='which -a'

    # python
    alias new_venv='python3 -m venv'

    # tree
    alias tree='tree -I node_modules'

    # mpv
    alias mpv='devour.sh mpv'
end
