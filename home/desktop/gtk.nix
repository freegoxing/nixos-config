{ pkgs, ... }:
let
  gtk3Modules = pkgs.runCommand "gtk3-session-modules" { } ''
    mkdir -p "$out/3.0.0"
    ln -s "${pkgs.libcanberra-gtk3}/lib/gtk-3.0/modules" "$out/3.0.0/modules"
  '';
in
{
  # Ubuntu requests this sound module through its GTK desktop settings. Make
  # the Nix-built module discoverable by GTK 3 applications across the session.
  home.sessionSearchVariables.GTK_PATH = [
    "${gtk3Modules}"
  ];
  # Existing desktop sessions can inherit Home Manager's already-sourced flag
  # from before a switch. Make new zsh processes pick up the current path too.
  programs.zsh.envExtra = ''
    case ":''${GTK_PATH-}:" in
      *:"${gtk3Modules}":*) ;;
      *) export GTK_PATH="${gtk3Modules}''${GTK_PATH:+:$GTK_PATH}" ;;
    esac
  '';
}
