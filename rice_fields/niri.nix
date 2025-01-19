{ ... }:
let csh = import ./beigegreen.nix;
in {
  programs.niri.settings = {
    spawn-at-startup = { waybar.commad = "waybar"; };
  };
}
