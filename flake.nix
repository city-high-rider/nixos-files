{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.omen15 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };

      homeConfigurations.nick = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
    };
}
