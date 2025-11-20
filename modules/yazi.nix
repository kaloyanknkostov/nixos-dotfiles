{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    # ------------------------------------------------------------------------
    # Import Configuration Files directly
    # ------------------------------------------------------------------------

    # Read yazi.toml (Settings)
    settings = builtins.fromTOML (builtins.readFile ../config/yazi/yazi.toml);

    # Read keymap.toml (Keybindings)
    keymap = builtins.fromTOML (builtins.readFile ../config/yazi/keymap.toml);

    # Read init.lua
    # (Make sure you commented out the 'full-border' lines in this file!)
    initLua = builtins.readFile ../config/yazi/init.lua;
  };
}
