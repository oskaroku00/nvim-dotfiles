-- Help command
-- leader K show help window over text
-- g< show error message spilled in complete buffer
-- ctrl-] in help docks to navigate to index

-- Keymaps cheatsheet
-- Up = '<Up> ',
-- Down = '<Down> ',
-- Left = '<Left> ',
-- Right = '<Right> ',
-- C = '<C-…> ',
-- M = '<M-…> ',
-- D = '<D-…> ',
-- S = '<S-…> ',
-- CR = '<CR> ',
-- Esc = '<Esc> ',
-- ScrollWheelDown = '<ScrollWheelDown> ',
-- ScrollWheelUp = '<ScrollWheelUp> ',
-- NL = '<NL> ',
-- BS = '<BS> ',
-- Space = '<Space> ',
-- Tab = '<Tab> ',
-- F1 = '<F1>',
-- F2 = '<F2>',
-- F3 = '<F3>',
-- F4 = '<F4>',
-- F5 = '<F5>',
-- F6 = '<F6>',
-- F7 = '<F7>',
-- F8 = '<F8>',
-- F9 = '<F9>',
-- F10 = '<F10>',
-- F11 = '<F11>',
-- F12 = '<F12>',
for i = 1, 8 do
  vim.keymap.set({ 'n', 't' }, 'g' .. i, '<Cmd>tabnext ' .. i .. '<CR>')
end
vim.keymap.set({ 'n' }, 'gt', '<cmd>tabnew<CR>', { desc = 'new tab' })

-- Delete word behind the cursor in insert mode using Ctrl+Backspace
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = false, silent = true })
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = false, silent = true })

vim.keymap.set({ 'n' }, '<leader>sc', '<cmd>Telescope colorscheme<CR>', { desc = 'todo list search' })

-- Markdown nvim search todos
vim.keymap.set(
  { 'n' },
  '<leader>st',
  '<cmd>TodoTelescope keywords=TODO,FIX,WARNING;<CR>',
  { desc = 'todo list search' }
)

vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>Oil <CR>', { desc = 'oil explorer' })
vim.keymap.set({ 'n' }, '<Leader>u', '<cmd>Undotree <CR>', { desc = 'undotree' })
-- vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>Oil --float<CR>', { desc = 'oil explorer' })
-- vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>Oil<CR>', { desc = 'oil explorer' })
vim.keymap.set({ 'n' }, '<Leader>w', '<Cmd>update<CR>', { desc = 'write' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-q>', '<Cmd>w<CR><Cmd>bd<CR>', { desc = 'delete buffer' })
vim.keymap.set({ 'n' }, '<Leader>q', '<Cmd>q<CR>', { desc = 'quit' })
vim.keymap.set({ 'n' }, '<Leader>Q', '<Cmd>wqa<CR>', { desc = 'quit all force' })

vim.keymap.set({ 'n' }, '<Leader>cr', '<cmd>CompetiTest run<CR>', { desc = 'Competitive run' })
vim.keymap.set({ 'n' }, '<Leader>cp', '<cmd>CompetiTest receive problem<CR>', { desc = 'Competitive recieve problem' })
-- vim.opt.foldmethod = 'expr' -- Use expression for folding
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Keep all folds open by default
-- vim.keymap.set('x', '<Leader>P', [["_dP]], { desc = 'paste wihtout overriding reg' })
-- vim.keymap.set({ 'n', 'v' }, '<Leader>d', [["_d]], { desc = 'delete without override' })
vim.keymap.set({ 'n' }, '<Leader>p', [["+p]], { desc = 'paste system clipboard' })
vim.keymap.set({ 'v', 'x', 'n' }, '<Leader>y', [["+y]], { desc = 'System clipboard yank.' })
vim.keymap.set({ 'n', 'v', 'x' }, ';', ':', { desc = 'Remap ; to :' })
vim.keymap.set({ 'n', 'v', 'x' }, ':', ';', { desc = 'Remap : to ;' })

vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'rename default' })

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'executable' })

vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>', { silent = true, desc = 'Zen Mode' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'join lines with space' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves lines down' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll centre' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll centre' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Show diagnostic in a floating window
vim.keymap.set('n', 'gD', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor', noremap = true, silent = true  })
vim.keymap.set('n', 'zd', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor', noremap = true, silent = true  })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode into normal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- navigate to and fix next mispelled word
vim.api.nvim_set_keymap('n', '<leader>N', ']s 1z=', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ']s z=', { noremap = true, silent = false })
vim.keymap.set('n', 'zz', 'z=', { noremap = false })

--- TODO insert
vim.keymap.set('n', '<leader>T', function()
  vim.cmd 'normal! OTODO:'
  -- Comment the current line (requires a commenting plugin like 'numToStr/Comment.nvim')
  vim.cmd 'normal gcc'
  -- Move cursor after the colon and space
  vim.cmd 'normal f:a '
  vim.cmd 'startinsert'
end, { noremap = false, silent = true, desc = 'insert project TODO as a comment' })
