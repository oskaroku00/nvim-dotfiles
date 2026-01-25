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
        org_archive_location = './archive/%s_archive::',
        -- org_agenda_files = './org/**/*',
        org_todo_keywords = { 'LATER', 'TODO', 'NEXT', '|', 'DONE' },
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
          ts = {
            description = 'Todo Schedule + Time',
            template = '* TODO %?\n SCHEDULED: %^T',
            target = '~/Documents/vault/org/refile.org',
          },
          tS = {
            description = 'Todo Schedule',
            template = '* TODO [#A] %?\n SCHEDULED: %^t',
            target = '~/Documents/vault/org/refile.org',
          },
          tw = {
            description = 'Todo Want',
            template = '* TODO [#C] %?',
            target = '~/Documents/vault/org/refile.org',
          },
          tt = {
            description = 'Todo normal, no schedule',
            template = '* TODO %?\n',
            target = '~/Documents/vault/org/refile.org',
          },
          td = {
            description = 'Todo Dedline',
            template = '* TODO [#A] %?\n DEADLINE: %^t',
            target = '~/Documents/vault/org/refile.org',
          },
          ta = {
            description = 'Todo Alarm',
            template = '* TODO [#A] %?      :alarm:\n SCHEDULED: %^T',
            target = '~/Documents/vault/org/refile.org',
          },
          n = {
            description = 'Note',
            template = '* %?      :note:\n  TAKEN: %U\n',
            target = '~/Documents/vault/org/thoughts.org',
          },
          d = {
            description = 'Daily',
            template = '* %U      :daily:\n%?\n',
            target = '~/Documents/vault/org/thoughts.org',
          },
          p = {
            description = 'Project',
            template = '* LATER %?      :project:\n  TAKEN: %U\n',
            target = '~/Documents/vault/org/projects-capture.org',
          },
          w = {
            description = 'Want mini project',
            template = '* LATER %?      :want:\n  TAKEN: %U\n',
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
