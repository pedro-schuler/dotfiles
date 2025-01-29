return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			auto_install = true,
			-- ensure_installed = { "lua", "javascript", "html" },
			-- sync_install = false,
			highlight = {
				enable = true,
				disable = { "latex" },
			},
			indent = { enable = true },
		})
	end,
}
