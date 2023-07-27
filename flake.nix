{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-23.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.painted = {
    url = "github:atalii/painted";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, painted }:
    let
      sys = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
      	  ./configuration.nix
	  ./hardware-configuration.nix
	  ./cachix.nix

	  ({ config, ... }: {
	    environment.systemPackages = [ painted.defaultPackage.x86_64-linux ];
	  })

	  home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.atalii = import ./home.nix;
	    }
        ];
      };
    in {
      nixosConfigurations."kropotkin" = sys;
      nixosConfigurations."kropotkin.hsd1.co.comcast.net" = sys;
    };
}
