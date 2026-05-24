return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			treesitter
				.install({
					"bash",
					"csv",
					"css",
					"html",
					"javascript",
					"typescript",
					"svelte",
					"vue",
					"latex",
					"bibtex",
					"lua",
					"markdown",
					"markdown_inline",
					"php",
					"python",
					"regex",
					"toml",
					"yaml",
				})
				:wait(60000) -- Aguarda a compilação no primeiro boot (nos seguintes vira no-op)

			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},
}
