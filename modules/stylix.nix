{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sizes = {
      applications = 12;
      terminal = 16;
      desktop = 10;
      popups = 10;
    };
  };
  stylix.image = ../wallpaper.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  # stylix.base16Scheme = {
  #   base00 = "141415";
  #   base01 = "252530";
  #   base02 = "252530";
  #   base03 = "606079";
  #   base04 = "878787";
  #   base05 = "cdcdcd";
  #   base06 = "d7d7d7";
  #   base07 = "d7d7d7";
  #   base08 = "d8647e";
  #   base09 = "f5cb96";
  #   base0A = "f3be7c";
  #   base0B = "7fa563";
  #   base0C = "aeaed1";
  #   base0D = "6e94b2";
  #   base0E = "bb9dbd";
  #   base0F = "c9b1ca";
  # };

}
