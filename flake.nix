{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ...}: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
    	inherit system;

	config = {
	  allowUnfree = true;
	  };
    };

    in 
    {
	packages."84_64-linux".default = 
	  (nvf.lib.neovimConfiguration {
	    pkgs = nixpkgs.legacyPackages."x86_64-linux";
	    modules = [ ./nvf-configuration.nix ];
	    }).neovim;
	nixosConfigurations = {
	 default = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit system; };

	  modules = [
	  ./nixos/configuration.nix
	  ./nixos/dev-tools.nix
	  nvf.nixosModules.default
	  ];
	};
       };
       
  };
}
