{ config, pkgs, ... }:
{
  imports = [
    ../../common/default.nix # Import shared config
    ./hardware-configuration.nix # Import PC hardware config
    ../../modules/sway.nix
  ];
  networking.hostName = "nixos-pc"; # The "Automatic" identifier
  boot.kernelPackages = pkgs.linuxPackages_latest; 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement.enable= false;
    powerManagement.finegrained= false;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
