vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}
-- [[ Formatting ]]
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    local disable_filetypes = { c = true, cpp = true }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    java = { 'clang_format' },
    cpp = { 'clang_format' },
    c = { 'clang_format' },
    python = { 'isort', 'black' },
  },
  formatters = {
    clang_format = {
      prepend_args = {
        '--style=file:' .. vim.fn.stdpath 'config' .. '/.clang-format',
      },
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
