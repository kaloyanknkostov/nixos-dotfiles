{ config, pkgs, ... }:

{
  imports = [
    ../modules/stylix.nix
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true; # You likely need this line too!

  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_GB.UTF-8";

  networking.networkmanager.enable = true;
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ../config/dwm; # Ensure this path is correct relative to this file
      };
    };

    displayManager.sessionCommands = ''
      zen &
      ghostty &
      while true; do
        xsetroot -name "$(date +'%a %b %d %H:%M')"
        sleep 60
      done &
    '';
  };

  programs.zsh.enable = true;

  users.users.kaloyan = {
    isNormalUser = true;
    description = "kaloyan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ tree ];
    shell = pkgs.zsh;
  };

  services.getty.autologinUser = "kaloyan";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    btop
    fastfetch
    xclip
    alacritty
  ];

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  hardware.graphics.enable = true;

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

  system.stateVersion = "25.05";
}
