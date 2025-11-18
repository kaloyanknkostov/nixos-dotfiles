{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;

    themes = {
      vague = {
        palette = [
          "0=#252530"
          "1=#d8647e"
          "2=#7fa563"
          "3=#f3be7c"
          "4=#6e94b2"
          "5=#bb9dbd"
          "6=#aeaed1"
          "7=#cdcdcd"
          "8=#606079"
          "9=#e08398"
          "10=#99b782"
          "11=#f5cb96"
          "12=#8ba9c1"
          "13=#c9b1ca"
          "14=#bebeda"
          "15=#d7d7d7"
        ];

        background = "#141415";
        foreground = "#cdcdcd";
        "selection-background" = "#252530";
        "selection-foreground" = "#cdcdcd";
        "split-divider-color" = "#878787";
        "cursor-color" = "#cdcdcd"; # Added to match foreground visibility
      };
    };

    settings = {
      theme = "vague"; # Important: This must match the name in 'themes'
      "font-size" = 14;
      "gtk-single-instance" = false;
    };
  };
}
# theme = vague
# window-decoration = false
# confirm-close-surface=false
# resize-overlay = never
# cursor-style = "block"
# cursor-style-blink = false
# shell-integration = zsh
# shell-integration-features = no-cursor
# mouse-hide-while-typing = true
# background-opacity = 1.0
# background-blur-radius = 80
# font-family = "JetBrainsMono Mono Nerd Font"
# font-style = "Medium"
# font-size = 14
# keybind = global:super+l=toggle_quick_terminal
# quick-terminal-position = center
# quick-terminal-size = 80%,80%
