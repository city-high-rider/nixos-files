{ config, pkgs, ... }:
let
  csh = import ../beigegreen.nix;
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww init &
    ${pkgs.swww}/bin/swww img "~/wallpapers/cat-butterfly.jpg" &
  '';
in {
  wayland.windowManager.hyprland = {
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
      "$menu" = ''
        rofi -show combi -modes combi -combi-modes "window,drun" -show-icons -display-combi "I want a ..."'';

      exec-once = "${startupScript}/bin/start";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        # "ELECTRON_OZONE_PLATFORM_HINT,auto"
        # "LIBVA_DRIVER_NAME,nvidia"
        # "XDG_SESSION_TYPE,wayland"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      cursor = { no_hardware_cursors = true; };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        "col.active_border" =
          "rgba(${csh.primaryNeon}ee) rgba(${csh.secondaryNeon}ee) 45deg";
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
        pseudotile =
          true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = { new_status = "master"; };

      misc = {
        force_default_wallpaper =
          -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo =
          false; # If true disables the random hyprland logo / anime girl background. :(
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
        # Volume keys for the laptop
        # The -l flag is limit. I don't want to exceed 100%.
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        # bind = $mainMod, J, togglesplit, # dwindle

        # Go fullscreen
        "$mainMod, F, Fullscreen"

        # Screenshots
        ''$mainMod, x, exec, grim -g "$(slurp)" - | swappy -f -''

        # Move focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move windows around with mod+shift
        "$mainMod SHIFT, h, movewindoworgroup, l"
        "$mainMod SHIFT, l, movewindoworgroup, r"
        "$mainMod SHIFT, k, movewindoworgroup, u"
        "$mainMod SHIFT, j, movewindoworgroup, d"

        "$mainMod, a, togglegroup"
        "$mainMod, u, togglefloating"

        # Switch and move in groups with mod i and o.
        "$mainMod, i, changegroupactive, b"
        "$mainMod, o, changegroupactive, f"
        "$mainMod SHIFT, i, movegroupwindow, b"
        "$mainMod SHIFT, o, movegroupwindow, f"

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

      bindl = [
        # Lock screen when laptop lid is closed.
        ",switch:Lid Switch, exec, loginctl lock-session"
        # turn off laptop screen when we close the lid.
        ''
          ,switch:on:Lid Switch, exec, hyprctl keyword monitor "eDP-1, disable"
        ''
        # And turn it back on when we open it.
        ''
          ,switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1,1920x1080,0x0,1"
        ''
      ];

      windowrulev2 =
        [ "suppressevent maximize, class:.* # You'll probably like this." ];

      group.groupbar = {
        text_color = "0xff${csh.base07}";
        font_size = 10;
        "col.active" = "0xff${csh.primaryLighter}";
        "col.inactive" = "0xff${csh.secondaryLighter}";
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

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
}
