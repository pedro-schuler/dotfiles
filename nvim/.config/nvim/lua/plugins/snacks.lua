return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = false },
		bigfile = {
			enabled = true,
		},
		bufdelete = { enabled = false },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		debug = { enabled = false },
		dim = { enabled = false },
		explorer = { enabled = false },
		git = { enabled = false },
		gitbrowse = { enabled = false },
		indent = {
			enabled = true,
		},
		input = {
			enabled = true,
		},
		layout = { enabled = false },
		lazygit = { enabled = false },
		notifier = {
			enabled = true,
		},
		picker = {
			enabled = true,
		},
		profiler = { enabled = false },
		quickfile = { enabled = false },
		rename = { enabled = false },
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		terminal = { enabled = false },
		toggle = { enabled = false },
		win = { enabled = false },
		words = { enabled = false },
		zen = { enabled = false },
	},
}
