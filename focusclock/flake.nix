{
  description = "A flake for focus clock";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      focusclock-pkg = pkgs.stdenv.mkDerivation {
        pname = "focusclock";
        version = "2.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "KorigamiK";
          repo = "focusclock";
          rev = "main";
          hash = "sha256-f9IYuOWrjsqhVx/A8ybhN33H9U/lEwvHNf4GhdmcOWw=";
        };
        nativeBuildInputs = with pkgs; [
          cmake
          pkg-config
          wrapGAppsHook4
        ];
        buildInputs = with pkgs; [
          gtkmm4
          gtk4-layer-shell
        ];
      };
    in
    {
      packages.${system}.default = focusclock-pkg;
      overlays.default = final: prev: {
        focusclock = focusclock-pkg;
      };
    };
}
