local spec = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false, -- neo-tree will lazily load itsel
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = true,
			follow_current_file = { enabled = false },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = { "__pycache__" }, -- Файлы, которые будут скрываться
			},
		},
		close_if_last_window = true,
		popup_border_style = "rounded", -- Стили границ панели
		enable_git_status = true, -- Показывать статус Git
		source_selector = {
			winbar = true, -- toggle to show selector on winbar
			statusline = false, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- boolean  }
		},
	},
}

return spec
