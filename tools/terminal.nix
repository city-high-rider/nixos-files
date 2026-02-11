{ ... }: {

  programs.bash = {
    enable = true;
    initExtra = ''
      fortune | cowsay
    '';
  };

  programs.fish = { enable = true; };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 24;
    };
    themeFile = "Novel";
    settings = {
      background_opacity = "0.8";
      background_blur = 16;
      shell = "fish";
      hide_window_decorations = true;
    };
    shellIntegration.enableFishIntegration = true;
  };

}
