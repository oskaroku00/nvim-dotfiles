-- return {
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--     branch = 'main',
--     -- [[ Confmain = 'nvim-treesitter', igure Treesitter ]] See `:help nvim-treesitter`
--     main = 'nvim-treesitter',
--     opts = {
--       -- ignore_install = { 'org' },
--       -- Autoinstall languages that are not installed
--       auto_install = true,
--       highlight = {
--         enable = true,
--         -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--         --  If you are experiencing weird indenting issues, add the language to
--         --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--         additional_vim_regex_highlighting = { 'ruby' },
--       },
--       indent = { enable = true, disable = { 'ruby' } },
--     },
--   },
-- }
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  lazy = false,
  config = function()
    local treesitter = require 'nvim-treesitter'
    treesitter.setup {}
    local ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'rust',
    }

    local config = require 'nvim-treesitter.config'
    local already_installed = config.get_installed()
    local parsers_to_install = {}

    for _, parser in ipairs(ensure_installed) do
      if not vim.tbl_contains(already_installed, parser) then
        table.insert(parsers_to_install, parser)
      end
    end

    if #parsers_to_install > 0 then
      treesitter.install(parsers_to_install)
    end

    local group = vim.api.nvim_create_augroup('TreeSitterConfig', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      callback = function(args)
        if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
          vim.treesitter.start(args.buf)
        end
      end,
    })
  end,
}
