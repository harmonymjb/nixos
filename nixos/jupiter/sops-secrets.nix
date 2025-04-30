{ lib, pkgs, ... }: {
  sops.secrets = {
    example-key = { };
    ex2 = { };
  };
}
