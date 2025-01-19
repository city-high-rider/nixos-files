# Configuration for waybar. A lot of this config was shamelessly stolen from
# https://github.com/theCode-Breaker/riverwm/blob/main/waybar/river/river_style.css
{ config, pkgs, ... }:
let csh = import ../beigegreen.nix;
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
        color: #a5adcb;
      }
      .modules-left,
      .modules-right,
      .modules-center {
        border-radius: 6px;
        background: #181926;
        padding: 12px 0;
      }
      tooltip {
        color: #a5adcb;
        background-color: #181926;
        text-shadow: none;
      }

      tooltip * {
        color: #a5adcb;
        text-shadow: none;
      }

      #custom-sep {
        color: #494d64;
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
        color: #5b6078;
        background: none;
        padding: 0;
      }
      #workspaces button:hover {
        color: #a6da95;
      }
      #workspaces button.active {
        color: #f5bde6;
      }
      #workspaces button.focused {
        color: #ff0000;
      }
      #temperature {
        color: #eed49f;
      }
      #cpu {
        color: #eed49f;
      }
      #memory {
        color: #eed49f;
      }
      #clock {
        font-weight: 600;
        color: #8bd5ca;
      }
      #custom-bluetooth_devices {
        color: #8aadf4;
      }
      #pulseaudio {
        color: #a6da95;
      }
      #pulseaudio.muted {
        color: #ed8796;
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
