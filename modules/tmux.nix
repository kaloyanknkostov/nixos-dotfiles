{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    # Basic Configuration
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    terminal = "xterm-256color";

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      # Essentials
      sensible
      yank

      # Navigation
      vim-tmux-navigator

      # FZF
      tmux-fzf

      # Session Management (Must be configured here for Home Manager)
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }

      # SessionX
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind 'o'
          set -g @sessionx-x-path '~/dotfiles'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
    ];

    # General Options & Keybinds
    extraConfig = ''
      # ----------------------------------------------------------------------
      # General Options
      # ----------------------------------------------------------------------
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      set -g detach-on-destroy off

      # RGB Capability Fix
      set -ag terminal-overrides ",xterm-256color:RGB"

      # ----------------------------------------------------------------------
      # Keybindings
      # ----------------------------------------------------------------------
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # ----------------------------------------------------------------------
      # Status Bar
      # ----------------------------------------------------------------------
      set -g focus-events on
      set -g status-style bg=#141415
      set -g status-left '#(cat #{socket_path}-\#{session_name}-vimbridge)'
      set -g status-left-length 99
      set -g status-right '#(cat #{socket_path}-\#{session_id}-vimbridge-R)'
      set -g status-right-length 99
      set -g status-justify centre
    '';
  };

  home.packages = with pkgs; [
    fzf
    bat
    zoxide
    gnused
  ];
}
