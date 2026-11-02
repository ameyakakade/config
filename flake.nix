{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url                       = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url                    = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url                      = "path:/etc/nixos";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, hardware }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."ameya" = nix-darwin.lib.darwinSystem {
        modules = [ ./settings_common.nix ./settings_darwin.nix ./pkgs_common.nix ./pkgs_darwin.nix ];
        specialArgs = { inherit self; };
      };

      nixosConfigurations."ameya" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =  [ hardware.config ./settings_common.nix ./settings_linux.nix ./pkgs_common.nix ./pkgs_linux.nix ];
      };
    };
}
