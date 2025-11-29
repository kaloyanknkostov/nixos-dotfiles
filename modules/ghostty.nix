{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;

    # ------------------------------------------------------------------------
    # FORCE SOFTWARE RENDERING (Critical for VirtualBox)
    # ------------------------------------------------------------------------
    # This wraps the ghostty binary to ensure LIBGL_ALWAYS_SOFTWARE=1 is set
    # every time it runs, fixing the "Unable to acquire OpenGL context" error.
    # package = pkgs.ghostty.overrideAttrs (old: {
    #   nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
    #   postInstall = (old.postInstall or "") + ''
    #     wrapProgram $out/bin/ghostty \
    #       --set LIBGL_ALWAYS_SOFTWARE 1
    #   '';
    # });
    #
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
        "cursor-color" = "#cdcdcd";
      };
    };

    settings = {
      theme = "vague";
      "font-size" = 14;
      "font-family" = "JetBrainsMono Mono Nerd Font";
      "font-style" = "Medium";

      # Window & GTK Settings
      "window-decoration" = false;
      "confirm-close-surface" = false;
      "resize-overlay" = "never"; # Fixed typo (removed space)

      # Cursor & Mouse
      "cursor-style" = "block"; # Fixed typo
      "cursor-style-blink" = false; # Fixed typo
      "mouse-hide-while-typing" = true; # Fixed typo

      # Shell Integration
      "shell-integration" = "zsh"; # Fixed typo
      "shell-integration-features" = "no-cursor"; # Fixed typo

      # Quick Terminal
      "quick-terminal-position" = "center"; # Fixed typo
      "quick-terminal-size" = "80%,80%"; # Fixed typo

      # Keybinds
      keybind = [
        "global:super+l=toggle_quick_terminal"
      ];
    };
  };
}
