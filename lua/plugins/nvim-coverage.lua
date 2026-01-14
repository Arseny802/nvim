return {
	"andythigpen/nvim-coverage",
	version = "*",
	config = function()
		require("coverage").setup({
			commands = true, -- create commands
			auto_reload = true,
			summary = {
				-- customize the summary pop-up
				min_coverage = 60.0, -- minimum coverage threshold (used for highlighting)
			},
		})
	end,
}
