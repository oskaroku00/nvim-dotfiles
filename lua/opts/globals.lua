vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- this settings are controlled with a autocmd bufenter for text writing files
vim.opt.spelllang = 'en_us,es'
vim.opt.spell = false
vim.opt.shellslash = true

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.opt.wrap = false

vim.o.swapfile = false

vim.opt.termguicolors = true

-- Indenting not too literal guess indent takes care most of the time
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
-- vim.opt.expandtab = false

-- Border of menus
vim.opt.winborder = 'rounded'

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
-- vim.opt.colorcolumn = '+1'
-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Display spaces
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.o.confirm = true

-- No swapfile
-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.cmd [[set noswapfile]]
