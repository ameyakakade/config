{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        with pkgs ;[
          neovim
          rmpc
          ffmpeg
          fzf
          mpd
          mpc
          ripgrep
          wget
          yt-dlp
          aerospace
          zed-editor
          mpv
          scrcpy
          mpd
          autoraise
          fastfetch

          # haskell
          ghc
          cabal-install
          hlint
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      environment.shells = [ pkgs.fish ];

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.knownUsers = [ "ameya" ];   # nix-darwin only applies shell/uid/etc. for listed users
      users.users.ameya = {
        uid = 501;                         # must match your real uid: `id -u`
        home = "/Users/ameya";
        shell = pkgs.fish;
      };

      # use fingerprint for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

#      services.mpd = {
#        enable = true;
#        settings = {
#          music_directory = "home/Music/Songs";
#          # must specify one or more audio_output blocks in order to play audio!
#          # (e.g. ALSA, PulseAudio, PipeWire), see next sections
#        };
#      };

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."ameya" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
