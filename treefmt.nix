_: {
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    stylua.enable = true;
  };
  settings.global.excludes = [ "flake.lock" ];
}
