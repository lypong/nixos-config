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
    fira-code
    fish
  ];

  programs.home-manager.enable = true;
  programs.fish = import ./fish.nix;
  wayland.windowManager.hyprland = import ./hyprland.nix;

  programs.firefox = setupFirefox config;

  programs.firefox.profiles.default = {
    extensions = with config.nur.repos.rycee.firefox-addons; [
      ublock-origin
    ];
  };
}

