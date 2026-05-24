return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "ruff", "mypy" },
				lua = { "luacheck" },
			}

			local mypy = lint.linters.mypy
			mypy.args = {
				"--show-column-numbers",
				"--hide-error-codes",
				"--hide-error-context",
				"--no-color",
				"--no-error-summary",
				"--no-pretty",
			}

			vim.list_extend(mypy.args, {
				"--python-executable",
				(os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr") .. "/bin/python3",
			})

			-- Autocomando assíncrono para os gatilhos e notificações
			local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()

					-- Captura do filetype para contornar a natureza assíncrona do try_lint()
					local ft = vim.bo.filetype
					local active_linters = lint.linters_by_ft[ft] or {}

					if #active_linters > 0 then
						vim.schedule(function()
							vim.notify(
								"Análise ativa: " .. table.concat(active_linters, ", "),
								vim.log.levels.INFO,
								{ title = "Nvim-Lint" }
							)
						end)
					end
				end,
			})
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-lint",
		},
		config = function()
			require("mason-nvim-lint").setup({
				ensure_installed = {
					"markdownlint",
					"eslint_d",
					"ruff",
					"mypy",
					"luacheck",
				},
				automatic_installation = true,
			})
		end,
	},
}
