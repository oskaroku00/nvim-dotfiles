return {
  {
    'vague2k/vague.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      require('vague').setup {
        -- optional configuration here
        italic = true,
        bold = true,
        transparent = false,
      }
      -- on_highlights = function(hl, c)
      --   -- available options: fg, bg, gui, sp
      --   hl.markdownBold = { fg = c.func, gui = 'bold' }
      --   hl.markdownItalic = c.type -- only overwrite fg
      -- end
      -- vim.cmd 'colorscheme vague'
      -- vim.api.nvim_set_hl(0, 'markdownBold', { link = 'DevIconAvif' })
      -- vim.api.nvim_set_hl(0, 'markdownItalic', { link = 'DevIconCpp' })
    end,
  },
  -- Lazy
  {
    'olimorris/onedarkpro.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      require('onedarkpro').setup {
        -- optional configuration here
        italic = true,
        bold = true,
        transparent = false,
      }
      -- vim.cmd 'colorscheme onedark'
    end,
  },
  { 'EdenEast/nightfox.nvim' },
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other plugins
  config = function()
    require('nightfox').setup {
      -- optional configuration here
      italic = true,
      bold = true,
      transparent = false,
    }
    -- vim.cmd 'colorscheme carbonfox'
  end,
  { 'kihachi2000/yash.nvim' },
  {
    'drewxs/ash.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup {
        -- optional configuration here
        -- italic = true,
        -- bold = true,
        transparent = false,
      }
      vim.cmd 'colorscheme ash'
    end,
  },
}
