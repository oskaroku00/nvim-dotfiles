return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    ft = 'markdown',
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
      'Saghen/blink.cmp',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
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
      ui = { enabled = false },
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
    },
  },
}
