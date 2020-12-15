{ pkgs, ... }:

{
  #######
  # Git #
  #######
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable

  programs.git.enable = true;

  programs.git.package = pkgs.buildEnv {
    name = "myGitEnv";
    paths = with pkgs.gitAndTools; [
      git
      delta # better diff presentation
      gh # GitHub CLI tool
      hub # wrapper that augments git
    ];
  };

  programs.git.extraConfig = {
    core.editor = "${pkgs.neovim-remote}/bin/nvr --remote-wait-silent -cc split";
    diff.colorMoved = "default";
    pull.rebase = true;
  };
  programs.git.userEmail = "doueng09@gmail.com";
  programs.git.userName = "Douglas Engstrand";

  # Enhaced diffs
  programs.git.delta.enable = true;

  ##############
  # GitHub CLI #
  ##############
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable

  programs.gh.enable = true;

  programs.gh.gitProtocol = "ssh";
}
