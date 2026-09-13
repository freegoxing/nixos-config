{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ vim wget curl git ];
  environment.variables.EDITOR = "vim";
}
