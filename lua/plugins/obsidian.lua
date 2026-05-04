vim.pack.add {
  {
    src = 'https://github.com/obsidian-nvim/obsidian.nvim',
    version = vim.version.range '*', -- use latest release, remove to use latest commit
  },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/nvim-telescope/telescope.nvim',
}
require('obsidian').setup {
  workspaces = {
    {
      name = 'personal-vault',
      path = '~/Documents/vault/md',
    },
  },
  frontmatter = {
    enabled = false,
  },
  daily_notes = {
    folder = '/daily',
    date_format = '%d-%m-%Y',
    alias_format = '%B %-d, %Y',
    template = 'daily',
    workdays_only = false,
  },
  completion = {
    nvim_cmp = false,
    blink = true,
    min_chars = 1,
    create_new = false,
  },
  footer = {
    enabled = false,
  },
  new_notes_location = 'current_dir',
  legacy_commands = false,
  ui = { enable = false },
  attachments = {
    folder = '/assets',
  },
  templates = {
    folder = 'templates',
    date_format = '%d-%m-%Y',
  },
  checkbox = {
    enabled = false,
    create_new = false,
    order = { ' ', 'x' },
  },
  
}
