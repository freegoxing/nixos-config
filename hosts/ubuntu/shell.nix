{ config, lib, ... }:
let
  homeDir = config.home.homeDirectory;
  pnpmHome = "${homeDir}/.local/share/pnpm";
in
{
  programs.zsh.shellAliases = {
    hms = "home-manager switch --flake ~/Code/nix/nixos-config#ubuntu";
    hmg = "home-manager generations";

    sysup = ''echo "=== APT Update ===" && sudo apt update && echo "=== APT Upgrade ===" && sudo apt upgrade && echo "=== Nix update ===" && hmu'';
    sysclean = ''echo "=== APT Clean ===" && sudo apt autoremove --purge && echo "=== Nix clean ===" && nix-collect-garbage'';

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

    apt-size() {
      local packages
      packages=$(LC_ALL=C apt-get -s autoremove --purge "$@" 2>/dev/null |
        awk '$1 == "Remv" || $1 == "Purg" {print $2}')

      if [[ -z "$packages" ]]; then
        echo "没有需要卸载的软件包"
        return
      fi

      print -r -- "$packages" |
        xargs -r dpkg-query -W -f=${lib.escapeShellArg "\${Package}\\t\${Installed-Size}\\n"} 2>/dev/null |
        awk '{
          sum += $2
          printf "%-35s %8.2f MiB\n", $1, $2 / 1024
        }
        END {
          printf "\n预计释放空间：%.2f MiB\n", sum / 1024
        }'
    }

    function hm-current() {
      home-manager generations \
        | grep -F '(current)' \
        | grep -oE '/nix/store/[^[:space:]]+' \
        | head -n 1
    }

    function hmu() {
      local repo="$HOME/Code/nix/nixos-config"
      local old_gen new_gen

      old_gen=$(hm-current)

      printf '\n\033[1;36m=== Nix update ===\033[0m\n'
      nix flake update --flake "$repo" || return $?

      printf '\n\033[1;36m=== Home Manager activation ===\033[0m\n'
      home-manager switch --flake "$repo#ubuntu" "$@" || return $?

      new_gen=$(hm-current)

      printf '\n\033[1;36m=== Package changes ===\033[0m\n'

      if [[ -z "$old_gen" || -z "$new_gen" ]]; then
        echo "Unable to identify both generations."
      elif [[ "$old_gen" == "$new_gen" ]]; then
        echo "No generation changes."
      else
        nvd diff "$old_gen" "$new_gen" || return $?
      fi

      printf '\n\033[1;32m=== Update completed ===\033[0m\n'
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
