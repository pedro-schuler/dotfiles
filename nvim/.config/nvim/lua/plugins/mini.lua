return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.comment").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.basics").setup({
      options = {
        basic = true,
      },
      mappings = {
        basic = true,
        windows = true,
      },
    })
    require("mini.misc").setup()
  end,
}
