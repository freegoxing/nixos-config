{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  # NixOS 动态链接兼容层
  programs.nix-ld.enable = true;

  # 虚拟机桌面的中文输入法
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  # 虚拟机专属 Neovim 依赖
  home-manager.users.kvm.programs.neovim.extraPackages =
    with pkgs; [
      gcc
      gnumake
      pkg-config
      tree-sitter
      ripgrep
      fd
      unzip
    ];

  # SPICE 虚拟机集成
  services.spice-vdagentd.enable = true;

  systemd.user.services.spice-vdagent = {
    description = "SPICE guest session agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
    };
  };
}

