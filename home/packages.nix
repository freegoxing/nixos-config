{ pkgs, ... }:
{ home.packages = with pkgs; [ 
    fastfetch  
    eza

    uv
    pnpm

    mdcat
    tokei
    typst
    hexo-cli

    # pdf
    kdePackages.okular

    ulauncher

    mission-center

    prismlauncher

    protonplus
    ];
}
