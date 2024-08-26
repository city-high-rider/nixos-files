{config,pkgs,...} : let
     csh = import ./beigegreen.nix;
in {

  # I split up some programs with long config. files (namely rofi, hyprland, etc.) 
  # Here I import them.
  imports = [
    ./rice_fields/rofi.nix
    ./rice_fields/hyprland.nix
    ./rice_fields/waybar.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "24.05";
  };

  fonts.fontconfig.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_light";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
      };
    };
    languages = {
      language-server.texlab.config.texlab.build.onSave = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "city-high-rider";
    userEmail = "60808209+city-high-rider@users.noreply.github.com";
    extraConfig.credential = {
      "https://github.com/" = {
        helper = "!gh auth git-credential";
      };
      "https://gist.github.com/" = {
        helper = "!gh auth git-credential";
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      fortune | cowsay
    '';
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 24;
    };
    settings = {
        background_opacity = "0.6";
        background_blur = 16;
    };
  };

  # Notification daemon.
  services.mako = {
    enable = true;
    borderColor = "#${csh.primary}";
    borderRadius = 8;
    borderSize = 4;
    backgroundColor = "#${csh.base02}";
    textColor = "#${csh.base06}";
  };

}
