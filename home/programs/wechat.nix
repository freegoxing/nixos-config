{ pkgs, ... }:

let
  # 为微信的 AppImage FHS 环境修复时区数据库
  wechatFixed = pkgs.wechat.override {
    callPackage =
      path: args:
      pkgs.callPackage path (
        args
        // {
          appimageTools = pkgs.appimageTools // {
            wrapAppImage =
              params:
              pkgs.appimageTools.wrapAppImage (
                params
                // {
                  extraPkgs =
                    p:
                    (params.extraPkgs or (_: [ ])) p
                    ++ [ p.tzdata.out ];

                  profile = (params.profile or "") + ''
                    export TZDIR="${pkgs.tzdata.out}/share/zoneinfo"
                  '';
                }
              );
          };
        }
      );
  };

  # IBus 输入法支持
  wechatWrapped = pkgs.symlinkJoin {
    name = "wechat-ibus";
    paths = [ wechatFixed ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/wechat \
        --unset QT_IM_MODULES \
        --set QT_IM_MODULE ibus \
        --set GTK_IM_MODULE ibus \
        --set XMODIFIERS '@im=ibus' \
        --set IBUS_USE_PORTAL 1
    '';
  };
in
{
  home.packages = [ wechatWrapped ];
}
