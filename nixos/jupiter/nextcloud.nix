{ lib, pkgs, unstable-pkgs, userEmail, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  security.acme.acceptTerms = true;
  security.acme.defaults.email = userEmail;

  services = {
    nextcloud = {
      enable = false;
      # config.adminpassFile = "/run/secrets/nextcloud-admin-pass";
      # home = "/data2/nextcloud";

      package = unstable-pkgs.nextcloud31;
      hostName = "home.hamnix.ca";
      https = true;
      configureRedis = true;
      database.createLocally = true;
      config.dbtype = "mysql";
      maxUploadSize = "2G";
      extraApps = with unstable-pkgs.nextcloud31Packages.apps; {
        inherit bookmarks calendar contacts forms memories notes tasks;
      };
      extraAppsEnable = true;
    };

    nginx = {
      enable = false;

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      # Setup Nextcloud virtual host to listen on ports
      virtualHosts = {
        "home.hamnix.ca" = {
          ## Force HTTP redirect to HTTPS
          forceSSL = true;
          ## LetsEncrypt
          enableACME = true;
        };
      };
    };
  };
}
