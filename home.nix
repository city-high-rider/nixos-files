{ _, pkgs, ... }: {

  # The configs for different software/usecases live in their own files. Import them all here.
  imports = [
    ./rice_fields/fuzzel.nix
    ./rice_fields/helix.nix
    ./rice_fields/hyprland.nix
    ./rice_fields/idledaemon.nix
    ./rice_fields/lockscreen.nix
    ./rice_fields/niri.nix
    ./rice_fields/notifications.nix
    ./rice_fields/terminal.nix
    ./rice_fields/vcs.nix
    ./rice_fields/waybar.nix
    ./music-player.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
    stateVersion = "24.05";
  };

  xdg.userDirs.enable = true;
  fonts.fontconfig.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

}
