{ hostName, unstable-pkgs, username, ... }: {
  imports = [
    ./nix.nix
    ./${hostName}/sops-secrets.nix
    ./${hostName}/hardware.nix
    ./${hostName}/boot.nix
    ./${hostName}/ssh.nix
    ./${hostName}/gui.nix
    ./${hostName}/plex-etc.nix
    ./${hostName}/nextcloud.nix
    ../users/${username}/nixos-user.nix
  ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.1.0";
    loadModels = [ "qwen3:30b-a3b" "mistral-small3.1" ];
    package = unstable-pkgs.ollama;
  };

  networking.hostName = hostName;
  time.timeZone = "Canada/Pacific";
  i18n.defaultLocale = "en_US.UTF-8";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
