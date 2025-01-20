rec {
  # Base16 color themes go like this:
  # For light-mode: 00-07 is light tones -> dark tones
  # 08 -> red
  # 09 -> orange
  # 0A -> yellow
  # 0B -> green
  # 0C -> blue/cyan
  # 0D -> blue
  # 0E -> brown
  # 0F -> purple

  # The colors are in hex.
  base00 = "FFF7C3";
  base01 = "FEF4AB";
  base02 = "FEEF87";
  base03 = "E4DCB2";
  base04 = "7A7070";
  base05 = "5F5560";
  base06 = "271D43";
  base07 = "0F042E";
  base08 = "B4002D";
  base09 = "F75147";
  base0A = "FFDE75";
  base0B = "A3D794";
  base0C = "526688";
  base0D = "4165BE";
  base0E = "5C211C";
  base0F = "65466E";

  # This is for which colors we would actually like to be using.
  # I want the primary color to be green, and the secondary to be cyan.
  # The neon ones are used when you really need to stand out, such as on hyprland borders
  primary = base08;
  primaryLighter = "E02F4F";
  primaryNeon = "FF0F4B";
  secondary = base0C;
  secondaryLighter = "7B8FAF";
  secondaryNeon = "49C7E3";
}
