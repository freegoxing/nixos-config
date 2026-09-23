{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "FantasqueSansM Nerd Font Mono Bold";
      size = 14;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      background_opacity = 0.8;
      dynamic_background_opacity = true;
      confirm_os_window_close = 0;

      cursor_trail = 1;
      linux_display_server = "auto";

      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;

      enable_audio_bell = false;
      window_padding_width = 4;

      selection_foreground = "none";
      selection_background = "none";

      foreground = "#dddddd";
      background = "#000000";
      cursor = "#dddddd";
    };

    keybindings = {
      "ctrl+shift+enter" = "new_window";
      "alt+t" = "new_tab";
      "alt+right" = "next_tab";
      "alt+left" = "previous_tab";
      "ctrl+shift+up" = "neighboring_window up";
      "ctrl+shift+down" = "neighboring_window down";
      "ctrl+shift+left" = "neighboring_window left";
      "ctrl+shift+right" = "neighboring_window right";
    };

    mouseBindings = {
      "ctrl+left release grabbed,ungrabbed" = "mouse_click_url";
    };

    # Preserve the behavior of the original kitty.conf, which did not
    # explicitly enable Kitty's shell integration.
    shellIntegration.mode = null;
  };

  home.packages = [ pkgs.nerd-fonts.fantasque-sans-mono ];
}
