{ ... }:
let csh = import ../colorschemes/redline.nix;
in {
  services.mako.enable = true;
  services.mako.settings = {
    font = "ComicNeue Regular 16";
    border-color = "#${csh.red}";
    border-radius = 8;
    border-size = 4;
    background-color = "#${csh.lighter}";
    text-color = "#${csh.darker}";
  };
}
