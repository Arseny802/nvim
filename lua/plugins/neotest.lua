return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"alfaix/neotest-gtest",
		"orjangj/neotest-ctest",
	},
	config = function()
		-- Optional, but recommended, if you have enabled neotest's diagnostic option
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Convert newlines, tabs and whitespaces into a single whitespace
					-- for improved virtual text readability
					local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				-- Load with default config
				require("neotest-ctest").setup({

					-- fun(string) -> string: Find the project root directory given a current directory
					-- to work from.
					root = function(dir)
						-- by default, it will use neotest.lib.files.match_root_pattern with the following entries
						return require("neotest.lib").files.match_root_pattern(
							-- NOTE: CMakeLists.txt is not a good candidate as it can be found in
							-- more than one directory
							"CMakePresets.json",
							"compile_commands.json",
							".clangd",
							".clang-format",
							".clang-tidy",
							"build",
							"out",
							".git"
						)(dir)
					end,

					-- fun(string) -> bool: Takes a file path as string and returns true if it contains tests.
					-- This function is called often by neotest, so make sure you don't do any heavy duty work.
					is_test_file = function(file)
						-- by default, returns true if the file stem ends with _test and the file extension is
						-- one of cpp/cc/cxx.
					end,
					-- fun(string, string, string) -> bool: Filter directories when searching for test files.
					-- Best to keep this as-is and set per-project settings in neotest instead.
					-- See :h neotest.Config.discovery.
					filter_dir = function(name, rel_path, root)
						-- If you don't configure filter_dir through neotest, and you leave it as-is,
						-- it will filter the following directories by default: build, cmake, doc,
						-- docs, examples, out, scripts, tools, venv.
					end,
					-- What frameworks to consider when performing auto-detection of test files.
					-- Priority can be configured by ordering/removing list items to your needs.
					-- By default, each test file will be queried with the given frameworks in the
					-- following order.
					frameworks = { "gtest", "catch2", "doctest", "cpputest" },
					-- What extra args should ALWAYS be sent to CTest? Note that most of CTest arguments
					-- are not expected to be used (or work) with this plugin, but some might be useful
					-- depending on your needs. For instance:
					--   extra_args = {
					--     "--stop-on-failure",
					--     "--schedule-random",
					--     "--timeout",
					--     "<seconds>",
					--   }
					-- If you want to send extra_args for one given invocation only, send them to
					-- `neotest.run.run({extra_args = ...})` instead. see :h neotest.RunArgs for details.
					extra_args = {},
					-- other options
					-- projects = {
					-- 	["~/path/to/some/project"] = {
					-- 		discovery = {
					-- 			filter_dir = function(name, rel_path, root)
					-- 				-- Do not look for tests in `build` folder for this specific project
					-- 				return name ~= "build"
					-- 			end,
					-- 		},
					-- 		adapters = {
					-- 			require("neotest-ctest").setup({
					-- 				is_test_file = function(file_path)
					-- 					-- your implementation
					-- 					return
					-- 				end,
					-- 				frameworks = { "catch2" },
					-- 			}),
					-- 		},
					-- 	},
					-- },
				}),
			},
		})
	end,
	keys = function()
		local neotest = require("neotest")

		return {
			{
				"<leader>T",
				desc = "Neo Test",
			},
			{
				"<leader>Tf",
				function()
					neotest.run.run(vim.fn.expand("%"))
				end,
				desc = "Run File",
			},
			{
				"<leader>Tt",
				function()
					neotest.run.run()
				end,
				desc = "Run Nearest",
			},
			{
				"<leader>Tw",
				function()
					neotest.run.run(vim.loop.cwd())
				end,
				desc = "Run Workspace",
			},
			{
				"<leader>Tr",
				function()
					-- This will only show the output from the test framework
					neotest.output.open({ short = true, auto_close = true })
				end,
				desc = "Results (short)",
			},
			{
				"<leader>TR",
				function()
					-- This will show the classic CTest log output.
					-- The output usually spans more than can fit the neotest floating window,
					-- so using 'enter = true' to enable normal navigation within the window
					-- is recommended.
					neotest.output.open({ enter = true })
				end,
				desc = "Results (full)",
			},
			-- Other keybindings
		}
	end,
}
