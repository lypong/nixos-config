{ config, pkgs, ... }:

let setupFirefox = import ./firefox.nix;
in
{
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        src = super.fetchFromGitHub {
          owner = "Alexays";
          repo = "Waybar";
          rev = "0.9.16";
          sha256 = "sha256-hcU0ijWIN7TtIPkURVmAh0kanQWkBUa22nubj7rSfBs=";
        };
        patches = [ ./waybar-hypr-workspace.patch ];
      });
    })
  ];
  modules = [./hyprpaper.nix];
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
  programs.fish = import ./fish.nix;
  wayland.windowManager.hyprland = import ./hyprland.nix;

  programs.firefox = setupFirefox config;


  #programs.waybar.enable = true;
  #programs.waybar.settings.modules-right = [ "custom/power" ];
  programs.waybar = {
    systemd.enable = true;
    enable = true;
    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      tray = { spacing = 10; };
      modules-center = [ ];
      modules-left = [ "wlr/workspaces" ];
      modules-right = [
        #"pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "clock"
        "custom/poweroff"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      "wlr/workspaces" = { on-click = "activate"; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
      "custom/poweroff" = { format = ""; on-click = "poweroff"; };
    }];
  };

  programs.waybar.style = ''
    * {
  font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
 }
  font-* {
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
  }

window#waybar {
    background-color: transparent;
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button {
    padding: 0 5px;
    background-color: #bc9ef2;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.active {
    background-color: #bfa6ed;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    border-bottom: 3px solid #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#mpd,
#custom-poweroff {
    padding: 0 10px;
    margin: 0 10px;
    color: #ffffff;
    background-color: #bc9ef2;
    border-radius: 26px;
}


  '';

  home.file."wallpapers/wallpaper.jpg".source = builtins.fetchurl {
    url = "https://images3.alphacoders.com/120/1207488.jpg";
    sha256 = "18gsak4qdvxsjcz5v77yvd8hqg6nlykjpa12zbjp6s07akrlvqs1";
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/wallpapers/wallpaper.jpg
    wallpaper = eDP-1,${config.home.homeDirectory}/wallpapers/wallpaper.jpg
  '';

}

