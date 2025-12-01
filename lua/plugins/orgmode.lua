return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-orgmode/telescope-orgmode.nvim',
      'nvim-orgmode/org-bullets.nvim',
    },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/Documents/vault/org/**/*',
        org_default_notes_file = '~/Documents/vault/org/refile.org',
        -- org_agenda_files = './org/**/*',
        -- org_default_notes_file = './org/refile.org',
      }
      require('org-bullets').setup()

      require('telescope').setup()
      require('telescope').load_extension 'orgmode'
      vim.keymap.set('n', '<leader>fo', require('telescope').extensions.orgmode.search_headings)
      vim.keymap.set('n', '<leader>il', require('telescope').extensions.orgmode.insert_link)
    end,
  },
}
