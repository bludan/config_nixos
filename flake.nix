{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, }: 
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
	
	nixosConfigurations = {
	 default = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit system; };

	  modules = [
	  ./nixos/configuration.nix
	  ./nixos/dev-tools.nix
	  ];
	};
       };
       
  };
}
