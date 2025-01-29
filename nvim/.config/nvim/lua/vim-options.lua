-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Set indentation to 2 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set clipboard for nvim
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Set spell correction
vim.opt.spell = true
vim.opt.spelllang = "pt_br"
vim.opt.spelllang = "en_us"
