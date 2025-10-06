# Configuration for waybar. A lot of this config was shamelessly stolen from
# https://github.com/theCode-Breaker/riverwm/blob/main/waybar/river/river_style.css
{ ... }:
let
  csh = import ../colorschemes/redline.nix;
  blends = {
    pink2peach = [ "FCA6AD" "FAA598" "F7A584" "F5A46F" ];
    crimson2yellow = [ "911015" "B24628" "D37C3B" "F4B24E" ];
  };
in {
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        font-family: "Hack", "Font Awesome 6 Pro";
        font-size: 14px;
        font-weight: 600;
        background: none;
      }

      window#waybar {
        color: #${csh.lighter};
      }
      .modules-right {
        border-radius: 6px;
        padding: 4px 4px 0 0;
        margin-top: 8px;
        background: #${csh.lighter};
      }
      .modules-left {
        border-radius: 6px;
        background: #${csh.lighter};
        margin-bottom: 8px;
        padding: 0 4px 4px 0;
      }
      .modules-center {
        border-radius: 6px;
        background: #${csh.light};
        padding: 4px 4px 0 0;
      }
      tooltip {
        color: #a5adcb;
        background-color: #${csh.lighter};
        text-shadow: none;
      }

      tooltip * {
        color: #${csh.red};
        text-shadow: none;
      }

      #custom-sep0 {
        color: #${builtins.elemAt blends.pink2peach 3};
        background: #${builtins.elemAt blends.pink2peach 2};
        margin: 0;
        padding: 0 0 4 0;
      }

      #custom-sep1 {
        color: #${builtins.elemAt blends.pink2peach 2};
        background: #${builtins.elemAt blends.pink2peach 0};
        margin: 0;
        padding: 0 0 4 0;
      }
      #clock {
        background: #${builtins.elemAt blends.pink2peach 3};
        color: #${csh.lightest};
        font-weight: 600;
        border-radius: 4px 4px 0 0;
        margin: 0;
      }
      #battery {
        background: #${builtins.elemAt blends.pink2peach 2};
        color: #${csh.lightest};
      }
      #custom-bluetooth_devices,
      #custom-powermenu,
      #pulseaudio {}
      #tray {
        background: #${builtins.elemAt blends.pink2peach 0};
        padding-bottom: 2px;
        border-radius: 0 0 4px 4px;
      }
      #tray menu menuitem:hover {
        color: #${csh.red};
        background: #${csh.light};
        border: 2px solid #${csh.red};
      }
      #tray menu {
        background: #${csh.lightest};
        border: 2px solid #${csh.red};
        color: #${csh.darker};
        border-radius: 4px;
      }
      #workspaces {
        border-radius: 6px;
        background: #${csh.lighter};
      }
      #workspaces button {
        background: none;
        padding: 0;
        color: #${csh.dark};
      }
      #workspaces button.focused {
        color: #${csh.red};
      }
      #cpu {
        color: #${csh.lightest};
        background: #${builtins.elemAt blends.crimson2yellow 3};
      }
      #custom-sep2 {
        color: #${builtins.elemAt blends.crimson2yellow 3};
        background: #${builtins.elemAt blends.crimson2yellow 2};
        margin: 0;
        padding: 0 0 4 0;
      }
      #memory {
        color: #${csh.lightest};
        background: #${builtins.elemAt blends.crimson2yellow 2};
      }
      #custom-sep3 {
        color: #${builtins.elemAt blends.crimson2yellow 2};
        background: #${builtins.elemAt blends.crimson2yellow 1};
        margin: 0;
        padding: 0 0 4 0;
      }
      #temperature {
        color: #${csh.lightest};
        background: #${builtins.elemAt blends.crimson2yellow 1};
      }
      #custom-sep4 {
        color: #${builtins.elemAt blends.crimson2yellow 1};
        background: #${builtins.elemAt blends.crimson2yellow 0};
        margin: 0;
        padding: 0 0 4 0;
      }
      #pulseaudio {
        color: #${csh.lightest};
        background: #${builtins.elemAt blends.crimson2yellow 0};
        padding: 0 0 4px 0;
      }
      #pulseaudio.muted {
        color: #${csh.lightest};
        background: #${builtins.elemAt blends.crimson2yellow 0};
        padding: 0 0 4px 0;
      }
      #custom-bluetooth_devices {
        color: #${csh.darkest};
      }

      #custom-powermenu {
        margin: 12px 0 0 0;
        color: #6e738d;
      }
    '';
    settings.mainBar = {
      layer = "top";
      position = "left";
      width = 28;
      margin = "2 0 2 2";
      spacing = 0;
      modules-left = [ "clock" "custom/sep0" "battery" "custom/sep1" "tray" ];
      modules-center = [ "niri/workspaces" ];
      modules-right = [
        "cpu"
        "custom/sep2"
        "memory"
        "custom/sep3"
        "temperature"
        "custom/sep4"
        "pulseaudio"
      ];
      "custom/sep0" = {
        format = "";
        rotate = 270;
      };
      "custom/sep1" = {
        format = "";
        rotate = 270;
      };
      "custom/sep2" = {
        format = "";
        rotate = 270;
      };
      "custom/sep3" = {
        format = "";
        rotate = 270;
      };
      "custom/sep4" = {
        format = "";
        rotate = 270;
      };
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "󰮔";
          urgent = "󰀨";
          default = "";
        };
      };
      clock = {
        tooltip = true;
        format = ''
          {:%H
          %M}'';
        tooltip-format = "{:%Y-%m-%d}";
      };
      tray = {
        icon-size = 18;
        show-passive-items = "true";
        spacing = 4;
      };
      temperature = {
        rotate = 90;
        hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
        critical-threshold = 80;
        format = "{icon} {temperatureC}°C";
        format-icons = [ "" "" "" ];
      };
      cpu = {
        rotate = 90;
        format = "{usage}%   ";
      };
      memory = {
        rotate = 90;
        format = "{}%  ";
      };
      pulseaudio = {
        rotate = 90;
        format = "{icon}   {volume}%";
        format-bluetooth = "{icon}   {volume}%";
        format-muted = "MUTE ";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
      };
      battery = {
        rotate = 90;
        format = "{icon}  {capacity}";
        format-charging = "{icon}  {capacity}";
        tooltip = "{timeTo}";
        format-icons = [ "" "" "" "" "" ];
      };
      scroll-step = 3;
      on-click = "pavucontrol";
      on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    };
  };
}
