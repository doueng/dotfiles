{ pkgs, lib, ... }:

{
  # Import config broken out into files
  imports = [
    ./git.nix
    ./neovim.nix
    ./shells.nix
  ] ++ lib.filter lib.pathExists [ ./private.nix ];

  ###########################
  # Configure misc packages #
  ###########################

  # Bat, a substitute for cat
  # https://github.com/sharkdp/bat
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Direnv, load and unload environment variables depending on the current directory
  # https://direnv.net
  programs.direnv.enable = true;

  # Kitty terminal
  # Configuration options defined in overlays: `../overlays/kitty-configs.nix`
  programs.kitty.enable = true;
  programs.kitty.settings = pkgs.my-kitty-config;
  xdg.configFile."kitty/macos-launch-services-cmdline".text = "--listen-on unix:/tmp/mykitty";

  # Htop
  programs.htop.enable = true;
  programs.htop.showProgramPath = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  programs.zoxide.enable = true;

  #######################
  # Additional packages #
  #######################

  home.packages = with pkgs; [
    # Some basics
    bandwhich # display current network utilization by process
    bottom # fancy version of `top` with ASCII graphs
    coreutils
    curl
    du-dust # fancy version of `du`
    exa # fancy version of `ls`
    fd # fancy version of `find`
    htop # fancy version of `top`
    hyperfine # benchmarking tool
    mosh # wrapper for `ssh` that better and not dropping connections
    parallel # runs commands in parallel
    procs # fancy version of `ps`
    ripgrep # better version of grep
    thefuck # suggests fixes to commands that exit with a non-zero status
    tealdeer # rust implementation of `tldr`
    unrar # extract RAR archives
    wget
    xz # extract XZ archives

    # General dev stuff
    ccls
    jq
    rnix-lsp
    s3cmd
    watchman
    tree
    git
    fzf

    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    lorri # improve `nix-shell` experience in combination with `direnv`
    niv # easy dependency management for nix projects

    # My custom nix related shell scripts
    myenv-script
  ];

  # This value determines the Home Manager release that your configuration is compatible with. This
  # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You can update Home Manager without changing this value. See the Home Manager release notes for
  # a list of state version changes in each release.
  home.stateVersion = "21.03";
}
