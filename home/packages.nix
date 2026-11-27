{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nix
    cachix

    # CLI utilities
    fastfetch
    eza
    fd
    bat
    jq
    tokei
    mdcat

    # Development tools
    cmake
    uv
    pnpm
    gh
    vscode

    # virtual manager
    virt-manager

    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # Cargo tools
    cargo-binstall
    cargo-binutils

    # Documentation & publishing
    typst
    texstudio
    obsidian
    hexo-cli

    # Office & PDF
    wpsoffice-cn
    kdePackages.okular
    pdfarranger

    # Graphics & science
    inkscape
    drawio
    geogebra

    # Multimedia
    vlc
    kdePackages.kdenlive

    # Internet & communication
    google-chrome
    thunderbird-esr
    filezilla
    remmina

    # Desktop utilities
    ulauncher
    mission-center

    # Gaming
    prismlauncher
    protonplus

    peazip

    wechat
    qq

    gparted-full
  ];
}
