{ ... }:

{
  imports = [ ./home ];

  home.username = "kvm";
  home.homeDirectory = "/home/kvm";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
