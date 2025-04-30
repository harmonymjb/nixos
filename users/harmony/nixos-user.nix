{ lib, pkgs, username, userPubkey, ... }: {
  users.users.${username} = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ userPubkey ];
    extraGroups = [ "wheel" ];
  };
}
