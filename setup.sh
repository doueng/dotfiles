#!/usr/bash

dotfiles = "$HOME/dotfiles/"
config = "$HOME/config"
mkdir -p "$HOME/.config/nvim"
cp -rf "$dotfiles/init.vim" "$config/nvim/init.vim"

link-to-config() {
    ln -sf "$dotfiles/$1" "$config/$1"
}

link-to-config fish
lint-to-config kitty
