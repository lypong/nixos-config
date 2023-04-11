{
  config,
  pkgs,
  ...
}: {
  home.file."wallpapers/wallpaper.jpg".source = builtins.fetchurl {
    url = "https://images3.alphacoders.com/120/1207488.jpg";
    sha256 = "18gsak4qdvxsjcz5v77yvd8hqg6nlykjpa12zbjp6s07akrlvqs1";
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/wallpapers/wallpaper.jpg
    wallpaper = eDP-1,${config.home.homeDirectory}/wallpapers/wallpaper.jpg
  '';
}
