{ lib, pkgs, username, ... }: {
  home = { sessionVariables = { EDITOR = "emacs"; }; };

  programs.emacs = {
    package = pkgs.emacs;
    enable = true;
    chemacs.profiles.default = { userDir = "/home/${username}/emacs"; };
  };
}
