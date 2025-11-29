{ pkgs, lib, config, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "bemenu-run";

      window = {
        titlebar = false;
        border = 0;
      };
      floating = {
        titlebar = false;
        border = 2;
      };
output = {
        "DP-3" = {
          mode = "2560x1440@239.97Hz";
          adaptive_sync = "off";
          allow_tearing = "no"; 
        };
      };
      bars = [
        {
          command = "swaybar";
          position = "top";
	  mode = "hide";
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
        "Mod4+q" = "kill";
        "Mod4+space" = "exec bemenu-run";
        "Mod4+Shift+space" = "floating toggle";
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Mod4+b" = "bar mode toggle";
      };

      input = {
        "*" = { xkb_layout = "us"; };
      };

assigns = {
        "1" = [
          { app_id = "zen"; } 
          { app_id = "zen-browser"; } # Zen might use this ID depending on version
          { app_id = "zen-beta"; } # Zen might use this ID depending on version
        ];
        "2" = [
          { app_id = "com.mitchellh.ghostty"; } # Default Ghostty ID
          { app_id = "ghostty"; } # Fallback
        ];
        "5" = [
          { app_id = "obsidian"; }  # If running natively
          { class = "Obsidian"; }   # If running via XWayland
        ];
        "6" = [
          { class = "spotify"; }    # Spotify usually runs on XWayland
        ];
      };
      startup = [
        { command = "mako"; }
        { command = "nm-applet --indicator"; }
        { command = "zen"; }
        { command = "ghostty"; }
        { command = "spotify"; }
        { command = "obsidian"; }
      ];
    };
    
     xwayland = true;
  };
}
