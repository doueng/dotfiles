# Default appearance options. Override in config.fish if you want.
if ! set -q lucid_dirty_indicator
    set -g lucid_dirty_indicator "•"
end

if ! set -q lucid_prompt_symbol
    set -g lucid_prompt_symbol "❯"
end

# This should be set to be at least as long as lucid_dirty_indicator, due to a fish bug
if ! set -q lucid_clean_indicator
    set -g lucid_clean_indicator (string replace -r -a '.' ' ' $lucid_dirty_indicator)
end

if ! set -q lucid_cwd_color
    set -g lucid_cwd_color green
end

if ! set -q lucid_git_color
    set -g lucid_git_color blue
end

# State used for memoization and async calls.
set -g __lucid_cmd_id 0
set -g __lucid_git_state_cmd_id -1
set -g __lucid_git_static ""
set -g __lucid_dirty ""

# Increment a counter each time a prompt is about to be displayed.
# Enables us to distingish between redraw requests and new prompts.
function __lucid_increment_cmd_id --on-event fish_prompt
    set __lucid_cmd_id (math $__lucid_cmd_id + 1)
end

# Abort an in-flight dirty check, if any.
function __lucid_abort_check
    if set -q __lucid_check_pid
        set -l pid $__lucid_check_pid
        functions -e __lucid_on_finish_$pid
        kill $pid >/dev/null 2>&1
        set -e __lucid_check_pid
    end
end

function __lucid_git_status
    # Reset state if this call is *not* due to a redraw request
    set -l prev_dirty $__lucid_dirty
    if test $__lucid_cmd_id -ne $__lucid_git_state_cmd_id
        __lucid_abort_check

        set __lucid_git_state_cmd_id $__lucid_cmd_id
        set __lucid_git_static ""
        set __lucid_dirty ""
    end

    # Fetch git position & action synchronously.
    # Memoize results to avoid recomputation on subsequent redraws.
    if test -z $__lucid_git_static
        # Determine git working directory
        set -l git_dir (git --no-optional-locks rev-parse --absolute-git-dir 2>/dev/null)
        if test $status -ne 0
            return 1
        end

        set -l position (git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
        if test $status -ne 0
            # Denote detached HEAD state with short commit hash
            set position (git --no-optional-locks rev-parse --short HEAD 2>/dev/null)
            if test $status -eq 0
                set position "@$position"
            end
        end

        # TODO: add bisect
        set -l action ""
        if test -f "$git_dir/MERGE_HEAD"
            set action "merge"
        else if test -d "$git_dir/rebase-merge"
            set branch "rebase"
        else if test -d "$git_dir/rebase-apply"
            set branch "rebase"
        end

        set -l state $position
        if test -n $action
            set state "$state <$action>"
        end

        set -g __lucid_git_static $state
    end

    # Fetch dirty status asynchronously.
    if test -z $__lucid_dirty
        if ! set -q __lucid_check_pid
            # Compose shell command to run in background
            set -l check_cmd "git --no-optional-locks status -unormal --porcelain --ignore-submodules 2>/dev/null | head -n1 | count"
            set -l cmd "if test ($check_cmd) != "0"; exit 1; else; exit 0; end"

            begin
                # Defer execution of event handlers by fish for the remainder of lexical scope.
                # This is to prevent a race between the child process exiting before we can get set up.
                block -l

                set -g __lucid_check_pid 0
                command fish --private --command "$cmd" &> /dev/null &
                set -l pid (jobs --last --pid)

                set -g __lucid_check_pid $pid

                # Use exit code to convey dirty status to parent process.
                function __lucid_on_finish_$pid --inherit-variable pid --on-process-exit $pid
                    functions -e __lucid_on_finish_$pid

                    if set -q __lucid_check_pid
                        if test $pid -eq $__lucid_check_pid
                            switch $argv[3]
                                case 0
                                    set -g __lucid_dirty_state 0
                                    if status is-interactive
                                        commandline -f repaint
                                    end
                                case 1
                                    set -g __lucid_dirty_state 1
                                    if status is-interactive
                                        commandline -f repaint
                                    end
                                case '*'
                                    set -g __lucid_dirty_state 2
                                    if status is-interactive
                                        commandline -f repaint
                                    end
                            end
                        end
                    end
                end
            end
        end

        if set -q __lucid_dirty_state
            switch $__lucid_dirty_state
                case 0
                    set -g __lucid_dirty $lucid_clean_indicator
                case 1
                    set -g __lucid_dirty $lucid_dirty_indicator
                case 2
                    set -g __lucid_dirty "<err>"
            end

            set -e __lucid_check_pid
            set -e __lucid_dirty_state
        end
    end

    # Render git status. When in-progress, use previous state to reduce flicker.
    set_color $lucid_git_color
    echo -n $__lucid_git_static ''

    if ! test -z $__lucid_dirty
        echo -n $__lucid_dirty
    else if ! test -z $prev_dirty
        set_color --dim $lucid_git_color
        echo -n $prev_dirty
        set_color normal
    end

    set_color normal
end

# Suppress default mode prompt
function fish_mode_prompt
end

function fish_prompt
    set_color $lucid_cwd_color
    echo -sn "$PROMPT_CWD "
    set_color normal
end

function fish_right_prompt
    set -l cwd (pwd | string replace "$HOME" '~')

    set_color normal

    if test $cwd != '~'
        set -l git_state (__lucid_git_status)
        if test $status -eq 0
            echo -sn "$git_state"
        end
    end
end
