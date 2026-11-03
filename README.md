# Nix config flake
for both NixOS and MacOS through nix-darwin.
Probably has numerous flaws, beware.

# How to use?
## On NixOS
Make a `flake.nix` file in `/etc/nixos`.
```nix
{
  description = "Hardware configuration flake";

  outputs = { self }: {
	config = ./hardware-configuration.nix;
  };
}

```
This flake expects the disk partitions and kernel module settings from
the hardware flake. Default config generated from NixOS install should
work.
Then run,
```
sudo nixos-rebuild switch --flake .#ameya
```

## On Nix-Darwin
Install nix-darwin
Then run,
```
sudo darwin-rebuild switch --flake .#ameya
```
