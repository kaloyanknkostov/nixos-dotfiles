{ pkgs, ... }:
let
  # Wrapper script to launch yazi in Alacritty
  yazi-wrapper = pkgs.writeShellScript "yazi-wrapper" ''
    #!/bin/sh
    # The portal passes the output path as the 5th argument
    OUT="$5"

    # Launch Alacritty with a specific class so DWM can spot it
    # --class instance,general
    # We use a specific class "yazi-file-picker" to float this window in DWM
    TERM_CMD="${pkgs.alacritty}/bin/alacritty --class yazi-file-picker,yazi-file-picker -e"

    # Launch Yazi
    $TERM_CMD ${pkgs.yazi}/bin/yazi --chooser-file="$OUT"
  '';
in
{
  # 1. Install the portal backend
  home.packages = [ pkgs.xdg-desktop-portal-termfilechooser ];

  # 2. Configure the portal
  xdg.portal = {
    enable = true;

    # Add termfilechooser (for files) and gtk (as a fallback for everything else)
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common = {
      # Force the file chooser to be termfilechooser
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      # Let everything else (screensharing, etc.) default to gtk
      "org.freedesktop.impl.portal.*" = "gtk";
    };
  };

  # 3. Write the termfilechooser config file
  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yazi-wrapper}
  '';
}
