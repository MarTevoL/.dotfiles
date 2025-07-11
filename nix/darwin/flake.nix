{
  description = "Mart Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs,config, ... }: {

    nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      # environment.systemPackages =
      #   [ 
      #     pkgs.neovim
      #     pkgs.mkalias
      #     pkgs.tmux
      #   ];
      #
      # homebrew = {
      #   enable = true;
      #   casks = [
      #   "hammerspoon"
      #   "iina"
      #   ];
      #
      #   onActivation.cleanup = "zap";
      #
      # };

    environment.systemPackages =
      [ 
      pkgs.aerospace
      pkgs.neovim
        pkgs.tmux
        pkgs.mkalias
        pkgs.alacritty
        pkgs.ripgrep
        pkgs.zoxide
      ];

    homebrew = {
      enable = true;
      casks = [
          "wezterm"
          "hammerspoon"
          "firefox"
          "iina"
# "sf-symbols"
      ];
      brews = [
        "ca-certificates"
          "openssl@3"
          "libssh2"
          "libgit2"
          "oniguruma"
          "brotli"
          "c-ares"
          "libyaml"
          "ruby"
          "cocoapods"
          "eza"
          "bat"
          "fd"
          "ncurses"
          "pcre2"
          "fzf"
          "icu4c"
          "jq"
          "libevent"
          "libnghttp2"
          "libuv"
          "lua"
          "node"
          "powerlevel10k"
          "stow"
          "utf8proc"
          "tmux"
          "tree"
          "yazi"
          # "leoafarias/fvm/fvm"
          ];
      onActivation.cleanup = "zap";
    };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; })
      ];

      system.activationScripts.applications.text = let
         env = pkgs.buildEnv {
         name = "system-applications";
         paths = config.environment.systemPackages;
         pathsToLink = "/Applications";
      };
      in
         pkgs.lib.mkForce ''
         # Set up applications.
         echo "setting up /Applications..." >&2
         rm -rf /Applications/Nix\ Apps
         mkdir -p /Applications/Nix\ Apps
         find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
         while read src; do
           app_name=$(basename "$src")
           echo "copying $src" >&2
           ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
         done
             '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;

            # Apple Silicon Only
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "truongle";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook".pkgs;
  };
}
