{ config, pkgs, ... }:

{
    programs.fish = {
        enable = true;
        functions = {
            fish_greeting = "";
        };
        loginShellInit = ''
            if test (tty) = /dev/tty1 -a -z "$DISPLAY"
                Hyprland
            end
        '';
    };
}