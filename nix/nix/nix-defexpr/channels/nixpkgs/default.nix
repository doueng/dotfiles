let
  sources = import ~/dotfiles/nix/nix/sources.nix;
  pkgs    = import sources.nixpkgs-unstable {};
in
  if pkgs.stdenv.isDarwin then
    import sources.nixpkgs-unstable
  else
    import sources.nixos-unstable
