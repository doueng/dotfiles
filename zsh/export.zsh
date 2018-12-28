
# add rtags path
export PATH="$PATH:/Users/Admin/.emacs.d/.local/etc/rtags/rtags-2.20/bin"

# change language to english
export LANG="en_US.UTF-8"

# editor
export EDITOR=nvim
export VISUAL=nvim
export VIMRC=~/.config/nvim/init.vim

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Customize to your needs...
export KEYTIMEOUT=1

# fix man page wrapping
export MANWIDTH=60

# -S disable line wrapping
# -R displays ANSI color escape sequences in "raw" form
export LESS='-S -R'

# homebrew
HOMEBREW_NO_AUTO_UPDATE=1
