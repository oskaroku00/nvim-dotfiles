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
        'mtime',
        'size',
      },
      float = {
        max_width = 0.9,
        max_height = 0.9,
        border = 'bold',
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = { ['<C-h>'] = false },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
    },
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    lazy = false,
  },
}
