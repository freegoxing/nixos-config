# Desktop appearance choices shared by GNOME and Qt.
let
  dark = true;
in
{
  gtkTheme = if dark then "Flat-Remix-GTK-Blue-Dark" else "Flat-Remix-GTK-Blue-Light";
  iconTheme = if dark then "Flat-Remix-Blue-Dark" else "Flat-Remix-Blue-Light";
  colorScheme = if dark then "prefer-dark" else "prefer-light";
  qtStyle = if dark then "adwaita-dark" else "adwaita";
  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 24;
}
