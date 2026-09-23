{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ neovim wget curl git gcc ];
  environment.variables.EDITOR = "neovim";
}
