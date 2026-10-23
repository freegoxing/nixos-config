{ pkgs, ... }:
{
  users.users.kvm = {
    isNormalUser = true;
    description = "kvm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
    shell = pkgs.zsh;
  };
}
