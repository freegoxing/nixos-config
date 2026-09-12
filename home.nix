{ config, pkgs, ...}:

{
  home.username = "kvm";
  home.homeDirectory = "/home/kvm";

  home.stateVersion = "26.05";

  home.packages = with pkgs;[
    fastfetch
    which
    eza
    nix-output-monitor
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "free";
    userEmail = "mpdf2023@outlook.com";
    
    settings = {
      init.defaultBranch = "master";
    };
  };

  programs.ssh = {
    enable = true;
   
    addKeysToAgent = "yes";
 
    matchBlocks = {
      github = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_25519_github";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];

      theme = "robbyrussell";
    };

    shellAliases = {
      ls = "eza --icons -l";
      la = "eza --icons -al";
      tree = "eza --icons -T";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#vm";
      q = "exit";
      ff = "fastfetch";
    };
  };
}
