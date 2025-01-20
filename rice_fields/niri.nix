{ config, ... }:
let csh = import ./beigegreen.nix;
in {
  programs.niri.settings = {
    spawn-at-startup =
      [ { command = [ "waybar" ]; } { command = [ "mako" ]; } ];
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

        "Mod+D".action = spawn "fuzzel";
        "Mod+Return".action = spawn "kitty";

        "Mod+Shift+E".action = quit { skip-confirmation = false; };

        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+Q".action = close-window;

        # NOTE: I am using delete key instead of home
        # because my keyboard layout is fucking weird

        # Window focus
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;
        "Mod+Delete".action = focus-column-first;
        "Mod+End".action = focus-column-last;

        # Monitor focus
        "Mod+Ctrl+H".action = focus-monitor-left;
        "Mod+Ctrl+J".action = focus-monitor-down;
        "Mod+Ctrl+K".action = focus-monitor-up;
        "Mod+Ctrl+L".action = focus-monitor-right;

        # Window moving
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+Delete".action = move-column-to-first;
        "Mod+Shift+End".action = move-column-to-last;

        # Monitor moving
        "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
        "Mod+Ctrl+Shift+J".action = move-window-to-monitor-down;
        "Mod+Ctrl+Shift+K".action = move-window-to-monitor-up;
        "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;

        # Workspace switching
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+0".action = focus-workspace 10;
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;

        # Workspace window moving 
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;
        "Mod+Shift+0".action = move-column-to-workspace 10;
        "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
        "Mod+Shift+Page_Up".action = move-column-to-workspace-up;

        # Consuming / expelling
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

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
        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;

        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+P".action = power-off-monitors;

      };
  };
}
