{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "solarized-osaka";
      style = "dark";
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
	};
  };
}
