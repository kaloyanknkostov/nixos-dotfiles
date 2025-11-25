{
  config,
  pkgs,
  neovim-nightly,
  inputs,
  ...
}:
let
  dotfilesConfigDir = "${config.home.homeDirectory}/nixos-dotfiles/config";
  configsToLink = {
    nvim = "nvim"; # Links ~/.config/nvim -> ~/nixos-dotfiles/config/nvim
  };
in
{
  imports = [
    ./modules/suckless.nix
    ./modules/neovim.nix
    ./modules/ghostty.nix
    ./modules/sh.nix
    ./modules/tmux.nix
    ./modules/yazi.nix
    ./modules/xdg-portal.nix
    inputs.zen-browser.homeModules.twilight-official
    inputs.spicetify-nix.homeManagerModules.default

  ];
  home.packages = with pkgs; [
    xclip # For X11 (most desktop environments)
    jetbrains.idea-community
    dragon-drop
    alacritty
    obsidian
  ];
  home.username = "kaloyan";
  home.homeDirectory = "/home/kaloyan";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    LIBGL_ALWAYS_SOFTWARE = "1";
    GTK_USE_PORTAL = "1";
  };
  xdg.configFile = builtins.mapAttrs (name: path: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfigDir}/${path}";
    recursive = true;
  }) configsToLink;
  programs.git = {
    enable = true;
    userName = "kaloyan";
    userEmail = "kaloyanknkostov@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
    };
  };

  programs.firefox = {
    enable = true;
    # profiles.default = {
    #   id = 0;
    #   name = "Default";
    #   isDefault = true;
    # };
  };
  programs.brave.enable = true;
  programs.spicetify.enable = true;
  stylix.targets = {
    neovim.enable = false;
    tmux.enable = false;
    starship.enable = false;
    obsidian.enable = true;
    obsidian.vaultNames = [
      "Notes"
    ];
    firefox.enable = true;
  };
  programs.neovim = {
    package = neovim-nightly.packages.${pkgs.system}.default;
  };
}
