{
  config,
  pkgs,
  lib,
  ...
}: # <--- Add 'lib' here
{
  imports = [
    ../../common/default.nix
    ./hardware-configuration.nix
    ../../modules/sway.nix
  ];

  networking.hostName = "nixos-vm";

  # VM Specifics
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;

  # Force these commands to run BEFORE the common sessionCommands
  # services.xserver.displayManager.sessionCommands = lib.mkBefore ''
  #   ${pkgs.xorg.xrandr}/bin/xrandr --auto
  #   VBoxClient-all &
  #
  #   # Force 1440p Mode
  #   ${pkgs.xorg.xrandr}/bin/xrandr --newmode "2560x1440_60.00"  312.25  2560 2744 3024 3488  1440 1443 1448 1493 -hsync +vsync
  #   ${pkgs.xorg.xrandr}/bin/xrandr --addmode Virtual-1 "2560x1440_60.00"
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --mode "2560x1440_60.00"
  # '';
}
