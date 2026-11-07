_inputs:
{ wlib, ... }:
{
  imports = [ wlib.wrapperModules.neovim ];

  # Lua config lives in ./nvim and is provisioned by nix.
  config.settings.config_directory = ./nvim;
}
