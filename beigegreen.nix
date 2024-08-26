# Attribute set with some colors so I can pass it into config files
rec {
  # Base16 color themes go like this:
  # For light-mode: 00-07 is light tones -> dark tones
  # 08 -> red
  # 09 -> orange
  # 0A -> yellow
  # 0B -> green
  # 0C -> blue/cyan
  # 0D -> blue
  # 0F -> purple
  # 0E -> brown

  # The colors are in hex.
  base00 = "FEFCBA";
  base01 = "FFF9A1";
  base02 = "EDDD75";
  base03 = "DBC97F";
  base04 = "9E5E33";
  base05 = "9F7D51";
  base06 = "44200B";
  base07 = "554f43";
  base08 = "FB4934";
  base09 = "FE8019";
  base0A = "FABD2F";
  base0B = "A4A53C";
  base0C = "80B1B0"; 
  base0D = "2980B9";
  base0E = "D3869B";
  base0F = "D65D0E";

  # This is for which colors we would actually like to be using.
  # I want the primary color to be green, and the secondary to be cyan.
  # The neon ones are used when you really need to stand out, such as on hyprland borders
  primary = base0B;
  primaryNeon = "95ED42";
  secondary = base0C; 
  secondaryNeon = "49C7E3";
}
