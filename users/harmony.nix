{ inputs, lib, config, pkgs, unstable-pkgs, username, userFullName, userEmail
, ... }: {
  imports = [
    ./${username}/sops-secrets.nix
    ./${username}/emacs.nix
    ./packages/emulators.nix
    ./packages/gui.nix
    ./packages/cli.nix
    ./packages/encryption.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
