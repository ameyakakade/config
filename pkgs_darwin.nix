{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages =
    with pkgs ;[
      aerospace
      autoraise
    ];
}
