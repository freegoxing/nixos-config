{ lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "pycharm"
        "nvidia-x11"
        "wechat"
        "wpsoffice-cn"
        "geogebra"
        "google-chrome"
        "obsidian"
        "wemeet"
        "libwemeetwrap"
        "baidunetdisk"
        "lceda-pro"
        "qq"
        "nomachine-client"
        "bilibili"
      ];

    nvidia.acceptLicense = true;
  };

  imports = [
    ../../home/shell
    ./shell.nix
    ../../home/packages.nix
    ../../home/programs/kitty.nix
    ../../home/programs/lutris.nix
    ../../home/programs/jujutsu.nix
    ../../home/programs/nvim.nix
    ../../home/programs/zed.nix
    ../../home/programs/texlive.nix
    ../../home/programs/wechat.nix
    ../../home/programs/bottles.nix
    ../../home/programs/obs.nix
    ../../home/programs/baidunetdisk.nix
    ../../home/programs/lceda-pro.nix
    ../../home/programs/qq.nix
    ../../home/programs/direnv.nix
  ];

  home.username = "free";
  home.homeDirectory = "/home/free";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    jetbrains.pycharm
    wemeet

    (nomachine-client.overrideAttrs (_: {
      version = "10.2.3";

      src = fetchurl {
        url = "https://web9001.nomachine.com/download/10.2/Linux/nomachine-player_10.2.3_1_x86_64.tar.gz";
        hash = "sha256-JOg97ElcbLM6uc6DCAwfGnoytsEgY/BSFmmdIE4oC1o=";
      };
    }))

    iio-oscilloscope
    bilibili
    picgo
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
