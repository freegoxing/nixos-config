{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # 保留 LazyVim 自己的 init.lua
    sideloadInitLua = true;

    # Wayland 剪贴板支持
    waylandSupport = true;

    # Neovim Python 和 Node Provider
    withPython3 = true;
    withNodeJs = true;

    # 供 LazyVim 及其插件使用的外部工具
    extraPackages = with pkgs; [
      lazygit

      lua-language-server
      stylua
    ];
  };

  # 将 Neovim 配置链接到 Git 仓库中的实际目录
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Code/nix/nixos-config/dotfiles/nvim";
}
