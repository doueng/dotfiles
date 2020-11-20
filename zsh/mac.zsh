export PATH="/usr/local/Cellar/qemu/5.0.0_2/bin:$PATH"
alias ls="ls -G"
alias copy="pbcopy"
alias paste="pbpaste"
alias bm="bear gmake -j"

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

