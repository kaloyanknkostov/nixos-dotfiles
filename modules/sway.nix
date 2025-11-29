{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable Sway window manager - barebones
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = ["--unsupported-gpu"];
    extraPackages = with pkgs; [
      wdisplays
      swayidle
      swaylock
      swaybg
      wmenu
      kitty
    ];
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  services.dbus.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };


  services.xserver.enable = true; # Keeps drivers/layouts loaded
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # <--- This forces the login screen to use Wayland
  };
}
