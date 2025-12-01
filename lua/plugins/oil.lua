return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
      },
      columns = {
        'permissions',
        'icon',
        'size',
      },
      float = {
        max_width = 0.8,
        max_height = 0.8,
        border = 'rounded',
      },
      view_options = {
        show_hidden = true,
        preview_split = 'auto',
      },
      prewiew = true,
    },
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    lazy = false,
    priority = 1000,
  },
}
