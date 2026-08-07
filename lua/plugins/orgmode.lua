vim.pack.add {
  'https://github.com/nvim-orgmode/orgmode',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-orgmode/telescope-orgmode.nvim',
  -- 'https://github.com/nvim-orgmode/org-bullets.nvim',
}
local org_location = '~/org/'
require('orgmode').setup {
  org_agenda_files = '~/org/**/',
  org_default_notes_file = '~/org/refile.org',
  org_archive_location = './archive/%s_archive::',
  -- org_agenda_files = './org/**/*',
  org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'WANT(w)', 'LATER(l)', 'POSPONED(p)', '|', 'DONE(d)' },
  org_todo_keyword_faces = {
    LATER = ':foreground #94ABEF :weight bold',
    POSPONED = ':foreground #C45BEF :weight bold',
    -- DELEGATED = ':background #FFFFFF :slant italic :underline on',
  },
  mappings = {
    note = {},
    org = {
      org_archive_subtree = '<C-s>',
      org_add_note = '<Leader>oin',
      org_todo = 't',
      org_todo_prev = 'T',
    },
  },
  vim.lsp.enable('org'),
  org_capture_templates = {
    t = 'TODO',
    ts = {
      description = 'Todo Schedule NO time',
      template = '* TODO %?\n SCHEDULED: %^t',
      -- target = '~/Documents/org/refile.org',
      target = org_location .. 'refile.org',
    },
    tS = {
      description = 'Todo Schedule + Time',
      template = '* TODO [#A] %?\n SCHEDULED: %^T',
      target = org_location .. 'refile.org',
    },
    tw = {
      description = 'Todo Want',
      template = '* POSPONED [#C] %?',
      target = org_location .. 'refile.org',
    },
    tt = {
      description = 'Todo normal, no schedule',
      template = '* TODO %?\n',
      target = org_location .. 'refile.org',
    },
    td = {
      description = 'Todo Dedline',
      template = '* TODO [#A] %?\n DEADLINE: %^t',
      target = org_location .. 'refile.org',
    },
    ta = {
      description = 'Todo Alarm',
      template = '* TODO [#A] %?      :alarm:\n SCHEDULED: %^T',
      target = org_location .. 'refile.org',
    },
    n = {
      description = 'Note',
      template = '** %?      :note:\n  TAKEN: %U\n',
      target = org_location .. 'daily.org',
    },
    d = {
      description = 'Daily',
      template = '** %U      :daily:\n%?\n',
      target = org_location .. 'daily.org',
    },
    p = {
      description = 'Project',
      template = '* LATER %?      :project:\n  TAKEN: %U\n',
      target = org_location .. 'projects.org',
    },
    w = {
      description = 'Want mini project',
      template = '* POSPONED %?      :want:\n  TAKEN: %U\n',
      target = org_location .. 'projects.org',
    },
  },
}
-- require('org-bullets').setup()


require('telescope').setup({})
require('telescope').load_extension 'orgmode'
vim.keymap.set('n', '<leader>so', require('telescope').extensions.orgmode.search_headings, { desc = 'search headings org' })
