{ ... }:
{
  imports = [
    ./boot.nix ./desktop.nix ./locale.nix ./fonts.nix
    ./networking.nix ./nix.nix ./packages.nix
    ./programs.nix ./services.nix
    ./state.nix ./users.nix
  ];
}
