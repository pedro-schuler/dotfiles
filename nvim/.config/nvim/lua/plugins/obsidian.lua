return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "Obsidian",
				path = "~/Sync/Obsidian-PocoX6/",
			},
		},
		ui = { enable = false },
	},
}
