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

vim.keymap.set({ 'i' }, '<C-BS>', '<C-w>', { desc = 'delete word in insert', remap = true })

vim.keymap.set({ 'n' }, '<leader>sc', '<cmd>Telescope colorscheme<CR>', { desc = 'todo list search' })

-- Markdown nvim search todos
vim.keymap.set(
  { 'n' },
  '<leader>st',
  '<cmd>TodoTelescope keywords=TODO,FIX,WARNING;<CR>',
  { desc = 'todo list search' }
)

vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>Oil --float<CR>', { desc = 'oil explorer' })
vim.keymap.set({ 'n' }, '<Leader>w', '<Cmd>update<CR>', { desc = 'write' })
vim.keymap.set({ 'n' }, '<Leader>wd', '<Cmd>bd<CR>', { desc = 'delete buffer' })
vim.keymap.set({ 'n' }, '<Leader>q', '<Cmd>q<CR>', { desc = 'quit' })
vim.keymap.set({ 'n' }, '<Leader>Q', '<Cmd>wqa<CR>', { desc = 'quit all force' })

vim.keymap.set({ 'n' }, '<Leader>cr', '<cmd>CompetiTest run<CR>', { desc = 'Competitive run' })
vim.keymap.set({ 'n' }, '<Leader>cp', '<cmd>CompetiTest receive problem<CR>', { desc = 'Competitive recieve problem' })

vim.keymap.set({ 'n' }, '<Leader>p', '"+p', { desc = 'paste system clipboard' })
vim.keymap.set({ 'v', 'x', 'n' }, '<C-y>', '"+y', { desc = 'System clipboard yank.' })
vim.keymap.set({ 'n', 'v', 'x' }, ';', ':', { desc = 'Remap ; to :' })
vim.keymap.set({ 'n', 'v', 'x' }, ':', ';', { desc = 'Remap : to ;' })

vim.keymap.set(
  { 'n', 'v', 'x' },
  '<leader>E',
  '<Cmd>edit $MYVIMRC<CR>',
  { desc = 'Edit vimrc' .. vim.fn.expand '$MYVIMRC' }
)

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves lines down' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'scroll centre' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'scroll centre' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-------------
-- Markdown
-------------
-- Obsidian nvim
vim.keymap.set({ 'n' }, '<leader>mp', '<cmd>Obsidian paste_img<CR><CR><CR>', { desc = 'paste obsidian image' })
vim.keymap.set({ 'n' }, '<leader>mt', '<cmd>Obsidian template<CR>', { desc = 'templates' })
-- vim.keymap.set({ 'n' }, '<leader>ms', '<cmd>Obsidian quick_switch<CR>', { desc = 'search md files' })
vim.keymap.set({ 'n' }, '<leader>mb', '<cmd>Obsidian backlinks<CR>', { desc = 'backlinks' })
-- vim.keymap.set({ 'n' }, '<leader>md', '<cmd>Obsidian dailies<CR>', { desc = 'daily notes' })
vim.keymap.set({ 'n' }, '<leader>mg', '<cmd>Obsidian tags<CR>', { desc = 'tags' })
vim.keymap.set({ 'n' }, '<leader>mo', '<cmd>Obsidian<CR>', { desc = 'open obsidian general search' })

--- TODO insert
vim.keymap.set('n', '<leader>T', function()
  vim.cmd 'normal! OTODO:'
  -- Comment the current line (requires a commenting plugin like 'numToStr/Comment.nvim')
  vim.cmd 'normal gcc' -- 'gcc' is the default toggle comment in Comment.nvim
  -- Move cursor after the colon and space
  vim.cmd 'normal f:a '
  vim.cmd 'startinsert'
end, { noremap = false, silent = true })
-------------
-- Markdown end
-------------
