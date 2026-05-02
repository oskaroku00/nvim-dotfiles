vim.opt.statusline = '%<%f %h%w%m%r%=%-14.(%l,%c%V%) %b %P'
-- disable mouse popup yet keep mouse enabled
vim.cmd [[
  aunmenu PopUp
  autocmd! nvim.popupmenu
]]

-- Only highlight with treesitter
-- vim.cmd 'syntax off'
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
  end,
})

require('vim._core.ui2').enable {
  enable = true, -- Whether to enable or disable the UI.
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = 'cmd',
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 1, -- Maximum height.
    },
  },
}

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- underline = { severity = { min = vim.diagnostic.severity.WARN } },
  underline = false,

  -- Can switch between these as you prefer
  virtual_text = false, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

-- vim.cmd.packadd 'cfilter'
-- ;im.cmd 'packadd nvim.undotree'
-- vim.cmd 'packadd nvim.diftool'
vim.schedule(function() vim.cmd.packadd 'nvim.undotree' end)
vim.schedule(function() vim.cmd.packadd 'nvim.diftool' end)

-- nvim 0.11 settings
-- this settings are controlled with a autocmd bufenter for text writing files
vim.opt.spelllang = 'en_us,es'
vim.opt.spell = false
vim.opt.shellslash = true

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

-- Enable break indent
vim.o.breakindent = true
vim.opt.wrap = false

vim.opt.termguicolors = true

-- Indenting not too literal guess indent takes care most of the time
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.colorcolumn = '80'
-- Border of menus
vim.opt.winborder = 'rounded'
-- vim.opt.winborder = 'single'
-- vim.opt.winborder = 'bold'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
-- Only works if textwidth is set (ex: markdown files, custom defined)
-- vim.opt.colorcolumn = '+1'
-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
-- vim.o.splitright = false
vim.o.splitbelow = true

-- Display spaces
vim.o.list = true
vim.opt.listchars = { tab = '<->', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.sidescrolloff = 15

vim.o.confirm = true

-- No swapfile
-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.cmd [[set noswapfile]]

-- Folding
vim.opt.foldmethod = 'expr' -- Use expression for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Keep all folds open by default

-- Set the background to a dark grey and the text to white
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#232332', fg = '#cdd6f4' })

-- Set the border color
-- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#89b4fa' })
