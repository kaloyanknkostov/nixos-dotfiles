{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable Zsh and essential features
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Set up Zsh history to use the standard XDG cache directory (~/.cache)
    history = {
      size = 100000;
      save = 100000;
      path = "${config.xdg.cacheHome}/zsh_history";
      ignoreDups = true;
      share = true;
    };

    # Aliases
    shellAliases = {
      cd = "z";
      cat = "bat";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      v = "nvim";
      cl = "clear";
      ".." = "cd ..";
      "..." = "cd ..;cd ..";
      "...." = "cd ..;cd ..;cd ..";
    };

    # Extra initialization
    initExtra = ''
      # ----------------------------------------------------------------------
      # Ghostty Integration
      # ----------------------------------------------------------------------
      if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
        source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
      fi

      # ----------------------------------------------------------------------
      # Yazi Function
      # ----------------------------------------------------------------------
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

      # ----------------------------------------------------------------------
      # FZF Function
      # ----------------------------------------------------------------------
      f() {
        local dir
        dir=$(zoxide query -l | fzf --height 40%)
        if [[ -n "$dir" ]]; then
          cd "$dir"
        fi
      }

      # ----------------------------------------------------------------------
      # Keybindings
      # ----------------------------------------------------------------------
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -v
      bindkey -M vicmd 'v' edit-command-line

      bindkey -e '^L' clear-screen
      bindkey -M vicmd '^L' clear-screen
      bindkey -M viins '^L' clear-screen

      # ----------------------------------------------------------------------
      # Tmux Auto-start
      # ----------------------------------------------------------------------
      if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
          tmux attach -t default || tmux new -s default
      fi
    '';
  };

  # --------------------------------------------------------------------------
  # Starship Configuration
  # --------------------------------------------------------------------------
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      palette = "gruvbox_dark";

      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$cpp"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "$conda"
        "$pixi"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break"
        "$character"
      ];

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };

      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          AOSC = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          Pop = "";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };

      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      pixi = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)";
      };

      time = {
        disabled = true;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
  };

  # Enable other programs
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.atuin.enable = true;
  programs.atuin.enableZshIntegration = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.eza.enableZshIntegration = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.yazi.enable = true;
  programs.yazi.enableZshIntegration = true;
  programs.tmux.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
