{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  nur = import inputs.nur { inherit pkgs; };
  gtk3Modules = pkgs.runCommand "gtk3-session-modules" { } ''
    mkdir -p "$out/3.0.0"
    ln -s "${pkgs.libcanberra-gtk3}/lib/gtk-3.0/modules" "$out/3.0.0/modules"
  '';
in
{
  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "pycharm"
        "nvidia-x11"
        "wechat"
        "wpsoffice-cn"
        "geogebra"
        "google-chrome"
        "obsidian"
        "wemeet"
        "libwemeetwrap"
        "baidunetdisk"
        "lceda-pro"
        "qq"
        "z-library-desktop"
        "nomachine-client"
        "bilibili"
        "vscode"
        "chatgpt"
        "chatgpt-primary-runtime"
      ];

    nvidia.acceptLicense = true;
  };

  imports = [
    ../../home/desktop/gnome
    ../../home/shell
    ./shell.nix
    ./ssh.nix
    ../../home/packages.nix
    ../../home/programs/kitty.nix
    ../../home/programs/lutris.nix
    ../../home/programs/jujutsu.nix
    ../../home/programs/nvim.nix
    ../../home/programs/zed.nix
    ../../home/programs/texlive.nix
    ../../home/programs/bottles.nix
    ../../home/programs/obs.nix
    ../../home/programs/direnv.nix
    ../../home/programs/git.nix
    ../../home/programs/ssh
  ];

  home.username = "free";
  home.homeDirectory = "/home/free";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nur.baidunetdisk
    nur.lceda-pro
    nur.equation-exporter
    z-library-desktop

    cargo-tauri

    (nomachine-client.overrideAttrs (_: {
      version = "10.2.3";

      src = fetchurl {
        url = "https://web9001.nomachine.com/download/10.2/Linux/nomachine-player_10.2.3_1_x86_64.tar.gz";
        hash = "sha256-JOg97ElcbLM6uc6DCAwfGnoytsEgY/BSFmmdIE4oC1o=";
      };
    }))

    bilibili
    picgo
    chatgpt
    cutecom
  ];

  programs.home-manager.enable = true;

  programs.ssh.package = pkgs.openssh;
  services.ssh-agent.enable = true;

  targets.genericLinux.enable = true;

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

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.99.02";
    sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
  };

  targets.genericLinux.nixGL.prime.installScript = "nvidia";
}
