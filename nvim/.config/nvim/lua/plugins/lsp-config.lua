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
          "mypy",
          "eslint_d",
          "ruff",
          "black",
          "isort",
          "prettierd",
          "stylua",
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
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          -- null_ls.builtins.formatting.phpcsfixer,
          -- null_ls.builtins.formatting.markdownlint,

          --null_ls.builtins.diagnostics.stylelint,
          --null_ls.builtins.diagnostics.phpcs,
          null_ls.builtins.completion.spell,

          null_ls.builtins.diagnostics.mypy,
          require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
          require("none-ls.diagnostics.ruff"), -- requires none-ls-extras.nvim
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
