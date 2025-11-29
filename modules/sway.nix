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
      bemenu
      wl-clipboard
      grim 
      slurp
      pavucontrol
      mako
      networkmanagerapplet
    ];
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
  services.xserver.enable = true; 
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.gdm.enable = false;
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

    environment.systemPackages = with pkgs; [
    polkit_gnome    # Required for the authentication agent service above
  ];
   programs.zsh.loginShellInit = ''if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then exec sway --unsupported-gpu; fi'';
}
