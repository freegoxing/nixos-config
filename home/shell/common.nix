{ ... }:
{
  programs.zsh.shellAliases = {
    ls = "eza --icons -l";
    la = "eza --icons -al";
    tree = "eza --icons -T";
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#vm";
    q = "exit";
    ff = "fastfetch";
  };
}
