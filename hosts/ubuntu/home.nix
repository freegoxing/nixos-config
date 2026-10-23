{ pkgs, ... }:

{
  imports = [ ../../home/programs/packages.nix ];

  home.username = "free";
  home.homeDirectory = "/home/free";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nodejs
    pnpm
    uv
  ];
}
