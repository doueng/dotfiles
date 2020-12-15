{ config, ... }:

{
  system.activationScripts.extraUserActivation.text =
    config.system.activationScripts.brew-bundle.text;

  programs.brew-bundle.enable = true;
  programs.brew-bundle.autoUpdate = true;
  programs.brew-bundle.cleanup = "zap";

  programs.brew-bundle.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];

  programs.brew-bundle.casks = [
    "google-chrome"
    "google-drive-file-stream"
    "gpg-suite"
    "hammerspoon"
    "keybase"
    "launchbar"
    "linear-linear"
    "protonvpn"
    "steam"
    "transmit"
    "typinator"
    "vlc"
  ];
}
