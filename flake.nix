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
    # TODO 请将下面的 my-nixos 替换成你的 hostname
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs;};
      modules = [

        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./hosts/vm
        
        home-manager.nixosModules.home-manager 

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # import 导入
          home-manager.users.kvm = import ./home.nix;
        }
      ];
    };
  };
}
