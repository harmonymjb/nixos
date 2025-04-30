{ config, lib, pkgs, unstable-pkgs, username, ... }: {
  services.bazarr = {
    enable = true;
    openFirewall = true; # 6767
    user = username;
  };

  services.radarr = {
    enable = true;
    openFirewall = true; # 7878
    user = username;
  };

  services.lidarr = {
    enable = true;
    openFirewall = true; # 8686
    user = username;
  };

  services.readarr = {
    enable = true;
    openFirewall = true; # 8787
    user = username;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true; # 8989
    user = username;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true; # 9696
  };

  services.plex = {
    enable = true;
    openFirewall = true; # 32400
    # extraPlugins = [ifdbPlugin audnexusPlugin];
    user = username;
    package = unstable-pkgs.plex;
  };

  services.qbittorrent = {
    enable = true;
    port = 58080;
    openFirewall = true;
    user = username;
  };
}
