# Configuration for waybar. A lot of this config was shamelessly stolen from
# https://github.com/theCode-Breaker/riverwm/blob/main/waybar/river/river_style.css
{config,pkgs,...} : let
  csh = import ../beigegreen.nix;
in {
  programs.waybar = {
    enable = true;
    style = ''
* {
	border: none;
	border-radius: 10;
    font-family: "JetbrainsMono Nerd Font" ;
	font-size: 15px;
	min-height: 10px;
}

window#waybar {
	background: transparent;
}

window#waybar.hidden {
	opacity: 0.2;
}

#window {
	margin-top: 6px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
    color: transparent;
	background: transparent;
}

#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #${csh.base06};
	transition: none;
}

#tags button {
	transition: none;
	color: #B5E8E0;
	background: transparent;
	font-size: 16px;
	border-radius: 2px;
}

#tags button.occupied {
	transition: none;
	color: #F28FAD;
	background: transparent;
	font-size: 4px;
}

#tags button.focused {
	color: #ABE9B3;
    border-top: 2px solid #ABE9B3;
    border-bottom: 2px solid #ABE9B3;
}

#tags button:hover {
	transition: none;
	box-shadow: inherit;
	text-shadow: inherit;
	color: #FAE3B0;
    border-color: #E8A2AF;
    color: #E8A2AF;
}

#tags button.focused:hover {
    color: #E8A2AF;
}


.modules-right {
  padding-left: 5px;
	padding-right: 5px;
  border-radius: 15px 0 0 15px;
  margin-top: 2px;
  background: rgba(0,0,0,0.4);
}

.modules-left {
  padding-left: 5px;
	padding-right: 5px;
  border-radius: 0 15px 15px 0;
  margin-top: 2px;
  background: rgba(0,0,0,0.4);
}

#workspaces {
	border: 2px solid #${csh.primary};
	border-radius: 10px;
	background-color: #${csh.base07};
}

#workspaces button {
    padding: 0 5px;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.active {
	background-color: #${csh.secondary};
}

#workspaces button.focused {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#network {
	margin-top: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 3px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base02};
}

#pulseaudio {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base03};
}


#temperature {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base01};
}

#battery {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #B5E8E0;
}

#battery.charging, #battery.plugged {
	color: #${csh.base06};
    background-color: #B5E8E0;
}

#battery.critical:not(.charging) {
    background-color: #B5E8E0;
    color: #${csh.base06};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

@keyframes blink {
    to {
        background-color: #BF616A;
        color: #B5E8E0;
    }
}

#backlight {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base00};
}
#clock {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.primaryLighter};
	/*background: #1A1826;*/
}

#memory {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base03};
}
#cpu {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.base02};
}

#tray {
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #B5E8E0;
	background: #${csh.base06};
}

#custom-power {
	font-size: 20px;
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: 8px;
	margin-right: 8px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #${csh.base06};
	background: #${csh.primaryLighter};
}
    '';
    # TODO: Make the buttons have a cool effect on hover / press.
    settings.mainBar = {
      layer = "top";
      position  = "top";
      height = 30;
      spacing = "4px";
      modules-left = [
        "custom/power"
        "cpu"
        "memory"
        "tray"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        # "idle_inhibitor"
        "pulseaudio"
        "network"
        "temperature"
        "backlight"
        "battery"
        "clock"
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

    "custom/power" = {
      format = "⏻";
  		tooltip = false;
			on-click = ''
				rofi -show session-menu -modi "session-menu:rofi-power-menu --choices=shutdown/reboot/logout/lockscreen"
			'';
		};
    };
  };
}
