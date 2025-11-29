{ pkgs, lib, config, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "bemenu-run";

      # Window rules to remove titlebars (from previous step)
      window = {
        titlebar = false;
        border = 2;
      };
      floating = {
        titlebar = false;
        border = 2;
      };

      bars = [
        {
          command = "swaybar";
          position = "bottom";
          statusCommand = "while date +'%Y-%m-%d %H:%M:%S'; do sleep 1; done";
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              background = "#32323200";
              border = "#32323200";
              text = "#5c5c5c";
            };
          };
        }
      ];

      # ---------------------------------------------------------
      # Keybindings Update
      # ---------------------------------------------------------
      keybindings = lib.mkOptionDefault {
        "Mod4+Return" = "exec ghostty";
        "Mod4+Shift+q" = "kill";

        # Bemenu on Super + Space
        "Mod4+space" = "exec bemenu-run";

        # Remap floating toggle to Shift + Super + Space (since we overwrote Mod4+space)
        "Mod4+Shift+space" = "floating toggle";

        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
      };
      # ---------------------------------------------------------

      input = {
        "*" = { xkb_layout = "us"; };
        "type:touchpad" = { tap = "enabled"; natural_scroll = "enabled"; };
      };

      startup = [
        { command = "mako"; }
        { command = "nm-applet --indicator"; }
        { command = "VBoxClient-all"; }
      ];
    };
    
    xwayland = true;
  };
}
