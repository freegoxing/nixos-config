{ pkgs, ... }:

let
  wechatWrapped = pkgs.symlinkJoin {
    name = "wechat-ibus";
    paths = [ pkgs.wechat ];

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
