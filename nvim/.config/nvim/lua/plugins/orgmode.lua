return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/org/agenda/**/*',
      org_default_notes_file = '~/org/notes.org',
    })

  end,
}
