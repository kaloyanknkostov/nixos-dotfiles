{ config, pkgs, ... }:

{
  imports = [
    ../modules/stylix.nix
    # ../modules/dwm.nix # <--- Import the new module here
    ../modules/sway.nix
    ../modules/cosmic.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.networkmanager.enable = true;
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
    # Combine all cache substituters
    substituters = [
      "https://neovim-nightly.cachix.org"
    ];
    trusted-public-keys = [
      "neovim-nightly.cachix.org-1:vSoGjEbPlg7cfsclnxb21L/nQvN4hHlD9n2TR5Gk7WI="
    ];
  };
  system.stateVersion = "25.05";
}
