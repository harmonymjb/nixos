{ lib, pkgs, unstable-pkgs, ... }: {
  home.packages = with unstable-pkgs; [ age gnupg sops ] ++ (with pkgs; [ ]);

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      default-cache-ttl 3600
    '';
  };

  services.ssh-agent.enable = true;
}
