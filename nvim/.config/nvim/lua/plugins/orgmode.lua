return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/org/agenda/**/*",
        org_default_notes_file = "~/org/notes.org",
      })
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
