{
  description = "Portable Neovim configuration built with nix-wrapper-modules";

  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    wrappers = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      wrappers,
      treefmt-nix,
      ...
    }@inputs:
    let
      forAllSystems =
        f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

      module = nixpkgs.lib.modules.importApply ./module.nix inputs;
      wrapper = wrappers.lib.evalModule module;

      treefmtEval = forAllSystems (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      # The reusable wrapper module and the evaluated wrapper config.
      wrapperModules = {
        neovim = module;
        default = self.wrapperModules.neovim;
      };
      wrappers = {
        neovim = wrapper.config;
        default = self.wrappers.neovim;
      };

      # `nix run .` / `nix shell .` / `nix build .`
      packages = forAllSystems (pkgs: rec {
        neovim = self.wrappers.neovim.wrap { inherit pkgs; };
        default = neovim;

        # Reads Lua live from disk instead of the nix store, for rapid iteration.
        # Uses $NVIM_CONFIG_DIR if set, otherwise ./nvim relative to the cwd.
        #   nix run .#neovim-dev
        #   NVIM_CONFIG_DIR=~/scratch/nvim nix run .#neovim-dev
        neovim-dev = self.wrappers.neovim.wrap {
          inherit pkgs;
          settings.config_directory = pkgs.lib.generators.mkLuaInline ''
            vim.fn.fnamemodify(os.getenv("NVIM_CONFIG_DIR") or (vim.fn.getcwd() .. "/nvim"), ":p")
          '';
        };
      });

      # For NixOS configs: `nixpkgs.overlays = [ inputs.nixvim.overlays.default ]`
      overlays.default = final: _prev: {
        neovim-custom = self.wrappers.neovim.wrap { pkgs = final; };
      };

      # For NixOS/home-manager: `imports = [ inputs.nixvim.nixosModules.default ];`
      # then `wrappers.neovim.enable = true;` (any wrapper option can be set too).
      nixosModules = {
        default = self.nixosModules.neovim;
        neovim = wrappers.lib.getInstallModule {
          name = "neovim";
          value = module;
        };
      };
      homeModules = {
        default = self.homeModules.neovim;
        # they produce generically importable modules
        neovim = self.nixosModules.neovim;
      };

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper
          ];
        };
      });

      formatter = forAllSystems (
        pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper
      );

      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
        neovim = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
      });
    };
}
