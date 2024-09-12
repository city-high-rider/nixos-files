# Styling and configuration for Rofi, the application launcher.
{ config, pkgs, ... }:
let csh = import ../beigegreen.nix;
in {
  programs.rofi = {
    enable = true;
    # We have to specify the package here. Otherwise it will default to
    # the x11 rofi, and when you launch it, since it is being emulated
    # in a window, it will get tiled instead of popping up in the middle
    # of the screen.
    package = pkgs.rofi-wayland;
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg0 = mkLiteral "#${csh.base01}F2";
        bg1 = mkLiteral "#${csh.base02}";
        bg2 = mkLiteral "#${csh.base03}80";
        bg3 = mkLiteral "#${csh.primary}F2";
        fg0 = mkLiteral "#${csh.base06}";
        fg1 = mkLiteral "#${csh.base07}";
        fg2 = mkLiteral "#${csh.base04}";
        fg3 = mkLiteral "#${csh.base02}";

        font = "JetBrains Mono NF 12";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      "window" = {
        location = mkLiteral "center";
        width = mkLiteral "480";
        border-radius = mkLiteral "24px";

        background-color = mkLiteral "@bg0";
      };

      "mainbox" = { padding = mkLiteral "12px"; };

      "inputbar" = {
        background-color = mkLiteral "@bg1";
        border-color = mkLiteral "@bg3";

        border = mkLiteral "2px";
        border-radius = mkLiteral "16px";

        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = mkLiteral "[ prompt, entry]";
      };

      "prompt" = { text-color = mkLiteral "@fg2"; };

      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral "@fg3";
      };

      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "16px";
        border-color = mkLiteral "@bg2";
        background-color = mkLiteral "@bg2";
      };

      "textbox" = { padding = mkLiteral "8px 24px"; };

      "listview" = {
        background-color = mkLiteral "transparent";

        margin = mkLiteral "12px 0 0";
        lines = mkLiteral "8";
        columns = mkLiteral "1";

        fixed-height = mkLiteral "false";
      };

      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "16px";
      };

      "element normal active" = { text-color = mkLiteral "@bg3"; };

      "element alternate active" = { text-color = mkLiteral "@bg3"; };

      "element selected normal, element selected active" = {
        background-color = mkLiteral "@bg3";
      };

      "element-icon" = {
        size = mkLiteral "1em";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = { text-color = mkLiteral "inherit"; };
    };
  };
}
