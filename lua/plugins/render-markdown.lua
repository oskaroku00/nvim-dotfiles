vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}
require('render-markdown').setup {
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  -- completions = {
  --   blink = { enabled = true },
  -- },
  completions = { lsp = { enabled = true } },
  file_types = { 'markdown' },
  html = {
    comment = {
      conceal = false,
    },
  },
  link = {
    enabled = true,
  },
}
