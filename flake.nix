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
	packages."x86_64-linux".default = 
	  (nvf.lib.neovimConfiguration {
	    pkgs = nixpkgs.legacyPackages."x86_64-linux";
	    modules = [ /home/karson/mysystem/nvf-configuration.nix ];
	    }).neovim;
	nixosConfigurations = {
	 default = nixpkgs.lib.nixosSystem {
	   inherit system;
	  specialArgs = { inherit pkgs; };

	  modules = [
	  ./nixos/configuration.nix
	  ./nixos/dev-tools.nix
	  nvf.nixosModules.default
	  ];
	};
       };
       
  };
}
