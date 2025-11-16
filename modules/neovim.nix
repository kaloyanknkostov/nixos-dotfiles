{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep # fuzzy searching
    fd      # finding files
    lua-language-server
    nil # nix language server
    nixpkgs-fmt # nix formatter
    git
    nodejs
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;  # Creates 'vi' alias
    vimAlias = true; # Creates 'vim' alias
  };
}
