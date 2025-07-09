{ pkgs, ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono" ];
      serif = [ ];
      sansSerif = [ ];
    };
  };

  home.packages = with pkgs; [ comic-neue ];
}
