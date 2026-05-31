local prompts = {
	-- Code related prompts
	Explain = "Por favor, explique como o seguinte código funciona.",
	Review = "Por favor, revise o seguinte código e forneça sugestões de melhoria.",
	Tests = "Por favor, explique como o código selecionado funciona e gere testes unitários para ele.",
	Refactor = "Por favor, refatore o seguinte código para melhorar sua clareza e legibilidade.",
	FixCode = "Por favor, corrija o seguinte código para que ele funcione como pretendido.",
	FixError = "Por favor, explique o erro no texto a seguir e forneça uma solução.",
	BetterNamings = "Por favor, forneça nomes melhores para as seguintes variáveis e funções.",
	Documentation = "Por favor, forneça documentação para o seguinte código.",
	SwaggerApiDocs = "Por favor, forneça documentação para a seguinte API usando Swagger.",
	SwaggerJsDocs = "Por favor, escreva JSDoc para a seguinte API usando Swagger.",
	-- Text related prompts
	Summarize = "Por favor, resuma o seguinte texto.",
	Spelling = "Por favor, corrija quaisquer erros gramaticais e ortográficos no texto a seguir.",
	Wording = "Por favor, melhore a gramática e a escolha de palavras do texto a seguir.",
	Concise = "Por favor, reescreva o texto a seguir para torná-lo mais conciso.",
}

return {
	{ "github/copilot.vim" },

	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		dependencies = {
			"j-hui/fidget.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>aa",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "AI: [A]ctivate Chat (Toggle)",
				mode = { "n", "v" },
			},
			{ "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "AI: [I]nline Assistant", mode = { "n", "v" } },
			{ "<leader>as", "<cmd>CodeCompanionActions<cr>", desc = "AI: [S]elect Actions Menu", mode = { "n", "v" } },
			{
				"<leader>av",
				"<cmd>CodeCompanionChat Add<cr>",
				desc = "AI: Add [V]isual Selection to Chat",
				mode = { "x" },
			},
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					roles = { user = "pedro-malta-schuler" },
					-- SINTAXE BLINDADA CONTRA ERROS DE MODOS:
					keymaps = {
						send = {
							modes = { n = "<CR>", i = "<C-CR>" },
						},
						close = {
							modes = { n = "q" },
						},
						clear = {
							modes = { n = "<C-x>" },
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
			prompt_library = {
				["Explicar Código"] = {
					strategy = "chat",
					description = "Explica o código",
					opts = { short_name = "explain" },
					prompts = { { role = "user", content = prompts.Explain } },
				},
				["Revisar Código"] = {
					strategy = "chat",
					description = "Revisa o código",
					opts = { short_name = "review" },
					prompts = { { role = "user", content = prompts.Review } },
				},
				["Gerar Testes"] = {
					strategy = "chat",
					description = "Gera testes",
					opts = { short_name = "tests" },
					prompts = { { role = "user", content = prompts.Tests } },
				},
				["Refatorar"] = {
					strategy = "inline",
					description = "Refatora o código via Diff",
					opts = { short_name = "refactor" },
					prompts = { { role = "user", content = prompts.Refactor } },
				},
				["Corrigir Erro"] = {
					strategy = "inline",
					description = "Corrige diagnósticos",
					opts = { short_name = "fix" },
					prompts = { { role = "user", content = prompts.FixError } },
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gemini-2.5-pro",
								choices = {
									"gemini-2.5-pro",
									"claude-3.7-sonnet",
									"gpt-4o",
								},
							},
						},
					})
				end,
			},
			display = {
				chat = {
					render_headers = true,
					show_token_count = true,
					window = {
						layout = "vertical",
						width = 45,
						opts = {
							number = true,
							relativenumber = true,
						},
					},
				},
				inline = {
					diff = { provider = "native" },
				},
			},
		},
		init = function()
			vim.cmd([[cab cc CodeCompanion]])
		end,
	},
}
