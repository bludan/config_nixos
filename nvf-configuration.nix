{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "solarized-osaka";
      style = "dark";
      };
      mini.tabline.enable = true;
      options = {
      tabstop = 2;
      shiftwidth = 2;
      };
     visuals = {
       indent-blankline.enable = true;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      languages = {
        enableLSP = true;
	enableTreesitter = true;

	nix.enable = true;
	ts.enable = true;
	rust.enable = true;
	bash.enable = true;
	clang.enable = true;
	css.enable = true;
	html.enable = true;
	lua.enable = true;
	python.enable = true;
	sql.enable = true;
	tailwind.enable = true;
	yaml.enable = true;
	#assembly = {  
        #enable = true;
         #   package = [*.asm = *.a];
        #};
      };
    };
  }
