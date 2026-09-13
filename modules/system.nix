{ ... }:
{
  imports = [
    ./system/boot.nix ./system/desktop.nix ./system/locale.nix
    ./system/networking.nix ./system/nix.nix ./system/packages.nix
    ./system/programs.nix ./system/services.nix
    ./system/state.nix ./system/users.nix
  ];
}
