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
          path = '~/Documents/Obsidian-Vault-Oskar',
        },
        -- {
        -- name = "no-vault",
        -- path = function()
        --   -- alternatively use the CWD:
        --   -- return assert(vim.fn.getcwd())
        --   return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        -- end,
        -- overrides = {
        --   notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
        --   new_notes_location = "current_dir",
        --   templates = {
        --     folder = vim.NIL,
        --   },
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
        min_chars = 2,
        create_new = false,
      },
      new_notes_location = 'current_dir',
      legacy_commands = false,
      ui = { enabled = false },
      attachments = {
        img_folder = '/assets',
        -- img_text_func = function(path)
        --   local name = vim.fs.basename(tostring(path))
        --   local encoded_name = require("obsidian.util").urlencode(name)
        --   return string.format("![%s](%s)", name, encoded_name)
        -- end,
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
