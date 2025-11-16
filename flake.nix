{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay/e00db0f40c5c8d0832f085849bf16d85743b21c6";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly, ... }:
    let
      system = "x86_64-linux";
      specialArgs = { inherit neovim-nightly; };
    in {
      nixosConfigurations.kaloyan = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kaloyan = import ./home.nix;
            home-manager.backupFileExtension = "backup";
	    home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
}
