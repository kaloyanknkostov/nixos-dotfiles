{ config, pkgs, ... }:
{
  imports = [
    ../../common/default.nix # Import shared config
    ./hardware-configuration.nix # Import PC hardware config
  ];

  networking.hostName = "nixos-pc"; # The "Automatic" identifier

  # Nvidia Specifics
  # hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
}
