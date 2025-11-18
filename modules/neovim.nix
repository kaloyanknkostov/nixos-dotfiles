{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    ripgrep # fuzzy searching
    fd # finding files
    lua-language-server
    nil # nix language server
    nixpkgs-fmt # nix formatter
    git
    nodejs
    gcc
    pyright
    stylua
    black
    isort
  ];
  programs.neovim = {
    enable = true;
    viAlias = true; # Creates 'vi' alias
    vimAlias = true; # Creates 'vim' alias
  };
}
