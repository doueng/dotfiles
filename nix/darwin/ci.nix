{ config, pkgs, lib, ... }:

{
  imports = [ ./configuration.nix ];

  environment.darwinConfig = lib.mkForce "$HOME/dotfiles/nix/darwin/ci.nix";

  users.users = lib.mkForce {
    runner.home = "/Users/runner";
  };

  home-manager.users = lib.mkForce {
    runner = import ../home-manager/configuration.nix;
  };

  programs.brew-bundle.cleanupType = lib.mkForce "none";
  programs.brew-bundle.masApps = lib.mkForce {};
}
