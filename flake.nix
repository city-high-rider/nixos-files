{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { nixpkgs, home-manager, niri, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.omen15 = nixpkgs.lib.nixosSystem {
        inherit system;
        # NOTE: The niri module will use a binary cache that is run by some guy,
        # so I am trusting the guy in question to NOT upload malicious software there.
        # docs: https://github.com/sodiboo/niri-flake/blob/main/docs.md
        modules = [ ./configuration.nix niri.nixosModules.niri ];
      };

      homeConfigurations.nick = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix ];
      };
    };
}
