{
  config,
  pkgs,
  ...
}: let
  setupHyprland = import ./hyprland.nix;
  setupWaybar = import ./waybar.nix;
  setupHyprpaper = import ./hyprpaper.nix;
in {
  imports = [
    setupHyprpaper
    setupHyprland
    setupWaybar
  ];

  home.packages = with pkgs; [
    wofi
    hyprpaper
    waybar
  ];
}
