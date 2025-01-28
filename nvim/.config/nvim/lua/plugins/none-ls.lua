return {
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
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.phpcsfixer,
        -- null_ls.builtins.formatting.markdownlint,

        --null_ls.builtins.diagnostics.stylelint,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.diagnostics.phpcs,
        --null_ls.builtins.diagnostics.pylint.with({
        --  diagnostics_postprocess = function(diagnostic)
        --    diagnostic.code = diagnostic.message_id
        --  end
        --}),
        --null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint_d"), -- requires none-ls-extras.nvim
        require("none-ls.diagnostics.ruff"), -- requires none-ls-extras.nvim
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
