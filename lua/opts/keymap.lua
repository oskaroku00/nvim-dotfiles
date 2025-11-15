-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Custom

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

vim.keymap.set({ 'i' }, '<S-BS>', '<C-w>', { desc = 'delete word in insert' })

vim.keymap.set({ 'n' }, '<leader>sc', '<cmd>Telescope colorscheme<CR>', { desc = 'todo list search' })
-- Markdown nvim mapsm
vim.keymap.set(
  { 'n' },
  '<leader>st',
  '<cmd>TodoTelescope keywords=TODO,FIX,WARNING;<CR>',
  { desc = 'todo list search' }
)

vim.keymap.set({ 'i' }, '<C-n>', '<C-x><C-n>', { noremap = false, desc = 'autocomplete native without LSP' })
vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>Oil --float<CR>', { desc = 'oil explorer' })
vim.keymap.set({ 'n' }, '<Leader>w', '<Cmd>update<CR>', { desc = 'write' })
vim.keymap.set({ 'n' }, '<Leader>q', '<Cmd>quit<CR>', { desc = 'quit' })
vim.keymap.set({ 'n' }, '<Leader>Q', '<Cmd>wqa!<CR>', { desc = 'quit all force' })

vim.keymap.set({ 'n' }, '<Leader>cr', '<cmd>CompetiTest run<CR>', { desc = 'Competitive run' })
vim.keymap.set({ 'n' }, '<Leader>cp', '<cmd>CompetiTest receive problem<CR>', { desc = 'Competitive recieve problem' })

vim.keymap.set({ 'n' }, '<Leader>p', '"+p', { desc = 'paste system clipboard' })
vim.keymap.set({ 'v', 'x', 'n' }, '<C-y>', '"+y', { desc = 'System clipboard yank.' })
vim.keymap.set({ 'n', 'v', 'x' }, ';', ':', { desc = 'Remap ; to :' })
vim.keymap.set({ 'n', 'v', 'x' }, ':', ';', { desc = 'Remap : to ;' })

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>E', '<Cmd>edit $MYVIMRC<CR>', { desc = 'Edit ' .. vim.fn.expand '$MYVIMRC' })

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

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('no_auto_comment', {}),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- -- show cursorline only in active window disable
-- vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
--   group = "active_cursorline",
--   callback = function()
--     vim.opt_local.cursorline = false
--   end,
-- })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- navigate to and fix next mispelled word
vim.api.nvim_set_keymap('n', '<leader>N', ']s 1z=', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ']s z=', { noremap = true, silent = false })
vim.keymap.set('n', 'zz', 'z=', { noremap = false })
