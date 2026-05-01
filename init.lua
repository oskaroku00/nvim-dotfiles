vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'settings.options'
require 'settings.keymaps'
require 'settings.autocmds'

-- :TODO: corregir indentation paths
-- :TODO: eliminate all uneeded things
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
require('lazy').setup {
  spec = {
    -- This imports everything under ~/.config/nvim/lua/plugins/
    -- EXCEPT this init.lua file (lazy is smart enough to handle that)
    { import = 'plugins' },
  },
  -- checker = { enabled = true }, -- Automatically check for plugin updates
}
-- require('lazy').setup(
--   {
--     { import = 'plugins' },
--   }
--   -- {
--   --   ui = {
--   --     -- If you are using a Nerd Font: set icons to an empty table which will use the
--   --     -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
--   --     icons = vim.g.have_nerd_font and {} or {
--   --       cmd = '⌘',
--   --       config = '🛠',
--   --       event = '📅',
--   --       ft = '📂',
--   --       init = '⚙',
--   --       keys = '🗝',
--   --       plugin = '🔌',
--   --       runtime = '💻',
--   --       require = '🌙',
--   --       source = '📄',
--   --       start = '🚀',
--   --       task = '📌',
--   --       lazy = '💤 ',
--   --     },
--   --   },
--   -- }
-- )
