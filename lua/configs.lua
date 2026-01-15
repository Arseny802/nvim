vim.wo.number = true
vim.wo.relativenumber = false
vim.cmdheight = 1

-- if package.config:sub(1, 1) == "/" then
-- 	vim.opt.shell = "/bin/zsh"
-- else
-- 	vim.opt.shell = "powershell"
-- 	vim.g.shell = "powershell"
-- end

if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.75
	vim.opt.linespace = 0

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.92
	vim.g.transparency = 0.80
	vim.g.neovide_normal_opacity = 0.8
	vim.g.neovide_background_color = "#0f1117" .. alpha()

	vim.g.neovide_title_background_color = string.format(
		"%x",
		vim.api.nvim_get_hl(0, {
			id = vim.api.nvim_get_hl_id_by_name("Normal"),
		}).bg
	)

	vim.g.neovide_title_text_color = "pink"
	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_floating_corner_radius = 0.0

	vim.g.neovide_show_border = false
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5

	-- vim.g.neovide_fullscreen = true
	vim.g.neovide_remember_window_size = true

	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_vfx_mode = "railgun"

	vim.g.neovide_cursor_unfocused_outline_width = 0.125
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 2.8
	vim.g.neovide_cursor_vfx_particle_density = 11.0
	vim.g.neovide_cursor_vfx_particle_curl = 2.0

	vim.g.neovide_scroll_animation_far_lines = 1
end

require("lspconfig").clangd.setup({
	on_new_config = function(new_config, new_cwd)
		local status, cmake = pcall(require, "cmake-tools")
		if status then
			cmake.clangd_on_new_config(new_config)
		end
	end,
})

if not vim.env["CMAKE_GENERATOR"] then
	vim.env["CMAKE_GENERATOR"] = "Ninja Multi-Config"
end

require("nvim-treesitter.install").prefer_git = true
require("devcontainer").setup({})

-- require("codecompanion").setup({
-- 	strategies = {
-- 		chat = {
-- 			adapter = {
-- 				name = "ollama",
-- 				model = "llama2:latest",
-- 			},
-- 		},
-- 		inline = {
-- 			adapter = {
-- 				name = "ollama",
-- 				model = "llama3:70b",
-- 			},
-- 		},
-- 		cmd = {
-- 			adapter = {
-- 				name = "ollama",
-- 				model = "qwen2.5-coder:32b",
-- 			},
-- 		},
-- 		background = {
-- 			adapter = {
-- 				name = "ollama",
-- 				model = "deepseek-coder:6.7b-base",
-- 			},
-- 		},
-- 	},
-- 	extensions = {
-- 		gitcommit = {
-- 			callback = "cocodecompaniondecompanion._extensions.gitcommit",
-- 			opts = {
-- 				-- Basic configuration
-- 				adapter = "ollama", -- LLM adapter
-- 				model = "tavernari/git-commit-message", -- Model name
-- 				languages = { "English", "Russian" }, -- Supported languages
--
-- 				-- File filtering (optional)
-- 				exclude_files = {
-- 					"*.pb.go",
-- 					"*.min.js",
-- 					"*.min.css",
-- 					"package-lock.json",
-- 					"yarn.lock",
-- 					"*.log",
-- 					"dist/*",
-- 					"build/*",
-- 					".next/*",
-- 					"node_modules/*",
-- 					"vendor/*",
-- 				},
--
-- 				-- Buffer integration
-- 				buffer = {
-- 					enabled = true, -- Enable gitcommit buffer keymaps
-- 					keymap = "<Leader>gm", -- Keymap for generating commit messages
-- 					auto_generate = true, -- Auto-generate on buffer enter
-- 					auto_generate_delay = 200, -- Auto-generation delay (ms)
-- 					skip_auto_generate_on_amend = true, -- Skip auto-generation during git commit --amend
-- 				},
--
-- 				-- Feature toggles
-- 				add_slash_command = true, -- Add /gitcommit slash command
-- 				add_git_tool = true, -- Add @{git_read} and @{git_edit} tools
-- 				enable_git_read = true, -- Enable read-only Git operations
-- 				enable_git_edit = true, -- Enable write-access Git operations
-- 				enable_git_bot = true, -- Enable @{git_bot} tool group (requires both read/write enabled)
-- 				add_git_commands = true, -- Add :CodeCompanionGitCommit commands
-- 				git_tool_auto_submit_errors = false, -- Auto-submit errors to LLM
-- 				git_tool_auto_submit_success = true, -- Auto-submit success to LLM
-- 				gitcommit_select_count = 100, -- Number of commits shown in /gitcommit
--
-- 				-- Commit history context (optional)
-- 				use_commit_history = true, -- Enable commit history context
-- 				commit_history_count = 10, -- Number of recent commits for context
-- 			},
-- 		},
-- 	},
-- })
