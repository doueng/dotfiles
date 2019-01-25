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

function mk () {
	mkdir $1 && cd $1
}

function speedtestzsh () {
	for i in $(seq 1 10)
	do
		time zsh -i -c exit
	done
}

function hex () {
    printf "%x\n" $1
}

function int () {
    printf "%d\n" $1
}

# needs zsh
function bin () {
    echo $(([##2] $1 ))
}

# restart shell
function rz () {
    exec $SHELL
    source ~/.zprofile
}

# doom emacs
function updatedoom () {
    pkill emacs;
    for cmd in upgrade update compile;
        do ~/.emacs.d/bin/doom -y $cmd;
    done
    emacs --bg-daemon;
}

function dgcl () {
    gcl "https://github.com/doueng/$1.git"
}
