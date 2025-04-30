{ lib, pkgs, unstable-pkgs, ... }: {
  home.packages = with unstable-pkgs;
    [
      # fonts
      ibm-plex
      noto-fonts-color-emoji
      # gui apps
      alacritty
      czkawka
      discord
      firefox-devedition-bin
      libsForQt5.plasma-browser-integration
      mupdf
      nextcloud-client
      obs-studio
      pinentry-qt
      protonmail-desktop
      signal-desktop-bin
      slack
      spotify

      # graphics/design
      blender
      fontforge-gtk
      gimp
      inkscape
      kdePackages.calligra
      krita
      valentina
    ] ++ (with pkgs; [
      kdePackages.bluedevil
      kdePackages.kfind
      mpv
      picard
      protonvpn-gui
      qdirstat
      ungoogled-chromium
      calibre
    ]);
}
