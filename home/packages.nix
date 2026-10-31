{ pkgs, ... }:
{ home.packages = with pkgs; [ 
    fastfetch  
    eza

    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # Cargo tools
    cargo-binstall
    cargo-binutils

    # Tauri
    cargo-tauri

    uv
    pnpm
    cmake

    mdcat
    tokei
    typst
    hexo-cli

    # pdf
    kdePackages.okular

    texstudio
   
    # video
    vlc
    kdePackages.kdenlive

    ulauncher

    mission-center

    prismlauncher

    protonplus

    wpsoffice-cn

    geogebra

    inkscape

    thunderbird-esr
    ];
}
