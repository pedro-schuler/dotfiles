-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Set indentation to 2 spaces
vim.cmd("set expandtab") -- expand tab to spaces
vim.cmd("set tabstop=2") -- 2 spaces for tabs
vim.cmd("set softtabstop=2") --
vim.cmd("set shiftwidth=2") -- 2 spaces for indent widht

-- Set clipboard for nvim
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Set spell correction
vim.opt.spell = true
vim.opt.spelllang = "pt,en"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Setup Code Folding
-- Use treesitter as the source of truth for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Use 1 column for displaying info
vim.opt.foldcolumn = "1"
-- This option lets the first line by highlighted
vim.opt.foldtext = ""
-- Set the level of folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
-- Set how many levels should be folded
vim.opt.foldnestmax = 4

-- Set diagnostics to false by default
vim.diagnostic.disable()

-- Toggle search highlight
vim.keymap.set("n", "<space>/", "<cmd>let v:hlsearch=1 - v:hlsearch | echo (v:hlsearch ? ' ' : 'no') . 'hlsearch'<CR>")
