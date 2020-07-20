# add dir to ~/.last_dir
function lastdir ()
{
    if [ -n "$1" ]; then
        echo "$1" > ~/.last_dir
    else
        echo $PWD > ~/.last_dir
    fi
}
# swap two filenames
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

nuke_node_modules() {
  find . -name node_modules -type d -prune -exec rm -rf '{}' +
}

# leetcode download
lcd() {
	lc show $1 >> $(lc show $1 -g -l python | ag "Source Code" | awk '{print $4}')
}

compress() {
	tar -czvf $1.tar.gz $1
}

extract() {
  if [ -f "$1" ]; then
	case "$1" in
	  *.tar.bz2)  tar -jxvf "$1"                        ;;
	  *.tar.gz)   tar -zxvf "$1"                        ;;
	  *.bz2)      bunzip2 "$1"                          ;;
	  *.dmg)      hdiutil mount "$1"                    ;;
	  *.gz)       gunzip "$1"                           ;;
	  *.tar)      tar -xvf "$1"                         ;;
	  *.tbz2)     tar -jxvf "$1"                        ;;
	  *.tgz)      tar -zxvf "$1"                        ;;
	  *.zip)      unzip "$1"                            ;;
	  *.ZIP)      unzip "$1"                            ;;
	  *.pax)      pax -r < "$1"                         ;;
	  *.pax.Z)    uncompress "$1" --stdout | pax -r     ;;
	  *.Z)        uncompress "$1"                       ;;
	  *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
	esac
  else
	echo "'$1' is not a valid file"
  fi
}

mk() {
	mkdir -p -- "$1" || return
	cd -- "$1"
}

speedtestzsh() {
	for i in $(seq 1 10)
	do
		time zsh -i -c exit
	done
}

hex() {
	printf "%x\n" $1
}

int() {
	printf "%d\n" $1
}

# needs zsh
bin() {
	echo $(([##2] $1 ))
}

# restart shell
rz() {
	exec $SHELL
	source ~/.zprofile
}

le() {
   "$@" | less
}

# doom emacs
updatedoom() {
	pkill emacs;
	for cmd in upgrade update;
		do ~/.emacs.d/bin/doom -y $cmd;
	done
	emacs --bg-daemon;
}

recompiledoom() {
	pkill emacs;
	~/.emacs.d/bin/doom -y recompile;
	emacs --bg-daemon;
}

dgcl() {
	gcl "git@github.com:doueng/$1.git"
}

# Go to marked directory
# Arabesque
gm() {
	# Refuse to deal with unwanted arguments
	if [ "$#" -gt 0 ] ; then
		printf >&2 'gd(): Unspecified argument\n'
		return 2
	fi

	# Complain if mark not actually set yet
	if [ -z "$PMD" ] ; then
		printf >&2 'gd(): Mark not set\n'
		return 1
	fi

	# Go to the marked directory
	# shellcheck disable=SC2164
	cd -- "$PMD"
}

# Set marked directory to given dir or current dir
# Arabesque
sm() {
	# Accept up to one argument
	if [ "$#" -gt 1 ] ; then
		printf >&2 'md(): Too many arguments\n'
		return 2
	fi

	# If argument given, change to it in subshell to get absolute path.
	# If not, use current working directory.
	if [ -n "$1" ] ; then
		set -- "$(cd -- "$1" && printf '%s/' "$PWD")"
		set -- "${1%%/}"
	else
		set -- "$PWD"
	fi

	# If that turned up empty, we have failed; the cd call probably threw an
	# error for us too
	[ -n "$1" ] || return

	# Save the specified path in the marked directory var
	# shellcheck disable=SC2034
	PMD=$1
}

# Print the marked directory
# Arabesque
pm() {
	if [ -z "$PMD" ] ; then
		printf >&2 'pmd(): Mark not set\n'
		return 1
	fi
	printf '%s\n' "$PMD"
}

# If the argument is a directory, change to it.  If it's a file, change to its
# parent.  Stands for "get to".
# Arabesque
gt() {
	# Check argument count
	if [ "$#" -ne 1 ] ; then
		printf >&2 'gt(): Need one argument\n'
		return 2
	fi

	# Make certain there are no trailing slashes to foul us up, and anchor path
	# if relative
	while : ; do
		case $1 in
			*/) set -- "${1%/}" ;;
			/*) break ;;
			*) set -- "$PWD"/"$1" ;;
		esac
	done

	# If target isn't a directory, chop to its parent
	if ! [ -d "$1" ] ; then
		set -- "${1%/*}"
	fi

	# Try to change into the determined directory, or root if empty
	# shellcheck disable=SC2164
	cd -- "${1:-/}"
}

new_priv_repo () {
	if [ "$#" -ne 1 ] ; then
		printf >&2 "Need one argument\n"
		return 2
	fi
	curl -H "Authorization: token `cat ~/.sec/github.sec`" --data "{\"name\":\"$1\", \"private\": true}" https://api.github.com/user/repos
	mk "$1"
	git init
	echo '.o' > .gitignore
	git add .gitignore
	git commit -m "first commit"
	git remote add origin git@github.com:doueng/"$1".git
	git push -u origin master
}

# Usage: run "gopathmode on|off" to reset the monorepo direnv to the desired mode.
function gopathmode () {
	USAGE="$0 [ on | off ]\n\tshows or sets MONOREPO_GOPATH_MODE"
	[ $# -lt 1 ] && {
		[ -n "$MONOREPO_GOPATH_MODE" ] \
		&& echo "MONOREPO_GOPATH_MODE is on." \
		|| echo "MONOREPO_GOPATH_MODE is off."
		return
	}
	[ $# -gt 1 ] && echo "$USAGE" && return
	[ "$1" != "on" ] && [ "$1" != "off" ] && {
		echo "$USAGE"
		return
	}

	if [[ "$MONOREPO_GOPATH_MODE" != "1" && "$1" == "on" ]] ; then
		export MONOREPO_GOPATH_MODE=1
		repo=$(git config --get remote.origin.url || true)
		if [[ $repo =~ ":go-code" ]]; then
			direnv reload
		fi
	elif [[ -n "$MONOREPO_GOPATH_MODE" && "$1" == "off" ]] ; then
		unset MONOREPO_GOPATH_MODE
		repo=$(git config --get remote.origin.url || true)
		if [[ $repo =~ ":go-code" ]]; then
			direnv reload
		fi
	fi
}

# Function to manage contents of PATH variable within the current shell
path() {

    # Check first argument to figure out operation
    case $1 in

        # List current directories in PATH
        list|'')
            set -- "$PATH":
            while [ -n "$1" ] ; do
                case $1 in
                    :*) ;;
                    *) printf '%s\n' "${1%%:*}" ;;
                esac
                set -- "${1#*:}"
            done
            ;;

        # Helper function checks directory argument makes sense
        _argcheck)
            shift
            if [ "$#" -gt 2 ] ; then
                printf >&2 'path(): %s: too many arguments\n' "$1"
                return 2
            fi
            case $2 in
                *:*)
                    printf >&2 'path(): %s: %s contains colon\n' "$@"
                    return 2
                    ;;
            esac
            return 0
            ;;

        # Add a directory at the start of $PATH
        insert)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if path check "$2" ; then
                printf >&2 'path(): %s: %s already in PATH\n' "$@"
                return 1
            fi
            PATH=${2}${PATH:+:"$PATH"}
            ;;

        # Add a directory to the end of $PATH
        append)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if path check "$2" ; then
                printf >&2 'path(): %s: %s already in PATH\n' "$@"
                return 1
            fi
            PATH=${PATH:+"$PATH":}${2}
            ;;

        # Remove a directory from $PATH
        remove)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if ! path check "$2" ; then
                printf >&2 'path(): %s: %s not in PATH\n' "$@"
                return 1
            fi
            PATH=$(
                path=:$PATH:
                path=${path%%:"$2":*}:${path#*:"$2":}
                path=${path#:}
                printf '%s:' "$path"
            )
            PATH=${PATH%%:}
            ;;

        # Remove the first directory in $PATH
        shift)
            case $PATH in
                '')
                    printf >&2 'path(): %s: PATH is empty!\n' "$@"
                    return 1
                    ;;
                *:*)
                    PATH=${PATH#*:}
                    ;;
                *)
                    # shellcheck disable=SC2123
                    PATH=
                    ;;
            esac
            ;;

        # Remove the last directory in $PATH
        pop)
            case $PATH in
                '')
                    printf >&2 'path(): %s: PATH is empty!\n' "$@"
                    return 1
                    ;;
                *:*)
                    PATH=${PATH%:*}
                    ;;
                *)
                    # shellcheck disable=SC2123
                    PATH=
                    ;;
            esac
            ;;

        # Check whether a directory is in PATH
        check)
            path _argcheck "$@" || return
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            case :$PATH: in
                *:"$2":*) return 0 ;;
            esac
            return 1
            ;;

        # Print help output (also done if command not found)
        help)
            cat <<'EOF'
path(): Manage contents of PATH variable

USAGE:
  path [list]
    Print the current directories in PATH, one per line (default command)
  path insert [DIR]
    Add directory DIR (default $PWD) to the front of PATH
  path append [DIR]
    Add directory DIR (default $PWD) to the end of PATH
  path remove [DIR]
    Remove directory DIR (default $PWD) from PATH
  path shift
    Remove the first directory from PATH
  path pop
    Remove the last directory from PATH
  path check [DIR]
    Return whether directory DIR (default $PWD) is a component of PATH
  path help
    Print this help message
EOF
            ;;

        # Command not found
        *)
            printf >&2 'path(): %s: Unknown command (try "help")\n' "$1"
            return 2
            ;;
    esac
}

pj() {
	pbpaste | jq "$@"
}

gds() {
	git diff "$@" | diffstat
}

c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

zz() {
	zshz | fzf | sed 's/^[^ ]* //'
}

unalias z
z() {
	cd $(zshz -e "$@")
}
#!/bin/bash
#
# A collection of bash snippets and functions.
#

##########
# Arrays #
##########

#
# ### Array contains
#
# The only proper way to do this is by looping through each item. Other
# solutions claim to do this using string matching, but they are often
# dangerous because don't handle edge cases.
#

#
# Returns 0 if item is in the array; 1 otherwise.
#
# $1: The array value to search for
# $@: The array values, e.g. "${myarray[@]}"
#
array_contains() {
    local item=$1; shift
    for val in "$@"; do
        if [ "$val" == "$item" ]; then
            return 0
        fi
    done
    return 1
}

# ### Array filter

#
# Return all elements of an array with the specified item removed.
#
# $1: The array value to remove
# $@: The array values, e.g. "${myarray[@]}"
#
array_filter() {
    local item=$1; shift
    for val in "$@"; do
        if [ "$val" != "$item" ]; then
            echo $val
        fi
    done
}

# ### Array join

#
# Join array elements with a string.
#
# $1: String separator
# $@: Array elements
#
array_join() {
    local sep=$1; shift
    IFS=$sep eval 'echo "$*"'
}

################
# Benchmarking #
################

# ### Time a command

#
# Time the number of seconds it takes to run a command; store the value in a
# variable with the specified name.
#
timer() {
    local var_name=$1; shift

    local end
    local -i ret=0
    local start
    local total

    start=$(date +%s)
    "$@" || ret=$?
    end=$(date +%s)

    total=$((end - start))

    # Store the value
    eval "${var_name}=${total}"

    return $ret
}

#################
# Path handling #
#################

#
# ### Resolve absolute path
#
# There are several snippets of code on the internet to resolve the absolute
# path, but most of them have issues. This function works on files, directories
# and handles "." and "..".
#

#
# Print the absolute path of the target path. Note that the path must be a
# real path to a file or directory or else this will fail.
#
# $1: the target file or directory
#
absolute_path() {
    local path=$1

    if [ "$path" == "." ]; then
        echo "$(pwd)"
    elif [ "$path" == ".." ]; then
        echo "$(dirname "$(pwd)")"
    else
        path="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
        # Replace double slashes, happens when we're operating at the root
        echo "${path/\/\///}"
    fi
}

#
# ### Recursively resolve symlinks
#
# This does what `realpath` from coreutils does but works without it. Requires
# readlink instead.
#

#
# Recursively resolve all symlinks at the specified path and then print the
# final, absolute path.
#
# $1: the path to resolve
#
resolve_symlinks() {
    (
        local path=$1

        while [ -L "$path" ]; do
            dir="$(dirname "$(absolute_path "$path")")"
            cd "$dir"
            path=$(readlink "$path")
        done

        echo "$(absolute_path "$path")"
    )
}

####################
# Process handling #
####################

# ### Clean up child processes on exit

#
# ```
# trap "exit" INT TERM
# trap "kill 0" EXIT
# ```
#

#
# Notes:
#
# * Doing the kill on exit means children will be cleaned up even during normal
#   exit too.
# * Binding INT/TERM to `exit` avoids an infinite loop in signal handling.
# * `kill 0` (with `0` as the PID) sends a TERM to the entire process group.
#

# ### Get PID of a subshell

#
# **Bash3:**
#
# ```
# (sh -c 'echo $PPID' && :)
# ```

#
# Notes:
#
# * Two statements are required to actually create the subshell
# * The second statement is essentially a "no-op"

#
# **Bash4:**
#
# ```
# echo $BASHPID
# ```

# ### Run commands in parallel

#
# This provides the ability to run commands in parallel with a predefined
# number of threads.
#
# People tend to use GNU `parallel` for this, however, implementing this as a
# shell function has the following advantages:
#
# * It is portable (doesn't require `parallel` to be installed).
# * You can run shell functions as commands, whereas external programs require
#   the commands to be standalone binaries.

#
# Run commands in parallel.
#
parallel() {
    local max_threads=$1
    local -a pids=()
    local ret=0

    # Set up named pipe to communicate between procs
    fifo="$(mktemp)" && rm -f "$fifo"
    mkfifo -m 0700 "$fifo"

    # Open pipe as fd 3
    exec 3<>$fifo
    rm -f $fifo # Clean up pipe from filesystem; it stays open, however

    local running=0
    while read cmd; do
        # Block, when at max_threads
        while ((running >= max_threads)); do
            if read -u 3 cpid ; then
                wait $cpid || true
                ((--running))
            fi
        done

        # Spawn child proc
        ($cmd; sh -c 'echo $PPID 1>&3' && :) &
        pids+=($!)

        ((++running))
    done

    # Return 1 if one or more pids returned a nonzero code
    for pid in "${pids[@]}"; do
        wait "$pid" || ret=1
    done

    return $ret
}

#
# Notes:
#
# * Provide the commands as an input to this function
#

# ### Wait for background processes to exit

#
# ```
# wait [PID [...]]
# ```
#
# Notes:
#
# * If you use `wait` without specifying a PID, bash will wait for *all*
#   background processes.
# * If you want to catch the return code of the background process, you
#   **must** specify the PID.
# * If you specify multiple PIDs, the return code of `wait` will be the return
#   code of the *last* PID specified.
#

###########
# Testing #
###########

# ### List all test functions

#
# Outputs the name of all functions starting with `test_`.
#
# ```
# $(compgen -A function | grep -E ^test_)
# ```

# ### Run test functions

#
# Runs the specified test functions and outputs the result. If a test fails,
# it outputs a trace of the test to stderr.
#

#
# Run specified tests.
#
tests() {
    local ret=0
    local test_log="/tmp/${0##*/}.test.log"

    for test in "$@"; do
        :>"$test_log"

        echo -n "$test: "
        if (set -x; $test) 2>"$test_log"; then
            echo "OK"
        else
            echo "FAILED"
            ret=1

            {
                echo
                echo "Trace:"

                echo -e "\033[33m"
                cat "$test_log"
                echo -e "\033[0m"
            } >&2
        fi
    done

    return $ret
}

########
# Time #
########

# ### Human-readable time output

#
# Given seconds, outputs something like "2m 5s".
#

#
# Output human readable duration, given seconds as an input.
#
prettify_time() {
    local time_secs=$1

    local mins
    local secs

    mins=$(($time_secs / 60))
    secs=$(($time_secs % 60))

    if [ $mins -gt 0 ]; then
        echo -n "${mins}m "
    fi

    echo "${secs}s"
}

#############
# Utilities #
#############

# ### Check a required program is installed

#
# $@: list of programs to check for
#
require() {
    local ret=0

    for bin in "$@"; do
        if ! which "$bin" &>/dev/null; then
            echo "ERROR: Missing required dependency: ${bin}" >&2
            ret=1
        fi
    done

    return $ret
}

venv38() {
 [ -z "$VIRTUAL_ENV" ] || deactivate
 [ -e .venv38 ] ||
 python3.8 -m venv --prompt "`basename "$PWD"`" .venv38
 ACTIVATE='.venv38/bin/activate'
 [ -e "$ACTIVATE" ] && . "$ACTIVATE" && pip install --upgrade setuptools || echo "File not found: $ACTIVATE" >&2
}

venv27() {
 [ -z "$VIRTUAL_ENV" ] || deactivate
 [ -e .venv27 ] ||
 virtualenv --prompt "(`basename "$PWD"`)" .venv27
 ACTIVATE='.venv27/bin/activate'
 [ -e "$ACTIVATE" ] && . "$ACTIVATE" || echo "File not found : $ACTIVATE" >&2
}

vifd() {
  vi `fd "$@"`
}
# Function to manage contents of PATH variable within the current shell
path() {

    # Check first argument to figure out operation
    case $1 in

        # List current directories in PATH
        list|'')
            set -- "$PATH":
            while [ -n "$1" ] ; do
                case $1 in
                    :*) ;;
                    *) printf '%s\n' "${1%%:*}" ;;
                esac
                set -- "${1#*:}"
            done
            ;;

        # Helper function checks directory argument makes sense
        _argcheck)
            shift
            if [ "$#" -gt 2 ] ; then
                printf >&2 'path(): %s: too many arguments\n' "$1"
                return 2
            fi
            case $2 in
                *:*)
                    printf >&2 'path(): %s: %s contains colon\n' "$@"
                    return 2
                    ;;
            esac
            return 0
            ;;

        # Add a directory at the start of $PATH
        insert)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if path check "$2" ; then
                printf >&2 'path(): %s: %s already in PATH\n' "$@"
                return 1
            fi
            PATH=${2}${PATH:+:"$PATH"}
            ;;

        # Add a directory to the end of $PATH
        append)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if path check "$2" ; then
                printf >&2 'path(): %s: %s already in PATH\n' "$@"
                return 1
            fi
            PATH=${PATH:+"$PATH":}${2}
            ;;

        # Remove a directory from $PATH
        remove)
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            path _argcheck "$@" || return
            if ! path check "$2" ; then
                printf >&2 'path(): %s: %s not in PATH\n' "$@"
                return 1
            fi
            PATH=$(
                path=:$PATH:
                path=${path%%:"$2":*}:${path#*:"$2":}
                path=${path#:}
                printf '%s:' "$path"
            )
            PATH=${PATH%%:}
            ;;

        # Remove the first directory in $PATH
        shift)
            case $PATH in
                '')
                    printf >&2 'path(): %s: PATH is empty!\n' "$@"
                    return 1
                    ;;
                *:*)
                    PATH=${PATH#*:}
                    ;;
                *)
                    # shellcheck disable=SC2123
                    PATH=
                    ;;
            esac
            ;;

        # Remove the last directory in $PATH
        pop)
            case $PATH in
                '')
                    printf >&2 'path(): %s: PATH is empty!\n' "$@"
                    return 1
                    ;;
                *:*)
                    PATH=${PATH%:*}
                    ;;
                *)
                    # shellcheck disable=SC2123
                    PATH=
                    ;;
            esac
            ;;

        # Check whether a directory is in PATH
        check)
            path _argcheck "$@" || return
            if ! [ "$#" -eq 2 ] ; then
                set -- "$1" "$PWD"
            fi
            case :$PATH: in
                *:"$2":*) return 0 ;;
            esac
            return 1
            ;;

        # Print help output (also done if command not found)
        help)
            cat <<'EOF'
path(): Manage contents of PATH variable

USAGE:
  path [list]
    Print the current directories in PATH, one per line (default command)
  path insert [DIR]
    Add directory DIR (default $PWD) to the front of PATH
  path append [DIR]
    Add directory DIR (default $PWD) to the end of PATH
  path remove [DIR]
    Remove directory DIR (default $PWD) from PATH
  path shift
    Remove the first directory from PATH
  path pop
    Remove the last directory from PATH
  path check [DIR]
    Return whether directory DIR (default $PWD) is a component of PATH
  path help
    Print this help message
EOF
            ;;

        # Command not found
        *)
            printf >&2 'path(): %s: Unknown command (try "help")\n' "$1"
            return 2
            ;;
    esac
}
