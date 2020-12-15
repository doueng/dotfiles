{ pkgs, ... }:

let
  sources = import ../nix/sources.nix;
in
{

  programs.neovim.enable = true;

  # Source config from out of nix store so that it's easy to edit on the fly
  programs.neovim.extraConfig = ''
    source ./nvim/init.vim
  '';

  # Plugins
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # UI plugins
    airline
    NeoSolarized
    vim-airline-themes
    vim-clap
    vim-choosewin
    vim-devicons
    vim-floaterm
    vim-startify
    zoomwintab-vim

    # Coc.nvim plugins
    coc-nvim
    coc-eslint
    coc-git
    coc-json
    coc-lists
    coc-markdownlint
    coc-python
    coc-snippets
    coc-tabnine
    coc-tsserver
    coc-vimlsp
    coc-yaml
    coc-yank

    # other plugins
    ale
    direnv-vim
    editorconfig-vim
    goyo-vim
    tabular
    vim-commentary
    vim-eunuch
    vim-fugitive
    vim-pencil
    vim-polyglot
    vim-surround

    vim-easymotion
    auto-pairs

  ];

  # Add `nvr` command to environment
  home.packages = [
    pkgs.neovim-remote
  ];
}
