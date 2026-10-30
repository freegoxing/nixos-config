# Nix 配置

这个仓库使用 Nix Flake 管理两套环境：

- `ubuntu`：在 Ubuntu 上使用的独立 Home Manager 配置，用户为 `free`。
- `vm`：NixOS 虚拟机配置，包含用户 `kvm` 的 Home Manager 配置。

依赖由 `flake.lock` 固定，主要输入是 Nixpkgs 和 Home Manager 的 `26.05` 分支。

## 使用

先安装 Nix，并启用 `nix-command` 和 `flakes` 实验特性。在 Ubuntu 上还需要安装 Home Manager 命令行工具；在 NixOS 上使用 `nixos-rebuild`。以下命令均在仓库根目录执行。

### Ubuntu：Home Manager

```sh
home-manager switch --flake .#ubuntu
```

该入口在 `hosts/ubuntu/home.nix`，设置了用户名、家目录、通用软件包和部分桌面程序。配置中包含 NVIDIA 驱动及 `nixGL` 设置，适用于这里记录的 Ubuntu 机器；迁移到其他机器时应先检查这些选项。

### NixOS 虚拟机

```sh
sudo nixos-rebuild switch --flake .#vm
```

虚拟机入口在 `hosts/vm/default.nix`，同时加载 `nixos/` 下的系统模块和 `hosts/vm/home.nix` 中的 Home Manager 配置。首次用于另一台虚拟机前，应核对 `hosts/vm/hardware-configuration.nix` 中的文件系统和设备信息。

## 目录

| 路径 | 内容 |
| --- | --- |
| `flake.nix`、`flake.lock` | 输入、输出和依赖锁定 |
| `hosts/ubuntu/` | Ubuntu 的独立 Home Manager 入口 |
| `hosts/vm/` | NixOS 虚拟机入口、硬件配置和用户配置 |
| `nixos/` | NixOS 系统模块，如桌面、网络、服务和软件包 |
| `home/` | 共用的 Home Manager 软件包、程序和 Shell 配置 |
| `dotfiles/nvim/` | 由 Home Manager 链接的 Neovim 配置 |

修改配置后，重新运行对应的 `switch` 命令即可应用。提交配置变更时一并提交更新后的 `flake.lock`，以便其他机器使用相同的依赖版本。
