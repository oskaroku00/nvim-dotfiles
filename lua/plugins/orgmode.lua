vim.pack.add {
  'https://github.com/nvim-orgmode/orgmode',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-orgmode/telescope-orgmode.nvim',
  'https://github.com/nvim-orgmode/org-bullets.nvim',
}
require('orgmode').setup {
  org_agenda_files = '~/Documents/org/**/*',
  org_default_notes_file = '~/Documents/org/refile.org',
  org_archive_location = './archive/%s_archive::',
  -- org_agenda_files = './org/**/*',
  org_todo_keywords = { 'TODO(t)', 'NEXT(n)', 'WANT(w)', 'LATER(l)', 'POSPONED(p)', '|', 'DONE(d)' },
  org_todo_keyword_faces = {
    LATER = ':foreground #94ABEF :weight bold',
    POSPONED = ':foreground #C45BEF :weight bold',
    -- DELEGATED = ':background #FFFFFF :slant italic :underline on',
  },
  win_border = 'rounded',
  mappings = {
    note = {},
    org = {
      org_archive_subtree = '<C-s>',
      org_add_note = '<Leader>oin',
      org_todo = 't',
      org_todo_prev = 'T',
    },
  },
  org_capture_templates = {
    t = 'TODO',
    ts = {
      description = 'Todo Schedule NO time',
      template = '* TODO %?\n SCHEDULED: %^t',
      target = '~/Documents/org/refile.org',
    },
    tS = {
      description = 'Todo Schedule + Time',
      template = '* TODO [#A] %?\n SCHEDULED: %^T',
      target = '~/Documents/org/refile.org',
    },
    tw = {
      description = 'Todo Want',
      template = '* POSPONED [#C] %?',
      target = '~/Documents/org/refile.org',
    },
    tt = {
      description = 'Todo normal, no schedule',
      template = '* TODO %?\n',
      target = '~/Documents/org/refile.org',
    },
    td = {
      description = 'Todo Dedline',
      template = '* TODO [#A] %?\n DEADLINE: %^t',
      target = '~/Documents/org/refile.org',
    },
    ta = {
      description = 'Todo Alarm',
      template = '* TODO [#A] %?      :alarm:\n SCHEDULED: %^T',
      target = '~/Documents/org/refile.org',
    },
    n = {
      description = 'Note',
      template = '** %?      :note:\n  TAKEN: %U\n',
      target = '~/Documents/org/daily.org',
    },
    d = {
      description = 'Daily',
      template = '** %U      :daily:\n%?\n',
      target = '~/Documents/org/daily.org',
    },
    p = {
      description = 'Project',
      template = '* LATER %?      :project:\n  TAKEN: %U\n',
      target = '~/Documents/org/projects.org',
    },
    w = {
      description = 'Want mini project',
      template = '* POSPONED %?      :want:\n  TAKEN: %U\n',
      target = '~/Documents/org/projects.org',
    },
  },
}
require('org-bullets').setup()


require('telescope').setup()
require('telescope').load_extension 'orgmode'
vim.keymap.set('n', '<leader>so', require('telescope').extensions.orgmode.search_headings, { desc = 'search headings org' })
-- vim.keymap.set(
--   'n',
--   '<leader>ol',
--   require('telescope').extensions.orgmode.insert_link,
--   { desc = 'insert org link' }
-- )
vim.lsp.enable 'org'
