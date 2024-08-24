{
  description = "My system config";

  inputs = {
    nixpgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager,...} :
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations.znarpy = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [./configuration.nix];
    };

    homeConfigurations.sillycat = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [./home.nix];
    };
  };
}
