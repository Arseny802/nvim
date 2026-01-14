if true then
	return {}
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

require("lazy").setup({
	spec = {
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- nvim.ai depends on treesitter
		{
			"magicalne/nvim.ai",
			version = "*",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			opts = {
				provider = "gigachat", -- You can configure your provider, model or keymaps here.

				keymaps = {
					toggle = "<leader>A", -- Toggle chat dialog
					send = "<CR>", -- Send message in normal mode
					close = "q", -- Close chat dialog
					clear = "<C-l>", -- Clear chat history
					stop_generate = "<C-c>", -- Stop generating
					previous_chat = "<leader>[", -- Open previous chat from history
					next_chat = "<leader>]", -- Open next chat from history
					inline_assist = "<leader>i", -- Run InlineAssist command with prompt
				},
			},
		},
	},
	-- ...
})

return {}
