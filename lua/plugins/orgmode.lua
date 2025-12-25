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
        mappings = {
          note = {},
          org = {
            org_archive_subtree = '<C-s>',
            org_add_note = '<Leader>oin',
          },
        },
      }
      require('org-bullets').setup()

      require('telescope').setup()
      require('telescope').load_extension 'orgmode'
      vim.keymap.set('n', '<leader>so', require('telescope').extensions.orgmode.search_headings)
      vim.keymap.set('n', '<leader>ol', require('telescope').extensions.orgmode.insert_link)
      -- vim.keymap.set('n', '<leader>ol', require('telescope').extensions.orgmode.insert_link)
    end,
  },
}
