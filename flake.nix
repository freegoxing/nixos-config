{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations.ubuntu = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config = {
          allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "pycharm"
              "nvidia-x11"
              "wechat"
              "wpsoffice-cn"
            ];

          nvidia.acceptLicense = true;
        };
      };

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
