{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swayidle
      swaylock
      swaybg          # Wallpaper utility
      bemenu
      mako            # Notification daemon
      wl-clipboard    # Clipboard management
      grim            # Screenshot tool
      slurp           # Region selector for screenshots
      pavucontrol     # Volume control GUI
      networkmanagerapplet # Network tray icon
    ];
  };

  # Display Manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # Stylix should automatically theme this if enabled
  };

  # XDG Portal for screensharing and file pickers
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Enable necessary services
  services.dbus.enable = true;

  # Enable PipeWire for audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Polkit Authentication Agent (Necessary for GUI apps requesting permissions)
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
    };
  };

  # # Environment variables for Wayland compatibility
  # environment.sessionVariables = {
  #   NIXOS_OZONE_WL = "1";
  #   MOZ_ENABLE_WAYLAND = "1";
  #   XDG_CURRENT_DESKTOP = "sway";
  #   XDG_SESSION_TYPE = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   _JAVA_AWT_WM_NONREPARENTING = "1"; # Fixes some Java GUI apps
  # };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  # System packages
  environment.systemPackages = with pkgs; [
    polkit_gnome    # Required for the authentication agent service above
  ];
}
