local function run_curr_python_file(args)
	local dir_name = vim.fn.expand("%:p:h")
	vim.cmd("vsplit")
	vim.cmd("terminal")
	vim.fn.feedkeys("a")
	local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
	vim.fn.feedkeys("clear" .. enter)
	vim.fn.feedkeys('python3 /build_tools/builder.py "' .. dir_name .. '" ' .. args .. enter)
	vim.fn.feedkeys("exit" .. enter)
end

local function conan_get_packages(args)
	run_curr_python_file("--deps")
end

local function cmake_reload(args)
	run_curr_python_file("--cmake")
end

local function cmake_build(args)
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
vim.api.nvim_set_keymap("n", "<Leader>mb", "", {
	noremap = true,
	callback = function()
		require("cmake-tools").build({ -- opts
			nargs = "*",
			bang = true,
			desc = "CMake build",
		})
	end,
	desc = "CMake: Build current target",
})
vim.api.nvim_set_keymap("n", "<Leader>mr", "", {
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

return {}
