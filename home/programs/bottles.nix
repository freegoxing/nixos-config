{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ../../overlays/bottles.nix)
  ];

  home.packages = [
    (pkgs.bottles.override {
      removeWarningPopup = true;

      extraPkgs =
        pkgs': with pkgs'; [
          nautilus
        ];
    })
  ];
}
