{ config, lib, ... }:
let
  homeDir = config.home.homeDirectory;
  pnpmHome = "${homeDir}/.local/share/pnpm";
in
{
  programs.zsh.shellAliases = {
    # Ubuntu's package names differ from the usual NixOS command names.
    cat = "batcat";
    fd = "fdfind";

    hms = "home-manager switch --flake ~/Code/nix/nixos-config#ubuntu";
    sysup = ''echo "=== APT Update ===" && sudo apt update && echo "=== APT Upgrade ===" && sudo apt upgrade && echo "=== Nix update ===" && hms'';
    sysclean = ''echo "=== APT Clean ===" && sudo apt autoremove --purge && echo "=== Nix clean" && nix-collect-garbage'';

    wstart = "waydroid session start";
    wstop = "waydroid session stop";

    chrome-proxy = ''proxy-on && google-chrome --proxy-server="http://127.0.0.1:27897"'';
    chrome-clash = ''clash-on && google-chrome --proxy-server="http://127.0.0.1:17897"'';
    chatgpt-clash = "clash-on && chatgpt --proxy-server=http://127.0.0.1:17897";
    chatgpt-proxy = "proxy-on && chatgpt --proxy-server=http://127.0.0.1:27897";

    zotero-on = "systemctl --user start zotero-pdf2zh.service";
    zotero-off = "systemctl --user stop zotero-pdf2zh.service";
    zotero-status = "systemctl --user status zotero-pdf2zh.service";

    winstart = "virsh -c qemu:///system start RDPWindows";
    winstop = "virsh -c qemu:///system shutdown RDPWindows";
    winstate = "virsh -c qemu:///system domstate RDPWindows";
  };

  programs.zsh.initContent = lib.mkAfter ''
    clash-on() {
      export https_proxy=http://127.0.0.1:17897
      export http_proxy=http://127.0.0.1:17897
      export all_proxy=socks5://127.0.0.1:17897
    }
    clash-off() {
      unset http_proxy https_proxy all_proxy
    }
    proxy-on() {
      systemctl --user start ssh-proxy || return
      export http_proxy=http://127.0.0.1:27897
      export https_proxy=http://127.0.0.1:27897
      export HTTP_PROXY=$http_proxy
      export HTTPS_PROXY=$https_proxy
    }
    proxy-off() {
      unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
      systemctl --user stop ssh-proxy
    }

    # Preserve the original ordering: local and STM32 paths precede defaults,
    # while MATLAB, ModelSim, Verible, and Quartus follow the existing PATH.
    export PATH="${homeDir}/.local/bin:$PATH"
    export PATH="/opt/st/stm32cubeclt_1.18.0/GNU-tools-for-STM32/bin:$PATH"
    export PATH="$PATH:/opt/MATLAB/R2024a/bin"
    export PATH="$PATH:/opt/mentor/modelsim2020.4/modeltech/bin"
    export PATH="$PATH:/opt/verible/bin"
    export PATH="$PATH:/opt/altera/13.1/quartus/bin"

    case ":$PATH:" in
      *":${pnpmHome}/bin:"*) ;;
      *) export PATH="${pnpmHome}/bin:$PATH" ;;
    esac
  '';

  home.sessionVariables = {
    APT_PAGER = "cat";
    DIRENV_LOG_FORMAT = "";
    MATLAB_R2024A_HOME = "/opt/MATLAB/R2024a";
    MTI_VCO_MODE = "64";
    LM_LICENSE_FILE = "/opt/mentor/modelsim2020.4/license.lic";
    PNPM_HOME = pnpmHome;
  };
}
