{ ... }:
let csh = import ../colorschemes/firewatch.nix;
in {
  services.mako = {
    enable = true;
    borderColor = "#${csh.primary}";
    borderRadius = 8;
    borderSize = 4;
    backgroundColor = "#${csh.base02}";
    textColor = "#${csh.base06}";
  };
}
