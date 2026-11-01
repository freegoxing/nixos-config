{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Keep the generated rc at ~/.zshrc on both Linux hosts.
    dotDir = config.home.homeDirectory;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "extract"
      ];
      theme = "";
      extraConfig = ''
        ENABLE_CORRECTION="true"
        COMPLETION_WAITING_DOTS="true"
        DISABLE_UNTRACKED_FILES_DIRTY="true"
      '';
    };

    initContent = lib.mkBefore ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      if [[ -d "$HOME/.nix-profile/share/zsh/site-functions" ]]; then
        fpath=("$HOME/.nix-profile/share/zsh/site-functions" $fpath)
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
    '';
  };
}
