return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = false }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        java = { 'clang-format' },
        cpp = { 'clang-format' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        clang_format = {
          prepend_args = { '--style=' .. vim.fn.stdpath 'config' .. '/.clang-format', '--fallback-style=LLVM' },
          -- args = function()
          --   -- Fetch indentation settings dynamically
          --   local shiftwidth = vim.api.nvim_get_option 'shiftwidth'
          --   local expandtab = vim.api.nvim_get_option 'expandtab'
          --
          --   -- Build args based on Vim settings
          --   local args = { '--style={BasedOnStyle: llvm, ' }
          --
          --   -- Add tab width based on shiftwidth
          --   table.insert(args, 'IndentWidth: ' .. shiftwidth)
          --
          --   -- Use tabs or keep spaces
          --   if expandtab then
          --     table.insert(args, ', TabWidth: ' .. shiftwidth)
          --     table.insert(args, ', UseTabs: Always')
          --   end
          --
          --   table.insert(args, ' }')
          --   return args
          -- end,
        },
      },
    },
  },
}
