{ lib, pkgs, hostName, username, ... }: {
  sops = {
    defaultSopsFile = ./${hostName}/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  };
}
