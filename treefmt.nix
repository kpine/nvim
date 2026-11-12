_: {
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    stylua.enable = true;
    # Format YAML (.github/), keeping blank lines between sections
    yamlfmt = {
      enable = true;
      settings.formatter.retain_line_breaks = true;
    };
    actionlint.enable = true; # lint GitHub Actions workflows
  };
  settings.global.excludes = [ "flake.lock" ];
}
