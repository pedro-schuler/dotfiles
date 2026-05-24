return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>gf",
				function()
					local bufnr = vim.api.nvim_get_current_buf()

					-- Formatação Manual
					require("conform").format({ async = true, lsp_format = "fallback" }, function(err, did_edit)
						vim.schedule(function()
							if not err then
								-- Captura e formata a lista de ferramentas ativas
								local formatters = require("conform").list_formatters(bufnr)
								local names = {}
								for _, f in ipairs(formatters) do
									if f.available then
										table.insert(names, f.name)
									end
								end

								local msg = #names > 0
										and ("Arquivo formatado manualmente via " .. table.concat(names, ", "))
									or "Arquivo formatado!"
								vim.notify(msg, vim.log.levels.INFO, { title = "Conform" })
							else
								vim.notify(
									"Formatação falhou: " .. tostring(err),
									vim.log.levels.ERROR,
									{ title = "Conform" }
								)
							end
						end)
					end)
				end,
				mode = "",
				desc = "[G]o [F]ormat Buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd" },
					markdown = { "prettierd", "markdownlint" },
					tex = { "latexindent" },
					php = { "php_cs_fixer" },
					toml = { "taplo" },
				},
				-- Formatação ao Salvar
				format_on_save = function(bufnr)
					return {
						timeout_ms = 9000,
						lsp_format = "fallback",
					}, function(err)
						vim.schedule(function()
							if not err then
								-- Captura e formata a lista de ferramentas ativas ao salvar
								local formatters = require("conform").list_formatters(bufnr)
								local names = {}
								for _, f in ipairs(formatters) do
									if f.available then
										table.insert(names, f.name)
									end
								end

								local msg = #names > 0 and ("Salvo: Formatado via " .. table.concat(names, ", "))
									or "Arquivo salvo e formatado!"
								vim.notify(msg, vim.log.levels.INFO, { title = "Conform" })
							else
								vim.notify(
									"Formatação ao salvar falhou: " .. tostring(err),
									vim.log.levels.ERROR,
									{ title = "Conform" }
								)
							end
						end)
					end
				end,
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
		config = function()
			require("mason-conform").setup({
				ensure_installed = {
					"stylua",
					"black",
					"isort",
					"prettierd",
					"markdownlint",
					"latexindent",
					"php-cs-fixer",
					"taplo",
				},
				automatic_installation = true,
			})
		end,
	},
}
