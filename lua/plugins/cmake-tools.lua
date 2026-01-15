return {
	"Civitasv/cmake-tools.nvim",
	lazy = false,
	opts = {
		cmake_use_preset = true,
		cmake_regenerate_on_save = true,
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON" },

		cmake_executor = { -- executor to use
			default_opts = { -- a list of default and possible values for executors
				quickfix = {
					show = "only_on_error", -- "always", "only_on_error"
					position = "vertical", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
					size = 120,
					encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
			},
			toggleterm = {
				direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
				close_on_exit = false, -- whether close the terminal when exit
				auto_scroll = true, -- whether auto scroll to the bottom
				singleton = true, -- single instance, autocloses the opened one, if present
			},
			overseer = {
				new_task_opts = {
					strategy = {
						"toggleterm",
						direction = "vertical",
						auto_scroll = true,
						quit_on_exit = "success",
					},
				}, -- options to pass into the `overseer.new_task` command
			},
			terminal = {
				name = "Executor",
				prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
				split_direction = "vertical", -- "horizontal", "vertical"
				split_size = 120,
			}, -- terminal executor uses the values in cmake_terminal
		},

		cmake_runner = { -- runner to use
			name = "terminal", -- name of the runner
			opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
			default_opts = { -- a list of default and possible values for runners
				quickfix = {
					show = "always", -- "always", "only_on_error"
					position = "vertical", -- "bottom", "top"
					size = 120,
					encoding = "utf-8",
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				toggleterm = {
					direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
					close_on_exit = false, -- whether close the terminal when exit
					auto_scroll = true, -- whether auto scroll to the bottom
					singleton = true, -- single instance, autocloses the opened one, if present
				},
				overseer = {
					new_task_opts = {
						strategy = {
							"toggleterm",
							direction = "vertical",
							autos_croll = true,
							quit_on_exit = "success",
						},
					}, -- options to pass into the `overseer.new_task` command
				},
				terminal = {
					name = "Runner",
					prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
					split_direction = "vertical", -- "horizontal", "vertical"
					split_size = 120,
				},
			},
		},

		cmake_notifications = {
			runner = { enabled = true },
			executor = { enabled = true },
			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
			refresh_rate_ms = 100, -- how often to iterate icons
		},

		cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
		cmake_use_scratch_buffer = false,
	},
}
