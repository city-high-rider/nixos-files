{ config, pkgs, ... }:
let csh = import ./beigegreen.nix;
in {

  # I split up some programs with long config. files (namely rofi, hyprland, etc.) 
  # Here I import them.
  imports = [
    ./rice_fields/fuzzel.nix
    ./rice_fields/hyprland.nix
    ./rice_fields/niri.nix
    ./rice_fields/waybar.nix
    ./music-player.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "24.05";
  };

  xdg.userDirs.enable = true;

  fonts.fontconfig.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "everforest_light";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
      };
    };
    languages = {
      language-server.texlab.config.texlab.build.onSave = true;
      language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
      }];
    };
  };

  programs.git = {
    enable = true;
    userName = "city-high-rider";
    userEmail = "60808209+city-high-rider@users.noreply.github.com";
    extraConfig.credential = {
      "https://github.com/" = { helper = "!gh auth git-credential"; };
      "https://gist.github.com/" = { helper = "!gh auth git-credential"; };
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

  # Hyprlock, screen locking utility.
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
        ignore_empty_input = false;
      };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = ''
          <span foreground="##cad3f5">Password...</span>
        '';
        shadow_passes = 2;
      }];
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

  # No need to exec-once this, home-manager starts it automatically.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Avoid launching multiple hyprlock instances.
        lock_cmd = "pidof hyprlock || hyprlock";
        # Lock when we go to sleep.
        before_sleep_cmd = "loginctl lock-session";
        # Avoid having to press a key twice to turn on display.
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        # After 2min, dim the screen.
        {
          timeout = 150;
          # Save old level, set to 10.
          on-timeout = "brightnessctl -s set 10";
          # Restore light level
          on-resume = "brightnessctl -r";
        }
        # Lock screen after 5 mins
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # 30s later, turn off the screen.
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

}
