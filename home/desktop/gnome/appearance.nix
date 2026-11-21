{ pkgs, ... }:
{
  home.packages = with pkgs; [
    flat-remix-gtk
    flat-remix-icon-theme
    bibata-cursors
  ];

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "Flat-Remix-GTK-Blue-Dark";
    icon-theme = "Flat-Remix-Blue-Dark";
    cursor-theme = "Bibata-Modern-Ice";
    cursor-size = 24;
  };
}
