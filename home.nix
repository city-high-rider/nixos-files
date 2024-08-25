{config,pkgs,...} : {
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
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position  = "top";
      width = 30;
      spacing = "4px";
      modules-left = [
        "hyprland/workspaces"
        "hyprland/submap"
        "tray"
      ];
      modules-center = [
        "hyprland/window"
      ];
      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "clock"
        "custom/power"
      ];

    "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = "";
            deactivated = "";
        };
      };

    "tray" = {
      spacing = 10;
    };

    "clock" = {
      tooltip-format = ''
        <big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>
      '';
    };

    "cpu" = {
     format = "{usage}% ";
    };

    "memory" = {
     format = "{}% "; 
    };

    "temperature" = {
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format_critical = "{temperatureC}°C ";
      format-icons = ["" "" "" ""];
    };
     
    };
  };
}
