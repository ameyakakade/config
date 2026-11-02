{ pkgs, config, lib, ... }: rec {
  nix.settings.experimental-features = "nix-command flakes";

  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  users.knownUsers = [ "ameya" ];   # nix-darwin only applies shell/uid/etc. for listed users
  users.users.ameya = {
    uid = 501;                         # must match your real uid: `id -u`
    home = "/Users/ameya";
    shell = pkgs.fish;
  };

  system.primaryUser = "ameya";
}
