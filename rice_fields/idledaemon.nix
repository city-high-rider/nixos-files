{ ... }: {
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
}
