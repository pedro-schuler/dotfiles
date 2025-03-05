return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    --Use treesitter as code folder
    -- require("ufo").setup({
    --   provider_selector = function(bufnr, filetype, buftype)
    --     return { "treesitter", "indent" }
    --   end,
    --  })

    -- Use LSP as code folder
    require("ufo").setup()

    -- Options for code folding
    -- Use 1 column for displaying info
    vim.opt.foldcolumn = "1"
    -- This option lets the first line by highlighted
    vim.opt.foldtext = ""
    -- Set the level of folding
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    -- Set how many levels should be folded
    vim.opt.foldnestmax = 4

    -- set keymaps
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
  end,
}
