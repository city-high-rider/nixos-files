{ ... }:
let csh = import ../beigegreen.nix;
in {
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = "JetBrains Mono NF:size=22";
      use-bold = "yes";
      dpi-aware = "no";
      prompt = "I want a... ";
    };
    colors = {
      background = "{csh.base01}f2";
      prompt = "${csh.primary}f2";
      selection-match = "${csh.secondary}f2";
      match = "${csh.secondary}f2";
      text = "${csh.base07}f2";
      input = "${csh.base06}f2";
      selection-text = "${csh.base07}f2";
    };
  };
}
