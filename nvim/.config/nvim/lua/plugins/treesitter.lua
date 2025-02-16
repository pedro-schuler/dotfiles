return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})

			configs.setup({
				auto_install = true,
				ensure_installed = {
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
					"org",
					"php",
					"python",
					"regex",
					"toml",
					"yaml",
				},
				-- sync_install = false,
				highlight = {
					enable = true,
					disable = { "latex", "org" },
				},
				indent = { enable = true },
			})
		end,
	},
}
