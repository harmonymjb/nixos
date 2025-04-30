{ lib, pkgs, username, ... }: {
  sops = {
    defaultSopsFile = ./${username}/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  };
}
