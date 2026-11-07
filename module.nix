_inputs:
{
  config,
  lib,
  pkgs,
  wlib,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];

  # Lua config lives in ./nvim and is provisioned by nix.
  # mkDefault so variants (e.g. neovim-dev) can override it.
  config.settings.config_directory = lib.mkDefault ./nvim;

  # Catppuccin flavor. When consuming this from NixOS/home-manager, sync it
  # with the rest of your system, e.g.:
  #   wrappers.neovim.settings.flavor = config.catppuccin.flavor;
  options.settings.flavor = lib.mkOption {
    type = lib.types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ];
    default = "frappe";
    description = "Catppuccin flavor.";
  };

  config.specs.colorscheme = {
    data = pkgs.vimPlugins.catppuccin-nvim;
    info.flavor = config.settings.flavor;
    type = "lua";
    config = ''
      local info = ...
      require("catppuccin").setup({ flavour = info.flavor })
      vim.cmd.colorscheme("catppuccin")
    '';
  };
}
