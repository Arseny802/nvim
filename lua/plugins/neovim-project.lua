return {
	"coffebar/neovim-project",
	opts = {
		projects = { -- define project roots
			"G:\\dssl\\trassir\\*",
			"~/development/trassir",
			"~/Development/trassir",
			"E:\\*",
			"E:\\projects\\*",
			"E:\\opensource\\*",
			"~/development/*",
			"~/Development/*",
			"~/.config/*",
			"~\\AppData\\Local\\nvim",
		},
		picker = {
			type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
		},
		preview = {
			enabled = true, -- show directory structure in Telescope preview
			git_status = true, -- show branch name, an ahead/behind counter, and the git status of each file/folder
			git_fetch = true, -- fetch from remote, used to display the number of commits ahead/behind, requires git authorization
			show_hidden = true, -- show hidden files/folders
		},
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" }, -- optional picker
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.4",
		}, -- optional picker
		{ "ibhagwan/fzf-lua" }, -- optional picker
		{ "folke/snacks.nvim" },
		{ "Shatur/neovim-session-manager" },
	},
	lazy = false,
	priority = 100,
}
