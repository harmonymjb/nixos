{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f8d95ecb-9780-4797-8797-f540ac2fa464";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/4523-B562";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/049c37c0-9539-4591-8c94-a0f57e1d6e76";
      fsType = "ext4";
    };

    "/data" = {
      device = "/dev/disk/by-uuid/b4935aae-13ab-441e-a835-4cfc83557edf";
      fsType = "ext4";
    };

    "/data2" = {
      device = "/dev/disk/by-uuid/899f1829-5651-47c7-8506-c923b3f303e3";
      fsType = "ext4";
    };

    "/data3" = {
      device = "/dev/disk/by-uuid/de589136-b1f7-429f-82a2-d09c8fc7ab2f";
      fsType = "ext4";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/6ded6a32-ddd2-47f4-9587-05e952c9a6c3"; }];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics = {
    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  hardware.steam-hardware.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.opentabletdriver.enable = true;

  virtualisation.containers.enable = true;
}
