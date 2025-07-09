{ pkgs, ... }: {
  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 40;
  };
  programs.niri.settings.cursor = {
    theme = "Bibata-Modern-Ice";
    size = 40;
  };
}
