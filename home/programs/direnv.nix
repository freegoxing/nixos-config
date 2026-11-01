{ ... }:

{
  programs.direnv = {
    enable = true;

    # Zsh 集成
    enableZshIntegration = true;

    # 使用 nix-direnv 加速 Flake 环境加载
    nix-direnv.enable = true;

    # 保留加载提示，不完全静默
    silent = false;

    # direnv.toml 配置
    config.global = {
      hide_env_diff = true;
    };
  };
}
