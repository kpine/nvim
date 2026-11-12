_inputs:
{
  config,
  lib,
  pkgs,
  wlib,
  ...
}@top:
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
      require("catppuccin").setup({
        flavour = info.flavor,
        no_italic = true,
      })
      vim.cmd.colorscheme("catppuccin")
    '';
  };

  config.specs.general = {
    data = with pkgs.vimPlugins; [
      friendly-snippets
      mini-cmdline
      mini-completion
      mini-extra
      mini-icons
      mini-files
      mini-notify
      mini-pick
      mini-snippets
      mini-statusline
      mini-surround
      nvim-lspconfig
    ];
  };

  config.specs.tree-sitter = {
    after = [ "general" ];
    data = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          beancount
          comment
          diff
          dockerfile
          http
          javascript
          json
          lua # bundled with Neovim, but nvim-treesitter's queries add comment/luadoc injections
          # markdown # included by default
          # markdown_inline # included by default
          nix
          python
          rust
          toml
          typescript
          yaml
        ]
      ))
    ];
  };

  config.specs.lua = {
    after = [ "general" ];
    data = with pkgs.vimPlugins; [
      lazydev-nvim
    ];
  };

  config.runtimePkgs = with pkgs; [
    fd
    git
    lua-language-server
    nixd
    nixfmt
    ripgrep
    stylua
    tree-sitter
  ];

  # When installed via Home Manager or NixOS, also make it the session's editor.
  config.install.modules =
    let
      editor = cfg: lib.mkIf cfg.enable { EDITOR = lib.mkOverride 900 (lib.getExe cfg.wrapper); };
    in
    {
      homeManager =
        { config, ... }:
        {
          home.sessionVariables = editor (top.config.install.getWrapperConfig config);
        };
      nixos =
        { config, ... }:
        {
          environment.sessionVariables = editor (top.config.install.getWrapperConfig config);
        };
    };
}
