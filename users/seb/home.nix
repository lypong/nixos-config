{ config, pkgs, ... }:

let 
  setupFirefox = import ./firefox.nix;
  setupHyprpaper = import ./hyprpaper.nix;
  setupFish = import ./fish.nix;
  setupHyprland = import ./hyprland.nix;
  setupWaybar = import ./waybar.nix;
  setupAlacritty = import ./alacritty.nix;
in
{
  imports = [
    setupHyprpaper
    setupFirefox
    setupFish
    setupHyprland
    setupWaybar
    setupAlacritty
  ];
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
    hyprpaper
  ];

  programs.home-manager.enable = true;

}

