{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
	# compilers/basic stuff
	gcc	# C/C++
	clang	# LLVM C/C++
	cmake	# build
	rustc	# rust
	python313	# python stuff
	sqlite	# SQL
	
	# libraries/other tools
	nodejs	# node runtime
	docker	# container
	cargo	# rust pkg manager
	rust-analyzer	# idk if needed
	rustup	# toolchain manager
	python313Packages.pip	# python pkg manager
  ];
  # makes storing data easier and more reproducable
  environment.variables = {
  RUSTUP_HOME = "/etc/rustup";
  CARGO_HOME = "/etc/cargo";
  };
  # makes sure the directories exists + manages permissions (rewrite karson:users with your own user and group name
  system.activationScripts.rust-dirs = ''
  mkdir -p /etc/{rustup,cargo}
  chown karson:users /etc/{rustup,cargo}
  chmod 755 /etc/{rustup,cargo}
'';
}
