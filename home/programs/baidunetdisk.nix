{ pkgs, ... }:

{
  home.packages = [ (pkgs.callPackage ../../pkgs/baidunetdisk/package.nix { inherit pkgs; }) ];
}
