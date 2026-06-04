{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    focusclock.url = ./focusclock;
  };

  outputs =
    { nixpkgs, focusclock, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.omen15 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          {
            nixpkgs.overlays = [ focusclock.overlays.default ];
          }
          ./configuration.nix
        ];
      };
    };
}
