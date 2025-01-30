return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true,      -- Auto close tags
          enable_rename = true,     -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })

      configs.setup({
        auto_install = true,
        -- ensure_installed = { "lua", "javascript", "html" },
        -- sync_install = false,
        highlight = {
          enable = true,
          disable = { "latex", "org" },
        },
        indent = { enable = true },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
  },
}
