{config,pkgs,...} : let
     csh = import ./beigegreen.nix;
in {
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

  # Application launcher
  programs.rofi = {
    enable = true;
    # We have to specify the package here. Otherwise it will default to
    # the x11 rofi, and when you launch it, since it is being emulated
    # in a window, it will get tiled instead of popping up in the middle
    # of the screen.
    package = pkgs.rofi-wayland;
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
        "*" = {
            bg0 = mkLiteral "#212121F2";
            bg1 = mkLiteral "#2A2A2A";
            bg2 = mkLiteral "#3D3D3D80";
            bg3 = mkLiteral "#4CAF50F2";
            fg0 = mkLiteral "#E6E6E6";
            fg1 = mkLiteral "#FFFFFF";
            fg2 = mkLiteral "#969696";
            fg3 = mkLiteral "#3D3D3D";

            font =   "Roboto 12";

            background-color =   mkLiteral "transparent";
            text-color =         mkLiteral "@fg0";

            margin =     mkLiteral "0px";
            padding =    mkLiteral "0px";
            spacing =    mkLiteral "0px";
        };

        "window" = {
            location =       mkLiteral "center";
            width =          mkLiteral "480";
            border-radius =  mkLiteral "24px";
    
            background-color =   mkLiteral "@bg0";
        };

        
        "mainbox" = {
            padding =    mkLiteral "12px";
        };

        
        "inputbar" = {
            background-color =   mkLiteral "@bg1";
            border-color =       mkLiteral "@bg3";

            border =         mkLiteral "2px";
            border-radius =  mkLiteral "16px";

            padding =    mkLiteral "8px 16px";
            spacing =    mkLiteral "8px";
            children =   mkLiteral "[ prompt, entry]";
        };

        
        "prompt" = {
            text-color = mkLiteral "@fg2";
        };
        

        "entry" = {
            placeholder =        "Search";
            placeholder-color =  mkLiteral "@fg3";
        };

        
        "message" = {
            margin =             mkLiteral "12px 0 0";
            border-radius =      mkLiteral "16px";
            border-color =       mkLiteral "@bg2";
            background-color =   mkLiteral "@bg2";
        };

        "textbox" = {
            padding =    mkLiteral "8px 24px";
        };

        "listview" = {
            background-color =  mkLiteral "transparent";

            margin =     mkLiteral "12px 0 0";
            lines =      mkLiteral "8";
            columns =    mkLiteral "1";

            fixed-height = mkLiteral "false";
        };

        "element" = {
            padding =        mkLiteral "8px 16px";
            spacing =        mkLiteral "8px";
            border-radius =  mkLiteral "16px";
        };

    
        "element normal active" = {
            text-color = mkLiteral "@bg3";
        };

        "element alternate active" = {
            text-color = mkLiteral "@bg3";
        };

        "element selected normal, element selected active" = {
            background-color =   mkLiteral "@bg3";
        };

        "element-icon" = {
            size =           mkLiteral "1em";
            vertical-align = mkLiteral "0.5";
        };

        "element-text" = {
            text-color = mkLiteral "inherit";
        };
    };
  };

  wayland.windowManager.hyprland = let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
      ${pkgs.swww}/bin/swww img "~/wallpapers/cat-butterfly.jpg" &
    '';
  in {
    # Allow homemanager to configure hyprland
    enable = true;
    settings = {
        monitor = [
          # Laptop monitor
          "eDP-1,1920x1080,0x0,1"
          # External monitor on the right. Align the bottoms of them.
          "DP-1,2560x1440,1920x-360,1"
        ];

        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = ''rofi -show combi -modes combi -combi-modes "window,drun" -show-icons'';

        exec-once = "${startupScript}/bin/start";

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 3;
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
          "col.active_border" = "rgba(${csh.primaryNeon}ee) rgba(${csh.secondaryNeon}ee) 45deg";
          "col.inactive_border" = "rgba(${csh.base03}aa)";
        };
        animations = {
            enabled = true;

            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

            animation = [
                "windows, 1, 7, myBezier"
                "windowsOut, 1, 7, default, popin 80%"
                "border, 1, 10, default"
                "borderangle, 1, 8, default"
                "fade, 1, 7, default"
                "workspaces, 1, 6, default"
            ];
        };

        dwindle = {
            pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
            new_status = "master";
        };

        misc = { 
            force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        };

        input = {
            kb_layout = "us";
            follow_mouse = 1;
            sensitivity = 0;

            touchpad.natural_scroll = false;
        };

        gestures.workspace_swipe = false;

        "$mainMod" = "SUPER";
        bind = [
            # Launch rofi
            "$mainMod, D, exec, $menu"
            # Brightness keys for the laptop
            ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
            ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            "$mainMod, RETURN, exec, $terminal"
            "$mainMod SHIFT, Q, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating,"
            "$mainMod, P, pseudo, # dwindle"
            # bind = $mainMod, J, togglesplit, # dwindle

            # Screenshots
            ''$mainMod, x, exec, grim -g "$(slurp)" - | swappy -f -''

            # Move focus with mainMod + arrow keys
            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"

            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # Example special workspace (scratchpad)
            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];

        windowrulev2 = [
         "suppressevent maximize, class:.* # You'll probably like this."   
        ];

        decoration = {
          rounding = 10;

         # Change transparency of focused and unfocused windows
         active_opacity = 1.0;
         inactive_opacity = 1.0;
 
         drop_shadow = true;
         shadow_range = 4;
         shadow_render_power = 3;
         "col.shadow" = "rgba(1a1a1aee)";
 
         # https://wiki.hyprland.org/Configuring/Variables/#blur
         blur = {
             enabled = true;
             size = 3;
             passes = 1;
     
             vibrancy = 0.1696;
         };
        };

    };
    
  };

  programs.waybar = {
    enable = true;
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 15px;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      /* you can set a style on hover for any module like this */
      #pulseaudio:hover {
          background-color: #a37800;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #power-profiles-daemon {
          padding-right: 15px;
      }

      #power-profiles-daemon.performance {
          background-color: #f53c3c;
          color: #ffffff;
      }

      #power-profiles-daemon.balanced {
          background-color: #2980b9;
          color: #ffffff;
      }

      #power-profiles-daemon.power-saver {
          background-color: #2ecc71;
          color: #000000;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
      }

      #network {
          background-color: #2980b9;
      }

      #network.disconnected {
          background-color: #f53c3c;
      }

      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #wireplumber {
          background-color: #fff0f5;
          color: #000000;
      }

      #wireplumber.muted {
          background-color: #f53c3c;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

      #privacy {
          padding: 0;
      }

      #privacy-item {
          padding: 0 5px;
          color: white;
      }

      #privacy-item.screenshare {
          background-color: #cf5700;
      }

      #privacy-item.audio-in {
          background-color: #1ca000;
      }

      #privacy-item.audio-out {
          background-color: #0069d4;
      }
    '';
    settings.mainBar = {
      layer = "top";
      position  = "top";
      height = 30;
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

    # TODO: Make the selected workspace glow or something
    "hyprland/window" = {
        icon = true;
    };

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
        format = "{:%H:%M}  ";
        format-alt = "{:%A, %B %d, %Y (%R)}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
            mode          = "year";
            mode-mon-col  = 3;
            weeks-pos     = "right";
            on-scroll     = 1;
            # TODO: Change these colors
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
        };
        actions =  {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
        };
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

    "backlight" = {
      format = "{percent}% {icon}";
      format-icons = ["" ""];
    };

    "battery" = {
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      # format-plugged = "{capacity}% ";
      # Empty label makes the widget disappear
      format-full = "";
      tooltip = "{timeTo}";
      format-icons = ["" "" "" "" ""] ;
    };

    "network" = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}" ;
    };

    "pulseaudio" = {
      # "scroll-step": 1, %, can be a float
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = ["" "" ""];
      };
      on-click = "pavucontrol" ;
    };

    # TODO: I still should write some scripts for this.
    # Maybe use rofi? https://github.com/Alexays/Waybar/wiki/Module:-Custom
    "custom/power" = {
      format = "⏻ ";
  		tooltip = false;
		};
    };
  };
}
