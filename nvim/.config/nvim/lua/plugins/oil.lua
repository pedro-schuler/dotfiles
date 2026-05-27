return {
	"stevearc/oil.nvim",
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	---@module "oil"
	---@type oil.SetupOpts
	opts = {
		view_options = {
			show_hidden = true, -- Show hidden files by default
		},
		win_options = {
			wrap = false, -- Disable line wrapping in the oil window
		},
	},
}
