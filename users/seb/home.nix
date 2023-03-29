{ config, pkgs, ... }:

{

  home.username = "seb";
  home.homeDirectory = "/home/seb";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    vscodium-fhs
    firefox
    alacritty
    wofi
    fira-code
    fish
  ];

  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = import ./hyprland.nix;
}

