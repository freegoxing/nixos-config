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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations.ubuntu = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        overlays = [
          inputs.nur.overlays.default
        ];

        config = {
          allowUnfreePredicate = pkg:
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
            ];

          nvidia.acceptLicense = true;
        };
      };

      extraSpecialArgs = { inherit inputs;};

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
