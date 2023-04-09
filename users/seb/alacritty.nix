{ config, pkgs, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = {
          opacity = 0.2;
        }
    };
}