{ config, pkgs,neovim-nightly, ... }:



{
  imports = 
    [ 
      ./modules/suckless.nix
      ./modules/neovim.nix
    ];
  home.username = "kaloyan";
  home.homeDirectory = "/home/kaloyan";
  home.stateVersion = "25.05";
  home.sessionVariables = {
  LIBGL_ALWAYS_SOFTWARE = "1";
  };
  programs.git = {
    enable = true;
    userName = "kaloyan"; # Or whatever name you want
    userEmail = "kaloyanknkostov@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos-btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles";
    };
    initExtra = ''
      	  export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      	'';
  };
  programs.neovim = {
    package = neovim-nightly.packages.${pkgs.system}.default;
  };
  #home.file.".config/nvim" = {
  #  source = ./config/nvim;
  #  recursive = true;
  #};
  
}
