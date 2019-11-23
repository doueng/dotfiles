# add dir to ~/.last_dir
lastdir ()
{
	if [ -n "$1" ]; then
		echo "$1" > ~/.last_dir
	else
		echo "$PWD" > ~/.last_dir
	fi
}

# swap two filenames
swap()
{
	local TMPFILE=tmp.$$
	mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

mk() {
	mkdir -p -- "$1" || return
	cd -- "$1" || echo "cd failed"
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
