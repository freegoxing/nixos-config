{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      mangohud
      gamemode
      umu-launcher
    ];

    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
  };
}
