{ config, pkgs, ... }:

let setupFirefox = import ./firefox.nix;
in
{

  home.username = "seb";
  home.homeDirectory = "/home/seb";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    vscodium-fhs
    firefox
    alacritty
    wofi
    fish
    waybar
  ];

  programs.home-manager.enable = true;
  programs.fish = import ./fish.nix;
  wayland.windowManager.hyprland = import ./hyprland.nix;

  programs.firefox = setupFirefox config;

  programs.waybar.enable = true;

}

