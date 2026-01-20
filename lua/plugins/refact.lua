local username = os.getenv("USER") or os.getenv("USERNAME")
if username ~= "a.ravin" then
	return {}
end
vim.notify("Имя пользователя: " .. username .. ". Используем Refact.Ai")

return {
	"smallcloudai/refact-neovim",
	lazy = false,
	config = function()
		require("refact-neovim").setup({
			address_url = "http://refact.dssl.local",
			api_key = os.getenv("REFACTAI_API_KEY"),
			lsp_bin = isWin and "C:\\Users\\" .. username .. "\\dssl-refact-lsp.exe" or "dssl-refact-lsp",
			insecure_ssl = true,
			max_tokens = 250,
			vecdb = false,
			ast = true,
			-- Not supported by DSSL server
			-- ast_file_limit = 45000,
			telemetry_code_snippets = false,
		})
	end,
}
