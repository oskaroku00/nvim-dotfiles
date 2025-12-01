return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
      vim.keymap.set('n', '<leader>De', '<cmd>TinyInlineDiag enable<cr>', { desc = 'Enable diagnostics' })
      vim.keymap.set('n', '<leader>Dd', '<cmd>TinyInlineDiag disable<cr>', { desc = 'Disable diagnostics' })
      vim.keymap.set('n', '<leader>Dt', '<cmd>TinyInlineDiag toggle<cr>', { desc = 'Toggle diagnostics' })
    end,
  },
}
