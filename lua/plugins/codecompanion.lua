return {
	"olimorris/codecompanion.nvim",
	strategies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		{
			"saghen/blink.cmp",
			lazy = false,
			version = "*",
			opts = {
				keymap = {
					preset = "enter",
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },
				},
				sources = {
					default = { "lsp", "path", "buffer", "codecompanion" },
					cmdline = {}, -- Disable sources for command-line mode
				},
			},
		},
	},
	opts = {
		interactions = {
			chat = {
				adapter = {
					name = "ollama",
					model = "llama2:latest",
				},
			},
			inline = {
				adapter = {
					name = "ollama",
					model = "llama3:70b",
				},
			},
			cmd = {
				adapter = {
					name = "ollama",
					model = "qwen2.5-coder:32b",
				},
			},
			background = {
				adapter = {
					name = "ollama",
					model = "deepseek-coder:6.7b-base",
				},
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG",
		},
	},
}
