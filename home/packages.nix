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

    mdcat
    tokei
    typst
    hexo-cli

    # pdf
    kdePackages.okular

    texstudio

    ulauncher

    mission-center

    prismlauncher

    protonplus

    wechat

    wpsoffice-cn
    ];
}
