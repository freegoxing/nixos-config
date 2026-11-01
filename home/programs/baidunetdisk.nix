{ pkgs, ... }:

let
  lib = pkgs.lib;

  # 继续使用 xddxdd 的 NUR 包作为上游
  upstream = pkgs.nur.repos.xddxdd.baidunetdisk;

  # 官方客户端所需的运行时依赖
  runtimeLibraries = [
    pkgs.gtkmm2
    pkgs.gtk2

    pkgs.stdenv.cc.cc.lib
    pkgs.libappindicator
    pkgs.libdbusmenu
    pkgs.libgbm
    pkgs.libglvnd
  ];

  # 保留官方 Electron，不使用 NUR 的 electron_11
  baidunetdisk = upstream.overrideAttrs (old: {
    nativeBuildInputs =
      (old.nativeBuildInputs or [])
      ++ [ pkgs.dpkg ];

    # 上游的 dontUnpack = true 保持不变
    # 直接从上游 src（官方 DEB）重新解包
    installPhase = ''
      runHook preInstall

      mkdir -p "$out/opt/baidunetdisk" "$out/bin"

      dpkg-deb -x "$src" ./deb-root

      # 保留官方 Electron 和全部资源
      cp -a deb-root/opt/baidunetdisk/. \
        "$out/opt/baidunetdisk/"

      # 使用官方可执行文件，注入动态库搜索路径
      makeWrapper \
        "$out/opt/baidunetdisk/baidunetdisk" \
        "$out/bin/baidunetdisk" \
        --prefix LD_LIBRARY_PATH : \
          "${lib.makeLibraryPath runtimeLibraries}:$out/opt/baidunetdisk" \
        --add-flags "--no-sandbox"

      runHook postInstall
    '';

    # 替换上游使用 Electron 11 的 postInstall
    # 保留图标安装逻辑
    postInstall = ''
      install -Dm644 \
        "$out/opt/baidunetdisk/baidunetdisk.svg" \
        "$out/share/icons/hicolor/scalable/apps/baidunetdisk.svg"
    '';

    # 不剥离官方二进制的符号
    dontStrip = true;
  });
in
{
  home.packages = [
    baidunetdisk
  ];
}

