{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        # This path works because 'modules' is a sibling of 'config'
        src = ../config/dwm;
      };
    };

    # Startup commands moved here to keep DWM config self-contained
    displayManager.sessionCommands = ''
      zen &
      ghostty &
      while true;
      do
        xsetroot -name "$(date +'%a %b %d %H:%M')"
        sleep 60
      done &
    '';
  };
}
