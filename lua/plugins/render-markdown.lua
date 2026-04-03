return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- completions = {
      --   blink = { enabled = true },
      -- },
      completions = { lsp = { enabled = true } },
      file_types = { 'markdown' },
      -- link = {
      --   -- This tells the plugin to use the highlight groups we just defined
      --   highlight = 'RenderMarkdownLink',
      --   wiki = { highlight = 'RenderMarkdownWikiLink' },
      -- },
      html = {
        comment = {
          conceal = false,
        },
      },
    },
  },
}
