function nextd-or-complete --description 'Move forward in the directory history or if the cmd line is not empty execute complete'
    set -l cmd (commandline)
    if test -z "$cmd"
        de_nextd
        commandline -f repaint
    else
        commandline -f complete
    end
end
