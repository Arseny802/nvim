-- if true then
-- 	return {}
-- end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		provider = "gigachat",
		providers = {
			ollama = {
				endpoint = "http://127.0.0.1:11434", -- Local Ollama (no /v1)
				model = "deepseek-coder:latest",
				-- is_env_set = require("avante.providers.ollama").check_endpoint_alive,
				is_env_set = function()
					return true
				end,
			},
			gigachat = {
				__inherited_from = "openai",
				auth_type = "api", -- Тип аутентификации
				api_key_name = "GIGACHAT_API_KEY",
				-- api_key = os.getenv("GIGACHAT_API_KEY"), -- Переменная среды с вашим ключом
				model = "gigachat-standard-model", -- Модель по умолчанию
				timeout = 30000, -- Таймаут ожидания ответа
				extra_request_body = {
					temperature = 0.75, -- Параметры генерации текста
					max_tokens = 4096,
				},
			},
		},
		-- providers = {
		--   claude = {
		--     endpoint = "https://api.anthropic.com",
		--     model = "claude-sonnet-4-20250514",
		--     timeout = 30000, -- Timeout in milliseconds
		--       extra_request_body = {
		--         temperature = 0.75,
		--         max_tokens = 20480,
		--       },
		--   },
		--   moonshot = {
		--     endpoint = "https://api.moonshot.ai/v1",
		--     model = "kimi-k2-0711-preview",
		--     timeout = 30000, -- Timeout in milliseconds
		--     extra_request_body = {
		--       temperature = 0.75,
		--       max_tokens = 32768,
		--     },
		--   },
		-- },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
