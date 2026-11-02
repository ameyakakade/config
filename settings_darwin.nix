{ pkgs, config, lib, self, ... }: rec {

  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  users.knownUsers = [ "ameya" ];   # nix-darwin only applies shell/uid/etc. for listed users
  users.users.ameya = {
    uid = 501;                         # must match your real uid: `id -u`
    home = "/Users/ameya";
    shell = pkgs.fish;
  };

  system.primaryUser = "ameya";

  # THE LINE BELOW BREAKS IT
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # use fingerprint for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
