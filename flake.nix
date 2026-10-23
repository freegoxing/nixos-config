{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-26.05 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
      
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations.ubuntu = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./hosts/ubuntu/home.nix ];
    };

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs;};
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
