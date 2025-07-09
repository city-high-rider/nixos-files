{ _, pkgs, ... }: {

  # The configs for different software/usecases live in their own files. Import them all here.
  imports = [
    ./desktop/cursor.nix
    ./desktop/fuzzel.nix
    ./desktop/idledaemon.nix
    ./desktop/lockscreen.nix
    ./desktop/niri.nix
    ./desktop/notifications.nix
    ./desktop/waybar.nix

    ./tools/music-player.nix
    ./tools/helix.nix
    ./tools/terminal.nix
    ./tools/vcs.nix
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
