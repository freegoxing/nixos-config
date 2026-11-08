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
        "colored-man-pages"
        "aliases"
      ];
      theme = "";
      extraConfig = ''
        ENABLE_CORRECTION="true"
        COMPLETION_WAITING_DOTS="true"
        DISABLE_UNTRACKED_FILES_DIRTY="true"
      '';
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')

      (lib.mkOrder 550 ''
        if [[ -d "$HOME/.nix-profile/share/zsh/site-functions" ]]; then
          fpath=("$HOME/.nix-profile/share/zsh/site-functions" $fpath)
        fi
      '')

      (lib.mkOrder 1100 ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
      '')
    ];

  };
}
