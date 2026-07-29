-- LSP diagnostics
-- Auto open float diagnostic error
vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    vim.diagnostic.open_float {
      scope = 'cursor',
      focus = false,
    }
  end,
})

-- close some filetypes with <q>

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'lspinfo',
    'checkhealth',
    'qf',
    'nvim.undotree',
    'grug-far',
  },
  callback = function(event)
    vim.keymap.set('n', 'q', function()
      vim.cmd 'close'
    end, { buffer = event.buf, silent = true })
  end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function() vim.cmd 'normal! zz' end)
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
  callback = function() vim.opt_local.formatoptions:remove { 'c', 'r', 'o' } end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

----------------
-- Markdown start
----------------

-- Save text files on exit
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = { 'markdown', 'txt', 'env', 'org', 'wiki' },
  callback = function() vim.cmd 'silent! write' end,
})

-- Function to create markdown file from a given name
local function create_md(name)
  local cwd = vim.fn.expand '%:h'
  local filename = cwd .. '/' .. name .. '.md'
  local file = io.open(filename, 'w')
  if file then file:close() end
  vim.cmd('e ' .. filename)
end

-- Local options for note files
local function smart_gx()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-indexed column

  -- Search for the [[...]] pattern around the cursor
  -- This regex looks for the start [[ and end ]] on the current line
  local start_pos, end_pos, match = line:find '%[%[(.-)%]%]'

  -- Check if the cursor is actually within the detected brackets
  if start_pos and col >= start_pos and col <= end_pos then
    -- It's a wiki link! Open the file (stripping any extra spaces)
    local target = vim.trim(match)
    -- print('Opening WikiLink: ' .. target)
    -- vim.ui.open(vim.fn.fnameescape(target))
    vim.ui.open(target)
  else
    -- Fallback to default gx behavior (URLs, etc.)
    -- In Neovim 0.10+, gx calls vim.ui.open by default
    vim.ui.open(vim.fn.expand '<cfile>')
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt', 'env', 'org', 'wiki', 'orgagenda' },
  callback = function()
    local opts = { buffer = 0, silent = true }
    vim.diagnostic.enable(false, { bufnr = 0 }) -- disable for current buffer

    vim.opt_local.spelllang = 'en_us,es'
    vim.opt_local.spell = true

    -- vim.opt_local.conceallevel = 2
    -- vim.opt_local.concealcursor = 'nc'

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.colorcolumn = '80'
    -- vim.opt_local.formatoptions = 'tqranj'
    vim.opt_local.formatoptions:append 't' -- auto-wrap using textwidth
    vim.opt_local.formatoptions:append 'q' -- allow formatting comments
    vim.opt_local.formatoptions:append 'n' -- smart wrap for numbered lists

    vim.keymap.set('n', '<leader>mn', function()
      -- 1. Yank text inside []
      vim.cmd 'normal! yi['

      -- 2. Get the yanked text from the unnamed register
      local raw_name = vim.fn.getreg '"'

      -- 3. Replace spaces with underscores for the filename
      local formatted_name = string.gsub(raw_name, '%s+', '_')

      -- 4. Replace the text inside [] in the actual buffer
      -- This uses the Neovim substitute command on the current line
      vim.cmd('s/\\[' .. vim.pesc(raw_name) .. '\\]/[' .. formatted_name .. ']/')

      -- 5. Create the file using the underscores
      create_md(formatted_name)

      -- Optional: Clear search highlights from the substitution
      vim.cmd 'noh'
    end, { noremap = true, silent = true, desc = 'Create md file and replace spaces', buffer = 0 })

    -- opening files gx
    vim.keymap.set('n', 'gx', smart_gx, opts)

    -- Insert Mode
    local handlers = require 'markdown-plus.list.handlers'
    local checkbox = require 'markdown-plus.list.checkbox'
    local renumber = require 'markdown-plus.list.renumber'
    vim.keymap.set('i', '<CR>', handlers.handle_enter, opts)
    vim.keymap.set('i', '<BS>', handlers.handle_backspace, opts)
    -- Navigate headings
    vim.keymap.set('n', 'gn', '<Plug>(MarkdownPlusNextHeader)', opts)
    vim.keymap.set('n', 'gp', '<Plug>(MarkdownPlusPrevHeader)', opts)
    -- vim.keymap.set('n', '<CR>', checkbox.toggle_checkbox_insert, opts)
    -- Normal mode
    vim.keymap.set('n', '<leader>mr', '<Plug>(MarkdownPlusRenumberLists)', opts)
    vim.keymap.set('n', '<leader>md', '<Plug>(MarkdownPlusDebugLists)', opts)

    vim.keymap.set('n', 'o', '<Plug>(MarkdownPlusNewListItemBelow)', opts)
    vim.keymap.set('n', 'O', '<Plug>(MarkdownPlusNewListItemAbove)', opts)

    vim.keymap.set('n', '<leader>mq', '<Plug>(MarkdownPlusToggleQuote)', opts)
    vim.keymap.set('x', '<leader>mq', '<Plug>(MarkdownPlusToggleQuote)', opts)
    vim.keymap.set('n', '<leader>mc', '<Plug>(MarkdownPlusInsertCallout)', opts)
    vim.keymap.set('x', '<leader>mc', '<Plug>(MarkdownPlusInsertCallout)', opts)
    vim.keymap.set({ 'x', 'n' }, '<C-b>', '<Plug>(MarkdownPlusBold)', opts)
    vim.keymap.set({ 'x', 'n' }, '<C-i>', '<Plug>(MarkdownPlusItalic)', opts)
    vim.keymap.set({ 'x', 'n' }, '<C-x>', '<Plug>(MarkdownPlusClearFormatting)', opts)

    vim.keymap.set('n', '<leader>mli', '<Plug>(MarkdownPlusInsertLink)')
    vim.keymap.set('v', '<leader>mli', '<Plug>(MarkdownPlusSelectionToLink)')
    vim.keymap.set('n', '<leader>mle', '<Plug>(MarkdownPlusEditLink)')
    vim.keymap.set('n', '<leader>mlr', '<Plug>(MarkdownPlusConvertToReference)')
    vim.keymap.set('n', '<leader>mln', '<Plug>(MarkdownPlusConvertToInline)')
    vim.keymap.set('n', '<leader>mla', '<Plug>(MarkdownPlusAutoLinkURL)')

    vim.keymap.set('n', '<leader>mfi', '<Plug>(MarkdownPlusFootnoteInsert)', opts)
    vim.keymap.set('n', '<leader>mfe', '<Plug>(MarkdownPlusFootnoteEdit)', opts)
    vim.keymap.set('n', '<leader>mfd', '<Plug>(MarkdownPlusFootnoteDelete)', opts)
    vim.keymap.set('n', '<leader>mfg', '<Plug>(MarkdownPlusFootnoteGotoDefinition)', opts)
    vim.keymap.set('n', '<leader>mfr', '<Plug>(MarkdownPlusFootnoteGotoReference)', opts)
    vim.keymap.set('n', '<leader>mfn', '<Plug>(MarkdownPlusFootnoteNext)', opts)
    vim.keymap.set('n', '<leader>mfp', '<Plug>(MarkdownPlusFootnotePrev)', opts)
    vim.keymap.set('n', '<leader>mfl', '<Plug>(MarkdownPlusFootnoteList)', opts)

    vim.keymap.set('i', '<Tab>', '<Plug>(MarkdownPlusListIndent)', opts)
    vim.keymap.set('i', '<S-Tab>', '<Plug>(MarkdownPlusListOutdent)', opts)

    -- Obsidian nvim
    vim.keymap.set({ 'n' }, '<leader>mp', ':Obsidian paste_img<CR><CR><CR>I- <Esc>', { desc = 'paste obsidian image', buffer = 0 })
    vim.keymap.set({ 'n' }, '<leader>mt', '<cmd>Obsidian template<CR>', { desc = 'templates', buffer = 0 })
    -- vim.keymap.set({ 'n' }, '<leader>ms', '<cmd>Obsidian quick_switch<CR>', { desc = 'search md files' , buffer = 0})
    vim.keymap.set({ 'n' }, '<leader>ms', '<cmd>Obsidian search<CR>', { desc = 'search', buffer = 0 })
    -- vim.keymap.set({ 'n' }, '<leader>md', '<cmd>Obsidian dailies<CR>', { desc = 'daily notes' , buffer = 0})
    vim.keymap.set({ 'n' }, '<leader>mg', '<cmd>Obsidian tags<CR>', { desc = 'tags', buffer = 0 })
    vim.keymap.set({ 'n' }, '<leader>mo', '<cmd>Obsidian<CR>', { desc = 'open obsidian general search', buffer = 0 })
    vim.keymap.set({ 'n' }, '<leader>mr', '<cmd>Obsidian rename<CR>', { desc = 'open obsidian general search', buffer = 0 })
    -- vim.keymap.set({ 'n' }, '<leader>mb', '<cmd>Obsidian backlinks<CR>', { desc = 'backlinks', buffer = 0 })
    vim.keymap.set('n', '<leader>mb', function()
      vim.cmd 'normal gg'
      vim.cmd 'Obsidian backlinks'
    end, { noremap = false, silent = true, buffer = 0, desc = 'buffer backlinks' })
    vim.keymap.set('n', '<leader>mit', function()
      vim.cmd 'normal I:TODO:'
      vim.cmd 'normal gcc0bi'
    end, { noremap = false, silent = true, buffer = 0, desc = 'inset markdown TODO for search' })
    -- Insert document link
    vim.keymap.set('n', '<leader>mlp', ':read !~/.config/scripts/yazi_copy_file_path_relative.sh<CR>', { desc = 'Insert relative path from clipboard' })
  end,
})

-----------------------------------------------------------------------------------------
-- Colorcheme start MARKDOWN + ORGFILE
-----------------------------------------------------------------------------------------
local loc_hl_def = vim.api.nvim_create_namespace 'MDORGHL'
local link_color = '#62aea2'
local highlights = {
  ['SpellBad'] = { sp = '#ff7777', undercurl = true },
  -- ['Comment'] = { fg = '#8ca0aa', italic = false },
  ['Comment'] = { fg = '#606079', italic = false },

  ['@markup.strong'] = { fg = '#D19A66', bold = true, force = true },
  ['@markup.italic'] = { fg = '#7dcfff', italic = false, force = true },

  ['RenderMarkdownBullet'] = { fg = '#8ca0aa', underline = false },
  -- ['@markup.link'] = { fg = link_color }, -- Standard links
  -- ['@markup.link.label'] = { fg = link_color }, -- [The Label]
  -- ['@markup.link.url'] = { fg = link_color, underline = true }, -- (the/url)
  --
  -- ['RenderMarkdownLink'] = { fg = link_color, underline = false, force = true },
  -- ['RenderMarkdownWikiLink'] = { fg = link_color, underline = false, force = true },
  -- ['RenderMarkdownLinkInline'] = { fg = link_color },
  -- ['@markup.link.label.markdown_inline'] = { fg = link_color },
  -- ['@punctuation.special.markdown'] = { fg = '#6272a4' },

  -- ['rendermarkdownh1bg'] = {
  --   fg = '#c17fd5', -- soft purple text
  --   bg = '#3e3352',
  --   underline = false,
  --   bold = true,
  -- },
  --
  -- ['rendermarkdownh2bg'] = { fg = '#7db6b3', bg = '#2a3d6b', bold = true },
  -- ['rendermarkdownh1bg'] = { fg = '#7db6b3', bg = '#2a3d6b', bold = true },
  --
  ['rendermarkdownh1bg'] = { fg = '#8ca0aa', bg = '#3a3c8a', bold = true },
  -- ['rendermarkdownh3bg'] = { fg = '#8ca0aa', bg = '#3a3c8a', bold = true },
  --
  -- ['rendermarkdownh5bg'] = { fg = '#6272a4', bold = true },
  --
  ['@org.keyword.done'] = { fg = '#729772' },
  ['@org.timestamp.active'] = { fg = '#c47fd5' },
  ['@org.keyword.scheduled'] = { fg = '#8A739A', force = true },
  ['@org.agenda.scheduled'] = { fg = '#adcfff', force = true },
  ['@org.agenda.deadline'] = { fg = '#FFaaaa' },
  ['@org.headline.level1'] = {
    fg = '#c47fd5', -- soft purple text
    bg = '#3e3352',
    underline = false,
  },
  ['@org.headline.level2'] = { fg = '#7db6b3', bg = '#2a3d6b', bold = true },
  ['@org.headline.level3'] = { fg = '#8ca0aa', bg = '#3a3c8a', bold = true },
  ['@org.headline.level4'] = { fg = '#6272a4', bold = true },
}

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(loc_hl_def, group, opts)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  pattern = { 'markdown', 'org', 'orgagenda', 'txt', 'wiki' },
  callback = function(args) vim.api.nvim_win_set_hl_ns(0, loc_hl_def) end,
})
vim.api.nvim_create_autocmd('BufLeave', {
  buffer = 0,
  callback = function()
    vim.api.nvim_win_set_hl_ns(0, 0) -- Reset to default namespace
  end,
})
-----------------------------------------------------------------------------------------
-- Colorcheme end
-----------------------------------------------------------------------------------------
----------------
-- Markdown end
----------------
