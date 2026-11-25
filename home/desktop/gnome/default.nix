{
  imports = [
    ./appearance.nix
    ./extensions.nix
    ../qt.nix
  ];

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    "org/gnome/mutter".dynamic-workspaces = true;
  };
}
