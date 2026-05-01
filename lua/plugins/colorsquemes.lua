return {
  {
    'vague2k/vague.nvim',
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      require('vague').setup {
        -- optional configuration here
        -- transparent = true,
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = 'none',
          number = 'none',
          float = 'none',
          error = 'none',
          comments = 'none',
          conditionals = 'none',
          functions = 'none',
          headings = 'bold',
          operators = 'none',
          strings = 'none',
          variables = 'none',

          -- keywords
          keywords = 'none',
          keyword_return = 'none',
          keywords_loop = 'none',
          keywords_label = 'none',
          keywords_exception = 'none',

          -- builtin
          builtin_constants = 'none',
          builtin_functions = 'none',
          builtin_types = 'none',
          builtin_variables = 'none',
        },
        colors = {
          func = '#bc96b0',
          keyword = '#787bab',
          -- string = '#d4bd98',
          string = '#8a739a',
          -- string = "#f2e6ff",
          -- number = "#f2e6ff",
          -- string = "#d8d5b1",
          bold = '#aaaaaa',
          number = '#8f729e',
          -- type = '#dcaed7',
        },
      }
      vim.cmd 'colorscheme vague'
    end,
  },

  -- {
  --   'vague2k/vague.nvim',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other plugins
  --   config = function()
  --     require('vague').setup {
  --       -- optional configuration here
  --       italic = true,
  --       bold = true,
  --       transparent = false,
  --     }
  --     -- on_highlights = function(hl, c)
  --     --   -- available options: fg, bg, gui, sp
  --     --   hl.markdownBold = { fg = c.func, gui = 'bold' }
  --     --   hl.markdownItalic = c.type -- only overwrite fg
  --     -- end
  --     -- vim.cmd 'colorscheme vague'
  --     -- vim.api.nvim_set_hl(0, 'markdownBold', { link = 'DevIconAvif' })
  --     -- vim.api.nvim_set_hl(0, 'markdownItalic', { link = 'DevIconCpp' })
  --   end,
  -- },
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
      -- vim.cmd 'colorscheme onedark_dark'
    end,
  },
}
