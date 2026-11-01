{ ... }:
{
  programs.zsh.shellAliases = {
    ls = "eza --icons -l";
    la = "eza --icons -al";
    tree = "eza --icons -T";
    vi = "nvim";
    q = "exit";
    home = "cd ~";
    cls = "clear";
    clc = "clear";
    ff = "fastfetch";
    ifconfig = "ip a";
    j = "z";
  };
}
