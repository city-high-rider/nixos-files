{ config, ... }:
let csh = import ../colorschemes/redline.nix;
in {
  programs.niri.settings = {
    # I don't want screenshots to be saved to disk. Often I just
    # want to paste them somewhere. However, setting this path to
    # null will prevent the notification that pops up from showing
    # the preview :( Instead, I will set it to the same path each time,
    # some change
    # so subsequent screenshots override the old ones.
    screenshot-path = "~/Pictures/Screenshots/Screenshot.png";
    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "mako" ]; }
      { command = [ "swww-daemon" ]; }
      { command = [ "swww" "img" "~/Pictures/wallpapers/landscape.png" ]; }
      { command = [ "xwayland-satellite" ]; }
    ];
    window-rules = [{
      matches = [ { is-active = true; } { app-id = "kitty"; } ];
      draw-border-with-background = false;
      geometry-corner-radius = {
        top-left = 10.0;
        top-right = 10.0;
        bottom-left = 10.0;
        bottom-right = 10.0;
      };
      clip-to-geometry = true;
    }];
    # For xwayland-satellite.
    environment.DISPLAY = ":0";
    layout = {
      center-focused-column = "never";
      focus-ring = {
        width = 4;
        active.gradient = {
          angle = 45;
          in' = "srgb";
          from = "${csh.red}";
          to = "${csh.red}";
        };
        inactive.gradient = {
          angle = 45;
          in' = "srgb";
          from = "${csh.dark}";
          to = "${csh.darker}";
        };
      };
    };

    overview = {
      zoom = 0.5;
      backdrop-color = "#${csh.light}";

      workspace-shadow = {
        softness = 40;
        spread = 10;
        offset.x = 0;
        offset.y = 10;
        color = "${csh.darkest}50";
      };
    };

    switch-events = { lid-close.action.spawn = [ "loginctl" "lock-session" ]; };

    input.keyboard.xkb = {
      layout = "us,us";
      variant = "dvp,";
      options = "grp:alt_shift_toggle";
    };

    binds = with config.lib.niri.actions;
    # We can make an action that runs a bash command using partial
    # function application.
      let bsh = spawn "bash" "-c";
      in {
        # Volume keys
        "XF86AudioRaiseVolume".action =
          spawn [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        "XF86AudioLowerVolume".action =
          spawn [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        # Brightness keys
        # We have to do some jank with xargs, because notify-send doesn't accept pipe input
        "XF86MonBrightnessUp".action = bsh ''
          brightnessctl s +10% && brightnessctl g | xargs -I  {} notify-send -t 2000 "Brightness: {}"'';
        "XF86MonBrightnessDown".action = bsh ''
          brightnessctl s 10%- && brightnessctl g | xargs -I  {} notify-send -t 2000 "Brightness: {}"'';

        "Mod+E".action = spawn "fuzzel";
        "Mod+U".action = spawn "kitty";
        # This locks the screen. The 'pidof' part is there to avoid
        # launching multiple instances of it.
        "Mod+Alt+L".action = bsh "pidof hyprlock || hyprlock";

        "Mod+Shift+E".action = quit { skip-confirmation = false; };

        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+Semicolon".action = spawn [ "wl-kbptr" ];

        "Mod+Q".action = close-window;

        "Mod+Tab".action = toggle-overview;

        # NOTE: I am using delete key instead of home
        # because my keyboard layout is fucking weird

        # Window focus
        "Mod+D".action = focus-column-left;
        "Mod+H".action = focus-workspace-down;
        "Mod+T".action = focus-workspace-up;
        "Mod+N".action = focus-column-right;
        "Mod+Delete".action = focus-column-first;
        "Mod+End".action = focus-column-last;

        # Monitor focus
        "Mod+Ctrl+D".action = focus-monitor-left;
        "Mod+Ctrl+H".action = focus-monitor-down;
        "Mod+Ctrl+T".action = focus-monitor-up;
        "Mod+Ctrl+N".action = focus-monitor-right;

        # Window moving
        "Mod+Shift+D".action = move-column-left;
        "Mod+Shift+H".action = move-column-to-workspace-down;
        "Mod+Shift+T".action = move-column-to-workspace-up;
        "Mod+Shift+N".action = move-column-right;

        # Monitor moving
        "Mod+Ctrl+Shift+D".action = move-column-to-monitor-left;
        "Mod+Ctrl+Shift+H".action = move-window-to-monitor-down;
        "Mod+Ctrl+Shift+T".action = move-window-to-monitor-up;
        "Mod+Ctrl+Shift+N".action = move-column-to-monitor-right;

        # Consuming / expelling
        "Mod+Comma".action = consume-or-expel-window-left;
        "Mod+Period".action = consume-or-expel-window-right;
        "Mod+Alt+H".action = move-window-down;
        "Mod+Alt+T".action = move-window-up;

        # Resizing
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        # Move the focused window between the floating and the tiling layout.
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        # Screenshotting
        # "Print".action = screenshot;
        # "Ctrl+Print".action = screenshot-screen;
        # "Alt+Print".action = screenshot-window;

        # Take whatever's in the clipboard and open it in swappy.
        # This is useful for annotating screenshots. You can remember it
        # like this : the Mod+A stands for "annotate."
        "Mod+A".action = bsh "wl-paste -t image | swappy -f -";

        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+P".action = power-off-monitors;

      };
  };
}
