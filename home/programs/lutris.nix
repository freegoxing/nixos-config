{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      mangohud
      gamemode
      umu-launcher

      vulkan-tools
      procps
    ];

    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
  };
}
