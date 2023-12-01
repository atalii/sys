{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-23.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.painted = {
    url = "github:atalii/painted";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, painted }:
    let
      unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
      sys = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
      	  ./configuration.nix
	  ./hardware-configuration.nix
	  ./cachix.nix

	  ({ config, pkgs, ... }: {
	    environment.systemPackages = [
	      painted.defaultPackage.x86_64-linux
	      unstable.alire

	      (import ./pkgs/gnatprove.nix { inherit pkgs; })
	    ];
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
