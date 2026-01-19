vim.g.lazygit_use_custom_config_file_path = 1

if isWin then
	vim.g.lazygit_config_file_path = vim.fn.stdpath("config") .. "/lazygit-config/config-win.yml"
else
	vim.g.lazygit_config_file_path = vim.fn.stdpath("config") .. "/lazygit-config/config-unix.yml"
end

return {
	"kdheepak/lazygit.nvim",
	lazy = false, -- Should be true, but astro config is overriden
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		{ "<leader>tl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
}
