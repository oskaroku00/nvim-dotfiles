-- ================================================================================================
-- TITLE : zen-mode
-- ABOUT : Distraction-free coding for Neovim
-- LINKS :
--   > github : https://github.com/folke/zen-mode.nvim
-- DEPENDENCIES/INTEGRATIONS:
--   > twilight.nvim: https://github.com/folke/twilight.nvim
-- ================================================================================================

vim.pack.add {
  'https://github.com/folke/zen-mode.nvim',
}
require('zen-mode').setup {

  window = {
    backdrop = 1,
    width = 0.65,
  },

  plugins = {
    options = { enabled = true, ruler = false, showcmd = false },
    tmux = { enabled = true },
    kitty = { enabled = false, font = '+2' },
  },

  -- on_open = function()
  --   pcall(function() require('twilight').enable() end)
  -- end,
  --
  -- on_close = function()
  --   pcall(function() require('twilight').disable() end)
  -- end,
}
