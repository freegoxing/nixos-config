{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;

    package = pkgs.lutris.override {
      buildFHSEnv =
        args:
        pkgs.buildFHSEnv (
          args
          // {
            # Non-NixOS hosts may lack /etc/zoneinfo, which UMU's nested
            # Steam runtime requires as a bind-mount source.
            extraBwrapArgs = (args.extraBwrapArgs or [ ]) ++ [
              "--ro-bind ${pkgs.tzdata}/share/zoneinfo /etc/zoneinfo"
            ];
            profile = (args.profile or "") + ''
              export TZDIR="${pkgs.tzdata}/share/zoneinfo"
            '';
          }
        );
    };

    extraPackages = with pkgs; [
      winetricks
      mangohud
      gamemode
      umu-launcher
      tzdata

      vulkan-tools
      procps
    ];

    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
  };
}
