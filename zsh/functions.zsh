# swap two filenames
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}
#Homebrew
brewbump() {
  echo -e "\\nUpdating Homebrew...\\n"
  brew update
  echo -e "\\nUpgrading Homebrew...\\n"
  brew upgrade
  echo -e "\\nBrew cask upgrade\\n"
  brew cask upgrade
  echo -e "\\nCleaning your mess...\\n"
  brew cleanup
  brew prune
  echo -e "\\nDone.\\n"
}

brewlist() {
  tr "  " '\n' <<< "$(brew list)"
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
	for cmd in upgrade update compile;
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
	gcl "https://github.com/doueng/$1.git"
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
