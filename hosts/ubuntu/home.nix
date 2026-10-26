{ pkgs, ... }:

{
  imports = [
    ../../home/packages.nix
    ../../home/programs/kitty.nix
    ../../home/programs/lutris.nix
    ../../home/programs/jujutsu.nix
    ../../home/programs/nvim.nix
    ../../home/programs/zed.nix
    ../../home/programs/texlive.nix
  ];

  home.username = "free";
  home.homeDirectory = "/home/free";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;

}
