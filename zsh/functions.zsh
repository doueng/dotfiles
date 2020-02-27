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
	paste | jq "$@"
}
