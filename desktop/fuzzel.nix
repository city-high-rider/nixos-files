{ ... }:
let csh = import ../colorschemes/redline.nix;
in {
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = "ComicNeue:size=32";
      use-bold = "yes";
      dpi-aware = "no";
      prompt = "I want a...	";
      hide-before-typing = "yes";
      show-actions = "yes";
      width = "24";
      horizontal-pad = "40";
      vertical-pad = "8";
      inner-pad = "10";
      image-size-ratio = "0.5";
    };
    colors = {
      background = "${csh.lightest}ff";
      text = "${csh.darker}ff";
      prompt = "${csh.red}ff";
      # placeholder = "";
      input = "${csh.darker}ff";
      match = "${csh.red}ff";
      selection = "${csh.light}ff";
      selection-text = "${csh.dark}ff";
      selection-match = "${csh.red}ff";
      border = "${csh.orange}ff";
    };
    border.width = "5";
    border.radius = "10";
  };
}
