{ lib, pkgs, unstable-pkgs, userFullName, userEmail, ... }: {
  home.packages = with unstable-pkgs;
    [ devenv fd htop ncdu ntfs3g ripgrep tmux xorg.xhost ] ++ (with pkgs; [ ]);

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    update-config = "$EDITOR $HOME/../nixos/flake.nix && update-all";
    update-all = ''
      sudo nix flake update --flake "$HOME/../nixos" && update-system && update-home && nix-collect-garbage -d'';
    update-system =
      ''sudo nixos-rebuild switch --flake "$HOME/../nixos#$HOSTNAME"'';
    update-home =
      ''home-manager switch --flake "$HOME/../nixos#$USER@$HOSTNAME"'';
  };

  programs.git = {
    enable = true;
    userName = userFullName;
    userEmail = userEmail;
  };
}
