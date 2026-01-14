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
	},
}
dap.adapters.gdb = {
	type = "server",
	host = "127.0.0.1",
	port = "53828",
	executable = {
		command = "gdb",
		args = { "--interpreter=mi" }, -- Аргумент для интерфейса Machine Interface
	},
}

dap.configurations.cpp = {
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
		-- runInTerminal = false,
		runInTerminal = true,
		console = "integratedTerminal",
		externalConsole = false,
		MIMode = "lldb",
		setupCommands = {
			{
				description = "Enable pretty printing in GDB",
				text = '-interpreter-exec console "set logging on"',
				ignoreFailures = true,
			},
		},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

return {}
