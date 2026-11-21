{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome50Extensions."dash-to-panel@jderose9.github.com"
    pkgs.gnome50Extensions."Resource_Monitor@Ory0n"
    pkgs.gnome50Extensions."Bluetooth-Battery-Meter@maniacx.github.com"
    pkgs.gnome50Extensions."quick-sound-switcher@dustin-hawkins"
    pkgs.gnome50Extensions."extension-list@tu.berry"
    pkgs.gnome50Extensions."tiling-assistant@leleat-on-github"
  ];

  dconf.settings."org/gnome/shell" = {
    # Keep the existing order of installed extensions.
    enabled-extensions = [
      "dash-to-panel@jderose9.github.com"
      "ding@rastersoft.com"
      "apps-menu@gnome-shell-extensions.gcampax.github.com"
      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      "ubuntu-appindicators@ubuntu.com"
      "extension-list@tu.berry"
      "Resource_Monitor@Ory0n"
      "Bluetooth-Battery-Meter@maniacx.github.com"
      "quick-sound-switcher@dustin-hawkins"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "tiling-assistant@leleat-on-github"
    ];

    # Session-mode defaults are enabled unless explicitly disabled here.
    disabled-extensions = [
      "light-style@gnome-shell-extensions.gcampax.github.com"
      "window-list@gnome-shell-extensions.gcampax.github.com"
      "ubuntu-dock@ubuntu.com"
      "system-monitor@gnome-shell-extensions.gcampax.github.com"
      "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      "tiling-assistant@ubuntu.com"
    ];
  };
}
