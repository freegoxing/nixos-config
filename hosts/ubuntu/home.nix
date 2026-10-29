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
    ../../home/programs/wechat.nix
    ../../home/programs/bottles.nix
  ];

  home.username = "free";
  home.homeDirectory = "/home/free";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    jetbrains.pycharm
  ];

  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.99.02";
    sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
  };

  targets.genericLinux.nixGL.prime.installScript = "nvidia";
}
