return {
	"zk-org/zk-nvim",
	name = "zk",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("zk").setup({
			-- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
			-- or select" (`vim.ui.select`).
			picker = "telescope",

			lsp = {
				-- `config` is passed to `vim.lsp.start(config)`
				config = {
					name = "zk",
					cmd = { "zk", "lsp" },
					filetypes = { "markdown" },
					-- on_attach = ...
					-- etc, see `:h vim.lsp.start()`
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = true,
				},
			},
		})
		local opts = { noremap = true, silent = true }

		-- Criar Nota Permanente (Pasta permanentes)
		vim.keymap.set("n", "<leader>zp", function()
			local title = vim.fn.input("Título da Nota Permanente: ")
			if title ~= "" then
				require("zk").new({
					title = title,
					dir = "permanentes",
					group = "permanentes",
					template = "permanentes.md",
				})
			end
		end, opts)

		-- Criar Nota de Literatura (Pasta literatura)
		vim.keymap.set("n", "<leader>zl", function()
			local title = vim.fn.input("Título da Nota de Literatura: ")
			if title ~= "" then
				require("zk").new({ title = title, dir = "literatura", group = "inbox", template = "literatura.md" })
			end
		end, opts)

		-- Criar Nota Rápida manualmente no PC (Pasta inbox)
		vim.keymap.set("n", "<leader>zi", function()
			local title = vim.fn.input("Título da Nota Rápida: ")
			if title ~= "" then
				require("zk").new({ title = title, dir = "inbox", group = "literatura", template = "inbox.md" })
			end
		end, opts)

		-- Navegação e Buscas Globais via Telescope
		vim.keymap.set("n", "<leader>zs", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", opts) -- Buscar notas
		vim.keymap.set("n", "<leader>zt", "<cmd>ZkTags<CR>", opts) -- Buscar tags
		vim.keymap.set("n", "<leader>zb", "<cmd>ZkBacklinks<CR>", opts)
		vim.keymap.set("n", "<leader>zc", "<cmd>ZkInsertLink<CR>", opts)

		-- Criar nova nota depois de perguntar pelo título.
		-- vim.keymap.set("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { silent = true })

		-- Abrir notas.
		-- vim.keymap.set("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

		-- Procura por notas de acordo com os critérios fornecidos.
		vim.keymap.set(
			"n",
			"<leader>zf",
			"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Buscar: ') } }<CR>",
			opts
		)
		-- Procura por notas que contenham a seleção visual atual.
		vim.keymap.set("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
	end,
}
