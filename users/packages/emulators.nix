{ lib, pkgs, unstable-pkgs, ... }: {
  home.packages = with unstable-pkgs;
    [
      libretro.mame

      libretro.atari800 # atari 800
      libretro.hatari # atari st
      libretro.stella # atari 2600
      libretro.virtualjaguar # atari jaguar
      libretro.beetle-lynx # atari lynx

      libretro.mesen # nes
      libretro.bsnes # snes
      simple64 # n64
      libretro.dolphin # gamecube/wii
      cemu # wiiu
      ryujinx # switch
      libretro.sameboy # gb/gbc
      libretro.mgba # gba
      libretro.desmume # ds
      libretro.melonds # dsi
      libretro.citra # 3ds

      supermodel # sega model 3
      libretro.blastem # sega genesis/megadrive/cd/32x
      libretro.beetle-saturn # sega saturn
      libretro.flycast # dreamcast

      libretro.beetle-pce # PC Engine
      _86Box # x86
      fsuae # amiga

      duckstation # ps1
      libretro.pcsx2 # ps2
      shadps4 # ps4
      ppsspp-sdl-wayland # psp

      libretro.beetle-ngp # neo geo pocket

      xemu # xbox
    ] ++ (with pkgs; [
      vice # c64
      rpcs3 # ps3
    ]);
}
