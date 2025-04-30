{
  description = "nixos + home-manager config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05?shallow=1";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable?shallow=1";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url =
      "github:nix-community/home-manager/release-25.05?shallow=1";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    chemacs2nix.url = "github:league/chemacs2nix";
  };

  outputs = { self, ... }@inputs:
    let

      hostName = "jupiter";
      username = "harmony";

      userEmail = "harmony@evangelina.ca";
      userFullName = "Harmony Evangelina";
      userPubkey =
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkdACfdDWWBaaYqRwEKvwa/7STKLSQgKL72mCSP1N4cGh1tdA2Vbw5oqDJlYEi/+Gx+gN8rBZpUDUeRW1s7cIc2mZgh5E9AM5ImAN6QOEEg47I++s4qOG6ZGYytQTpiNo9rGJUPOBhxr74ceUmwX+lI8ilbwiHVIGABq6oIpn2uNdiVQJiTHHduV/wj+7rpbhCwqEwgVT7+O+k2PhcP8wIS8i4iWdw1ORjk01QFrE9ZT6zKeKbIG/XCI4hXjt48lcaPE8Lahuae18yuT5lq2CDD4Hg+gP7YgcC/H2zzRVw3KSRLIpGjp4Cv8kOTljD0tsa8M+vuAhX6DIrPiO6TRhts+SgJ6MyvtdhOqRQa0THA0DHSmlGXnIAD4N/qTs/f6isagIcDfihqAxMp4ORTwvh+K3ici6y3zaAc+j+Phqm5LQ6kFpDFBYMbPzxi0pDSwbkXdemGHVJuWJtPFmC+B1FsIjaAJbo1DHjgtblvPJypxvefdbY7JOchHUmbqBP9wU= erinbwork@jupiter";

      inherit (self) outputs;
      pkgs = import inputs.nixpkgs {
        overlays = [
          # If you want to use overlays exported from other flakes:
          # neovim-nightly-overlay.overlays.default

          # Or define it inline, for example:
          # (final: prev: {
          #   hi = final.hello.overrideAttrs (oldAttrs: {
          #     patches = [ ./change-hello-to-hi.patch ];
          #   });
          # })
        ];
        system = "x86_64-linux";
        config.allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      unstable-pkgs = import inputs.nixpkgs-unstable {
        overlays = [ ];
        system = "x86_64-linux";
        config.allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    in {
      nixosConfigurations = {
        ${hostName} = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs pkgs unstable-pkgs hostName
              username userEmail userPubkey;
          };
          modules = [
            inputs.sops-nix.nixosModules.sops
            ./nixos/sops.nix
            ./nixos/services/qbittorrent.nix
            ./nixos/${hostName}.nix
          ];
        };
      };

      homeConfigurations = {
        "${username}@${hostName}" =
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs;
            extraSpecialArgs = {
              inherit inputs outputs unstable-pkgs username userEmail
                userFullName;
            };
            modules = [
              inputs.chemacs2nix.homeModule
              inputs.sops-nix.homeManagerModule
              ./users/sops.nix
              ./users/${username}.nix
            ];
          };
      };
    };
}
