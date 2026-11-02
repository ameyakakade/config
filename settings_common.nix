{ pkgs, config, lib, ... }: rec {
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
