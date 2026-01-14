local function run_curr_python_file(args)
	local dir_name = vim.fn.expand("%:p:h")
	vim.cmd("vsplit")
	vim.cmd("terminal")
	vim.fn.feedkeys("a")
	local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
	vim.fn.feedkeys("clear" .. enter)
	if isWin then
		vim.fn.feedkeys('python3 C:\\build_tools\\builder.py "' .. dir_name .. '" ' .. args .. enter)
	else
		vim.fn.feedkeys('python3 ~/build_tools/builder.py "' .. dir_name .. '" ' .. args .. enter)
	end
	vim.fn.feedkeys("exit" .. enter)
end

local function conan_get_packages()
	run_curr_python_file("--deps")
end

local function cmake_reload()
	run_curr_python_file("--cmake")
end

local function cmake_build()
	run_curr_python_file("--build")
end

vim.api.nvim_set_keymap("n", "<Leader>a", "", {
	noremap = true,
	desc = "Arseny802 project deploy tools",
})
vim.api.nvim_set_keymap("n", "<Leader>ad", "", {
	noremap = true,
	callback = conan_get_packages,
	desc = "Conan Install Packages (Dependencies)",
})
vim.api.nvim_set_keymap("n", "<Leader>ac", "", {
	noremap = true,
	callback = cmake_reload,
	desc = "Cmake Reload Project",
})
vim.api.nvim_set_keymap("n", "<Leader>ab", "", {
	noremap = true,
	callback = cmake_build,
	desc = "Cmake Build Project",
})

-- CMake mappings begin
vim.api.nvim_set_keymap("n", "<Leader>m", "", {
	noremap = true,
	desc = "Make / CMake tools",
})
vim.api.nvim_set_keymap("n", "<Leader>mg", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").generate({ -- opts
			nargs = "*",
			bang = true,
			desc = "CMake configure",
		})
	end,
	desc = "CMake: Regenerage project configuration",
})
vim.api.nvim_set_keymap("n", "<Leader>mS", "", {
	noremap = true,
	callback = function()
		local cmake_tools = require("cmake-tools")
		cmake_tools.select_build_target({ -- opts
			nargs = "*",
			bang = true,
			desc = "CMake select build target",
		})
		cmake_tools.select_launch_target({ -- opts
			nargs = "*",
			bang = true,
			desc = "CMake select launch target",
		})
	end,
	desc = "CMake: Select build and tun targets",
})

vim.api.nvim_set_keymap("n", "<Leader>mb", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").quick_build({ -- opts
			nargs = "?",
			fargs = { nil },
			desc = "CMake quick build",
		})
	end,
	desc = "CMake: Quick build some target",
})
vim.api.nvim_set_keymap("n", "<Leader>mB", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").build({ -- opts
			nargs = "*",
			bang = true,
			desc = "CMake rebuild",
		})
	end,
	desc = "CMake: Rebuild current target",
})

vim.api.nvim_set_keymap("n", "<Leader>md", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").quick_debug({ -- opts
			nargs = "*",
			desc = "CMake quick debug",
		})
	end,
	desc = "CMake: Quick debug some target",
})
vim.api.nvim_set_keymap("n", "<Leader>mD", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").debug({ -- opts
			nargs = "*",
			desc = "CMake debug",
		})
	end,
	desc = "CMake: Debug current target",
})

vim.api.nvim_set_keymap("n", "<Leader>mr", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").quick_run({ -- opts
			nargs = "?",
			fargs = { nil },
			desc = "CMake quick run",
		})
	end,
	desc = "CMake: Quick run some target",
})
vim.api.nvim_set_keymap("n", "<Leader>mR", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").run({ -- opts
			nargs = "*",
			desc = "CMake run",
		})
	end,
	desc = "CMake: Run current target",
})

vim.api.nvim_set_keymap("n", "<Leader>mt", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").run_test({ -- opts
			nargs = "*",
			desc = "CMake run test",
		})
	end,
	desc = "CMake: Run all tests",
})
-- CMake mappings end

vim.api.nvim_set_keymap(
	"n",
	"<Leader>B",
	":lua require('neogen').generate()<CR>",
	{ noremap = true, silent = true, desc = "Generate brief template for this function" }
)

return {}
