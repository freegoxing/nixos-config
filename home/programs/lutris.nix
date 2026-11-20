{ pkgs, ... }:

let
  lutrisPkgs = pkgs.extend (
    _final: prev: {
      gamemode = prev.gamemode.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          # UMU's Steam runtime can replace LD_LIBRARY_PATH before launching games.
          patchelf --add-rpath "$lib/lib" "$(readlink -f "$lib/lib/libgamemodeauto.so.0")"
        '';
      });
    }
  );
in
{
  programs.lutris = {
    enable = true;

    package = lutrisPkgs.lutris.override {
      buildFHSEnv =
        args:
        lutrisPkgs.buildFHSEnv (
          args
          // {
            # Make the GameMode client available to both 32-bit and 64-bit games.
            multiPkgs = runtimePkgs: args.multiPkgs runtimePkgs ++ [ runtimePkgs.gamemode.lib ];

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
      lutrisPkgs.gamemode
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
