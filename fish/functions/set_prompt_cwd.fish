function set_prompt_cwd
    if git rev-parse --is-inside-work-tree &> /dev/null
        set -l toplevel (git rev-parse --show-toplevel)
        set -l base (basename $toplevel)
        set -l git_cwd (pwd | string replace $toplevel '')
        set -g PROMPT_CWD (echo -n "$base$git_cwd")
    else
        set -g PROMPT_CWD (pwd | string replace "$HOME" '~')
    end
end
