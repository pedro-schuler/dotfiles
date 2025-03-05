local servers = {
  -- Lua
  "lua_ls",
  -- Python
  "pyright",
  -- Javascript
  "eslint",
  -- Typescript
  "ts_ls",
  -- Svelte
  "svelte",
  -- LaTeX
  "texlab",
  -- PHP
  "intelephense",
  -- R!
  "r_language_server",
  -- Org
  "textlsp",
  -- Markdown
  "marksman",
  -- TOML
  "taplo",
}

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "eslint_d",
          "ruff",
          "black",
          "isort",
          "mypy",
          "prettierd",
          "stylua",
          "markdownlint",
          "latexindent",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      for _, lsp in ipairs(servers) do
        if lsp == "textlsp" then
          lspconfig[lsp].setup({
            capabilities = capabilities,
            filetypes = { "text", "org" },
          })
        else
          lspconfig[lsp].setup({
            capabilities = capabilities,
          })
        end
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>td", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end, { silent = true, noremap = true })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      null_ls.setup({
        --Format on save using None-ls
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,

        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.markdownlint,
          -- null_ls.builtins.formatting.phpcsfixer,
          -- null_ls.builtins.formatting.markdownlint,
          require("none-ls.formatting.latexindent"), -- requires none-ls-extras.nvim

          --null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
              local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
              return { "--python-executable", virtual .. "/bin/python3" }
            end,
          }),
          null_ls.builtins.completion.spell,

          require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
          require("none-ls.diagnostics.ruff"), -- requires none-ls-extras.nvim
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
