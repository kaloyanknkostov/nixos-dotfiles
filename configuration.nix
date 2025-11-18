{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/kanata.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kaloyan";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_GB.UTF-8";

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  services.xserver = {
    enable = true;
    displayManager.sessionCommands = ''
      zen &
        ghostty &
        while true; do
          xsetroot -name "$(date +'%a %b %d %H:%M')"
          sleep 60
        done &
    '';
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./config/dwm;
      };
    };
    videoDrivers = [ "vmsvga" ];
  };
  programs.zsh.enable = true;
  users.users.kaloyan = {
    isNormalUser = true;
    description = "kaloyan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      tree
    ];

    shell = pkgs.zsh;
  };
  services.getty.autologinUser = "kaloyan";
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    btop
    fastfetch
    xclip
    alacritty
  ];
  stylix.enable = true;
  stylix.base16Scheme = {
    base00 = "141415"; # Default Background
    base01 = "252530"; # Lighter Background (Status bars)
    base02 = "252530"; # Selection Background
    base03 = "606079"; # Comments, Invisibles, Line Highlighting
    base04 = "878787"; # Dark Foreground (Used for status bars)
    base05 = "cdcdcd"; # Default Foreground, Caret, Delimiters, Operators
    base06 = "d7d7d7"; # Light Foreground (Not often used)
    base07 = "d7d7d7"; # Light Background (Not often used)
    base08 = "d8647e"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted (Red)
    base09 = "f5cb96"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url (Orange/Bright Yellow)
    base0A = "f3be7c"; # Classes, Markup Bold, Search Text Background (Yellow)
    base0B = "7fa563"; # Strings, Inherited Class, Markup Code, Diff Inserted (Green)
    base0C = "aeaed1"; # Support, Regular Expressions, Escape Characters, Markup Quotes (Cyan)
    base0D = "6e94b2"; # Functions, Methods, Attribute IDs, Headings (Blue)
    base0E = "bb9dbd"; # Keywords, Storage, Selector, Markup Italic, Diff Changed (Purple)
    base0F = "c9b1ca"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?> (Bright Purple/Brown)
  };
  stylix.image = ./wallpaper.png;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  hardware.opengl = {
    enable = true;
  };
  virtualisation.virtualbox.guest.enable = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://neovim-nightly.cachix.org" ];
    trusted-public-keys = [
      "neovim-nightly.cachix.org-1:vSoGjEbPlg7cfsclnxb21L/nQvN4hHlD9n2TR5Gk7WI="
    ];
  };
  system.stateVersion = "25.05"; # Did you read the comment?

}
