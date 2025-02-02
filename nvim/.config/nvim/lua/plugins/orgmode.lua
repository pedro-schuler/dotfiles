return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    dependencies = {
      "akinsho/org-bullets.nvim",
    },
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/org/agenda/**/*",
        org_default_notes_file = "~/org/notes.org",
      })
      require("org-bullets").setup()
    end,
  },
  {
    "chipsenkbeil/org-roam.nvim",
    version = "*",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "~/org/roam/",
      })
    end,
  },
}
