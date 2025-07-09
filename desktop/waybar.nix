# Configuration for waybar. A lot of this config was shamelessly stolen from
# https://github.com/theCode-Breaker/riverwm/blob/main/waybar/river/river_style.css
{ config, pkgs, ... }:
let csh = import ../colorschemes/firewatch.nix;
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
        color: #${csh.primaryLighter};
      }
      .modules-left,
      .modules-right,
      .modules-center {
        border-radius: 6px;
        background: #${csh.base01};
        padding: 12px 0;
      }
      tooltip {
        color: #a5adcb;
        background-color: #${csh.base01};
        text-shadow: none;
      }

      tooltip * {
        color: #${csh.primaryLighter};
        text-shadow: none;
      }

      #custom-sep {
        color: #${csh.base04};
        margin: 4px 0;
      }
      #workspaces,
      #clock,
      #custom-bluetooth_devices,
      #custom-powermenu,
      #pulseaudio,
      #tray {
      }
      #workspaces {
        border-radius: 4px;
      }
      #workspaces button {
        color: #${csh.primaryLighter};
        background: none;
        padding: 0;
      }
      #workspaces button:hover {
        color: #${csh.base0B};
      }
      #workspaces button.active {
        color: #${csh.base0A};
      }
      #workspaces button.focused {
        color: #${csh.base08};
      }
      #workspaces button.empty {
        color: #${csh.base06};
      }
      #temperature {
        color: #${csh.base05};
      }
      #cpu {
        color: #${csh.base06};
      }
      #memory {
        color: #${csh.base07};
      }
      #clock {
        font-weight: 600;
        color: #${csh.secondary};
      }
      #custom-bluetooth_devices {
        color: #8aadf4;
      }
      #pulseaudio {
        color: #${csh.base0F};
      }
      #pulseaudio.muted {
        color: #${csh.base05};
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
      spacing = 2;
      modules-left = [ "clock" "custom/sep" "battery" "custom/sep" "tray" ];
      modules-center = [ "niri/workspaces" ];
      modules-right = [
        "cpu"
        "custom/sep"
        "memory"
        "custom/sep"
        "temperature"
        "custom/sep"
        "pulseaudio"
      ];
      "custom/sep" = { format = ""; };
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          urgent = "";
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
