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
    width = 86,
  },

  plugins = {
    options = { enabled = true, ruler = false, showcmd = false, laststatus = 0, },
    tmux = { enabled = false },
  },
}
