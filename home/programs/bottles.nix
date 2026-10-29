{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      bottles-unwrapped = prev.bottles-unwrapped.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace bottles/backend/utils/connection.py \
            --replace-fail \
            '"https://ping.usebottles.com"' \
            '"https://proxy.usebottles.com/repo/components/"'

          # 输出真实异常，而不是统一显示 offline
          substituteInPlace bottles/backend/utils/connection.py \
            --replace-fail \
            'except Exception:' \
            'except Exception as e:'

          substituteInPlace bottles/backend/utils/connection.py \
            --replace-fail \
            'logging.warning("Connection status: offline …")' \
            'logging.warning(f"Connection status: offline … {e!r}")'
        '';
      });
    })
  ];

  home.packages = [
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
  ];
}
