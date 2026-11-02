{
  pkgs,
  lib,
  ...
}:
{
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
      zed-editor
      mpv
      scrcpy
      mpd
      fastfetch
      pandoc
      btop
      font-awesome_7
      tmux

      cabal-install
      (haskellPackages.ghcWithPackages( hp: [ hp.tidal ] )) # this worked
    ];
}
