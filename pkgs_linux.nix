{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages =
    with pkgs ;[
      emacs-gtk
      alsa-utils
      docker
      docker-compose
      lan-mouse
    ];
}
