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
        org_todo_keywords = { 'TODO', 'NEXT', '|', 'DONE' },
        win_border = 'rounded',
        mappings = {
          note = {},
          org = {
            org_archive_subtree = '<C-s>',
            org_add_note = '<Leader>oin',
            org_todo = 't',
          },
        },
        org_capture_templates = {
          t = 'TODO',
          tst = {
            description = 'Todo Schedule + Time',
            -- This calculates tomorrow's date automatically
            template = '* TODO %?\n SCHEDULED: %^T',
            target = '~/Documents/vault/org/refile.org',
          },
          ts = {
            description = 'Todo Schedule',
            -- This calculates tomorrow's date automatically
            template = '* TODO %?\n SCHEDULED: %^t',
            target = '~/Documents/vault/org/refile.org',
          },
          td = {
            description = 'Todo Dedline',
            template = '* TODO [A] %?\n DEADLINE: %^t',
            target = '~/Documents/vault/org/refile.org',
          },
          ta = {
            description = 'Todo Alarm',
            template = '* TODO %?      :alarm:\n SCHEDULED: %^T',
            target = '~/Documents/vault/org/refile.org',
          },
          n = {
            description = 'Note',
            template = '* %?      :note:\n Taken on %T\n',
            target = '~/Documents/vault/org/thoughts.org',
          },
          p = {
            description = 'Project',
            template = '* %?      :project:\n Taken on %T\n',
            target = '~/Documents/vault/org/projects-capture.org',
          },
        },
      }
      require('org-bullets').setup()

      require('telescope').setup()
      require('telescope').load_extension 'orgmode'
      vim.keymap.set(
        'n',
        '<leader>so',
        require('telescope').extensions.orgmode.search_headings,
        { desc = 'search headings org' }
      )
      vim.keymap.set(
        'n',
        '<leader>ol',
        require('telescope').extensions.orgmode.insert_link,
        { desc = 'insert org link' }
      )
      vim.keymap.set({ 'n' }, '<leader>oI', '<cmd>Org indent_mode<CR>', { desc = 'Indent org file' })
    end,
  },
}
