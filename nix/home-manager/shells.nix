{ pkgs, ... }:

{

  ##############
  # Fish shell #
  ##############
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.enable

  programs.fish.enable = true;

  # config.fish
  programs.fish.interactiveShellInit = builtins.readFile "/Users/engstrand/dotfiles/nix/home-manager/fish/config.fish";
}
