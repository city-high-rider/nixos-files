{ ... }:
let csh = import ../colorschemes/firewatch.nix;
in {
  services.mako.enable = true;
  services.mako.settings = {
    border-color = "#${csh.primary}";
    border-radius = 8;
    border-size = 4;
    background-color = "#${csh.base02}";
    text-color = "#${csh.base06}";
  };
}
