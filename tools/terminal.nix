{ ... }: {

  programs.bash = {
    enable = true;
    initExtra = ''
      fortune | cowsay
    '';
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      # Accept suggestion (inline completion)
      bind \t accept-autosuggestion

      # Optional: cycle through suggestions (Shift-Tab)
      # bind \e[Z complete
      bind \ep up-or-search    # Alt+P = previous command
      bind \en down-or-search  # Alt+N = next command
    '';
  };

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
