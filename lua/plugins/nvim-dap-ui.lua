-- try to configure dap
local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level("TRACE")

-- local codelldb_root = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
-- local codelldb_root = "C:\\tools\\codelldb-win32-x64\\extension\\"
local codelldb_root = "C:\\Users\\a.ravin\\.vscode\\extensions\\vadimcn.vscode-lldb-1.11.3\\"
local codelldb_path = codelldb_root .. "adapter\\codelldb.exe"
local liblldb_path = codelldb_root .. "lldb\\bin\\liblldb.dll"

dap.adapters.codelldb = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		--	command = "C:\\tools\\codelldb-win32-x64\\extension\\adapter\\codelldb.exe", -- adjust as needed, must be absolute path
		command = codelldb_path,
		-- args = { "--liblldb", liblldb_path, "--port", "${port}" },
		args = { "--port", "${port}" },
		detached = isWin and false or true,
	},
}
dap.adapters.lldb = {
	type = "executable",
	command = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe", -- Find lldb-vscode on $PATH
}
dap.adapters.gdb = {
	type = "server",
	host = "127.0.0.1",
	port = "53828",
	executable = {
		command = "gdb",
		args = { "--interpreter=mi" }, -- Аргумент для интерфейса Machine Interface
		detached = isWin and false or true,
	},
}
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "C:\\Users\\a.ravin\\.vscode\\extensions\\ms-vscode.cpptools-1.29.3-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
	options = {
		detached = false,
	},
}

dap.configurations.cpp = {
	{
		name = "Launch cppdbg",
		type = "cppdbg",
		request = "launch",
		program = function()
			return require("cmake-tools").get_launch_target_path()
		end,
		cwd = function()
			return require("cmake-tools").get_base_vars().dir.build
		end,
		stopAtEntry = false,
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = true,
			},
		},
		environment = require("cmake-tools").get_run_environment(),
		symbolSearchPath = function()
			-- return require("cmake-tools").get_run_environment()
			return {
				vim.env.PATH,
				require("cmake-tools").get_run_environment(),
				require("cmake-tools").get_build_environment(),
				require("cmake-tools").get_base_vars().dir.binary,
			}
		end,
	},
	{
		type = "lldb",
		request = "launch",
		name = "Launch CPP",
		program = function()
			return require("cmake-tools").get_launch_target_path()
		end,
		cwd = "${workspaceFolder}",
		args = {},
		runInTerminal = false,
	},
	{
		name = "Launch GDB",
		type = "gdb",
		request = "launch",
		program = function()
			return require("cmake-tools").get_launch_target_path()
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		setupCommands = {
			{
				description = "Enable pretty printing in GDB",
				text = '-interpreter-exec console "set logging on"',
				ignoreFailures = true,
			},
		},
		runInTerminal = false,
		port = 53828,
		backlog = 100,
	},
	{
		name = "Launch codelldb",
		type = "codelldb",
		request = "launch",
		program = function()
			return require("cmake-tools").get_launch_target_path()
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		terminal = "integrated",
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

return {}
