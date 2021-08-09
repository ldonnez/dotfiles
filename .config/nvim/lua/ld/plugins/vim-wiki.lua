vim.g.vimwiki_list = {
	{
		["path"] = "~/SynologyDrive/Wiki/text/",
		["path_html"] = "~/SynologyDrive/Wiki/html/",
		["syntax"] = "markdown",
		["ext"] = ".md",
	},
}
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_table_auto_fmt = 0

vim.api.nvim_set_keymap("n", "tt", "<Plug>VimwikiToggleListItem", { noremap = false })
