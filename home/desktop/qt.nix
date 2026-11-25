{ ... }:
let
  theme = import ./theme.nix;
  settings.Appearance = {
    icon_theme = theme.iconTheme;
    style = theme.qtStyle;
    custom_palette = false;
  };
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = theme.qtStyle;
    qt5ctSettings = settings;
    qt6ctSettings = settings;
  };
}
