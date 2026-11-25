{ pkgs, ... }:
let
  theme = import ../theme.nix;
in
{
  home.packages = with pkgs; [
    flat-remix-gtk
    flat-remix-icon-theme
    bibata-cursors

    gnome-tweaks
  ];

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = theme.gtkTheme;
    icon-theme = theme.iconTheme;
    cursor-theme = theme.cursorTheme;
    cursor-size = theme.cursorSize;

    color-scheme = theme.colorScheme;
  };
}
