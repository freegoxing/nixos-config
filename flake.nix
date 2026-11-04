{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
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
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      treefmt = inputs.treefmt-nix.lib.evalModule pkgs ./nix/treefmt.nix;
      pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = import ./nix/git-hooks.nix { inherit treefmt; };
      };
    in
    {
      formatter.${system} = treefmt.config.build.wrapper;
      checks.${system}.pre-commit = pre-commit-check;
      devShells.${system}.default = pkgs.mkShellNoCC {
        inherit (pre-commit-check) shellHook;
        packages = pre-commit-check.enabledPackages ++ [
          pkgs.pre-commit
          treefmt.config.build.wrapper
          pkgs.statix
          pkgs.deadnix
        ];
      };

      homeConfigurations.ubuntu = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";

          overlays = [
            inputs.nur.overlays.default
          ];

          config = {
            allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "pycharm"
                "nvidia-x11"
                "wechat"
                "wpsoffice-cn"
                "geogebra"
                "google-chrome"
                "obsidian"
                "wemeet"
                "libwemeetwrap"
                "baidunetdisk"
                "nomachine-client"
              ];

            nvidia.acceptLicense = true;
          };
        };

        extraSpecialArgs = { inherit inputs; };

        modules = [
          ./hosts/ubuntu/home.nix
        ];
      };

      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/vm

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kvm = import ./hosts/vm/home.nix;
          }
        ];
      };
    };
}
