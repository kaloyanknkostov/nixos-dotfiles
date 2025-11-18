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
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./config/dwm;
      };
    };
    videoDrivers = [ "vmsvga" ];
  };
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
