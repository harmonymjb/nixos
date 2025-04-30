{ lib, pkgs, ... }: {
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    xserver.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
    desktopManager.plasma6.enable = true;
  };

  programs = {
    xwayland.enable = true;
    steam.enable = true;
    steam.gamescopeSession.enable = true;
  };

  virtualisation.waydroid.enable = true;
}
