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

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

----------------
-- Markdown start
----------------

-- Save text files on exit
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = { 'markdown', 'txt', 'env', 'org', 'wiki' },
  callback = function()
    vim.cmd 'silent! write'
  end,
})

-- Function to create markdown file from a given name
local function create_md(name)
  local cwd = vim.fn.expand '%:h'
  local filename = cwd .. '/' .. name .. '.md'
  local file = io.open(filename, 'w')
  if file then
    file:close()
  end
  vim.cmd('e ' .. filename)
end

-- Local options for note files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt', 'env', 'org', 'wiki', 'orgagenda' },
  callback = function()
    local opts = { buffer = 0, silent = true }
    vim.diagnostic.enable(false, { bufnr = 0 }) -- disable for current buffer

    vim.opt_local.spelllang = 'en_us,es'
    vim.opt_local.spell = true

    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nc'

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.colorcolumn = '80'
    -- vim.opt_local.formatoptions = 'tqranj'
    vim.opt_local.formatoptions:append 't' -- auto-wrap using textwidth
    vim.opt_local.formatoptions:append 'q' -- allow formatting comments
    vim.opt_local.formatoptions:append 'n' -- smart wrap for numbered lists

    -- -- Keybinding: yank text inside [] and create markdown file
    -- vim.keymap.set('n', '<leader>mn', function()
    --   -- Yank text inside []
    --   vim.cmd 'normal! yi['
    --   -- Get yanked text
    --   local name = vim.fn.getreg '"'
    --   -- Call the function
    --   create_md(name)
    -- end, { noremap = true, silent = true, desc = 'create markdown file within []', buffer = 0 })

    vim.keymap.set('n', '<leader>mn', function()
      -- 1. Yank text inside []
      vim.cmd 'normal! yi['

      -- 2. Get the yanked text from the unnamed register
      local raw_name = vim.fn.getreg '"'

      -- 3. Replace spaces with underscores for the filename
      local formatted_name = string.gsub(raw_name, '%s+', '-')

      -- 4. Replace the text inside [] in the actual buffer
      -- This uses the Neovim substitute command on the current line
      vim.cmd('s/\\[' .. vim.pesc(raw_name) .. '\\]/[' .. formatted_name .. ']/')

      -- 5. Create the file using the underscores
      create_md(formatted_name)

      -- Optional: Clear search highlights from the substitution
      vim.cmd 'noh'
    end, { noremap = true, silent = true, desc = 'Create md file and replace spaces', buffer = 0 })

    -- Insert Mode
    local handlers = require 'markdown-plus.list.handlers'
    local checkbox = require 'markdown-plus.list.checkbox'
    local renumber = require 'markdown-plus.list.renumber'
    vim.keymap.set('i', '<CR>', handlers.handle_enter, opts)
    vim.keymap.set('i', '<BS>', handlers.handle_backspace, opts)
    -- Navigate headings
    vim.keymap.set('n', 'gn', '<Plug>(MarkdownPlusNextHeader)', opts)
    vim.keymap.set('n', 'gp', '<Plug>(MarkdownPlusPrevHeader)', opts)
    vim.keymap.set('n', '<CR>', checkbox.toggle_checkbox_insert, opts)
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
    vim.keymap.set(
      { 'n' },
      '<leader>mp',
      '<cmd>Obsidian paste_img<CR><CR><CR>',
      { desc = 'paste obsidian image', buffer = 0 }
    )
    vim.keymap.set({ 'n' }, '<leader>mt', '<cmd>Obsidian template<CR>', { desc = 'templates', buffer = 0 })
    -- vim.keymap.set({ 'n' }, '<leader>ms', '<cmd>Obsidian quick_switch<CR>', { desc = 'search md files' , buffer = 0})
    vim.keymap.set({ 'n' }, '<leader>mb', '<cmd>Obsidian backlinks<CR>', { desc = 'backlinks', buffer = 0 })
    vim.keymap.set({ 'n' }, '<leader>mb', '<cmd>Obsidian search<CR>', { desc = 'search', buffer = 0 })
    -- vim.keymap.set({ 'n' }, '<leader>md', '<cmd>Obsidian dailies<CR>', { desc = 'daily notes' , buffer = 0})
    vim.keymap.set({ 'n' }, '<leader>mg', '<cmd>Obsidian tags<CR>', { desc = 'tags', buffer = 0 })
    vim.keymap.set({ 'n' }, '<leader>mo', '<cmd>Obsidian<CR>', { desc = 'open obsidian general search', buffer = 0 })
    vim.keymap.set(
      { 'n' },
      '<leader>mr',
      '<cmd>Obsidian rename<CR>',
      { desc = 'open obsidian general search', buffer = 0 }
    )
    -- Insert document link
    vim.keymap.set('n', '<leader>mlp', function()
      vim.cmd 'normal "+pVsa]Vsa]:'
      -- "vim.cmd 'normal "+pVsa>Vsa)I[]'
      -- "vim.cmd 'normal a'
    end, { noremap = false, silent = true, buffer = 0, desc = 'default markdown links' })
  end,
})

-----------------------------------------------------------------------------------------
-- Colorcheme start
-----------------------------------------------------------------------------------------
local loc_hl_def = vim.api.nvim_create_namespace 'MDORGHL'
local link_color = '#62aea2'
local highlights = {
  ['SpellBad'] = { sp = '#ff7777', undercurl = true },
  ['Comment'] = { fg = '#8ca0aa', italic = false },

  ['@markup.strong'] = { fg = '#D19A66', bold = true, force = true },
  ['@markup.italic'] = { fg = '#7dcfff', italic = false, force = true },

  ['RenderMarkdownBullet'] = { fg = '#E5C111', underline = false },
  ['@markup.link'] = { fg = link_color }, -- Standard links
  ['@markup.link.label'] = { fg = link_color }, -- [The Label]
  ['@markup.link.url'] = { fg = link_color, underline = true }, -- (the/url)

  ['RenderMarkdownLink'] = { fg = link_color, underline = false, force = true },
  ['RenderMarkdownWikiLink'] = { fg = link_color, underline = false, force = true },
  ['RenderMarkdownLinkInline'] = { fg = link_color },
  ['@markup.link.label.markdown_inline'] = { fg = link_color },
  ['@punctuation.special.markdown'] = { fg = '#6272a4' },

  ['@markup.link.label.symbol'] = { fg = link_color },

  ['rendermarkdownh1bg'] = {
    fg = '#c47fd5', -- soft purple text
    bg = '#3e3352',
    underline = false,
    bold = true,
  },

  ['rendermarkdownh2bg'] = { fg = '#7db6b3', bg = '#2a3d6b', bold = true },

  ['rendermarkdownh3bg'] = { fg = '#8ca0aa', bg = '#3a3c8a', bold = true },

  -- ['rendermarkdownh4bg'] = { fg = '#6272a4', bold = true },

  ['@org.keyword.done'] = { fg = '#72A772' },
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
  callback = function(args)
    vim.api.nvim_win_set_hl_ns(0, loc_hl_def)
  end,
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

-------------------------------------------------------------------------------
--                           Folding section Markdown
-------------------------------------------------------------------------------

-- Checks each line to see if it matches a markdown heading (#, ##, etc.):
-- It’s called implicitly by Neovim’s folding engine by vim.opt_local.foldexpr
function _G.markdown_foldexpr()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)
  local heading = line:match '^(#+)%s'
  if heading then
    local level = #heading
    if level == 1 then
      -- Special handling for H1
      if lnum == 1 then
        return '>1'
      else
        local frontmatter_end = vim.b.frontmatter_end
        if frontmatter_end and (lnum == frontmatter_end + 1) then
          return '>1'
        end
      end
    elseif level >= 2 and level <= 6 then
      -- Regular handling for H2-H6
      return '>' .. level
    end
  end
  return '='
end

local function set_markdown_folding()
  vim.opt_local.foldmethod = 'expr'
  vim.opt_local.foldexpr = 'v:lua.markdown_foldexpr()'
  vim.opt_local.foldlevel = 99

  -- Detect frontmatter closing line
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_first = false
  local frontmatter_end = nil
  for i, line in ipairs(lines) do
    if line == '---' then
      if not found_first then
        found_first = true
      else
        frontmatter_end = i
        break
      end
    end
  end
  vim.b.frontmatter_end = frontmatter_end
end

-- Use autocommand to apply only to markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = set_markdown_folding,
})

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
  -- Move to the top of the file without adding to jumplist
  vim.cmd 'keepjumps normal! gg'
  -- Get the total number of lines
  local total_lines = vim.fn.line '$'
  for line = 1, total_lines do
    -- Get the content of the current line
    local line_content = vim.fn.getline(line)
    -- "^" -> Ensures the match is at the start of the line
    -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
    -- "%s" -> Matches any whitespace character after the "#" characters
    -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
    if line_content:match('^' .. string.rep('#', level) .. '%s') then
      -- Move the cursor to the current line without adding to jumplist
      vim.cmd(string.format('keepjumps call cursor(%d, 1)', line))
      -- Check if the current line has a fold level > 0
      local current_foldlevel = vim.fn.foldlevel(line)
      if current_foldlevel > 0 then
        -- Fold the heading if it matches the level
        if vim.fn.foldclosed(line) == -1 then
          vim.cmd 'normal! za'
        end
        -- else
        --   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
      end
    end
  end
end

local function fold_markdown_headings(levels)
  -- I save the view to know where to jump back after folding
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd 'nohlsearch'
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set('n', 'zj', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otheriise you have to re-open neovim
  vim.cmd 'edit!'
  -- Unfold everything first or I had issues
  vim.cmd 'normal! zR'
  fold_markdown_headings { 6, 5, 4, 3, 2, 1 }
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Fold all headings level 1 or above' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set('n', 'zk', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- vim.keymap.set("n", "<leader>mfk", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd 'edit!'
  -- Unfold everything first or I had issues
  vim.cmd 'normal! zR'
  fold_markdown_headings { 6, 5, 4, 3, 2 }
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Fold all headings level 2 or above' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set('n', 'zl', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- vim.keymap.set("n", "<leader>mfl", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd 'edit!'
  -- Unfold everything first or I had issues
  vim.cmd 'normal! zR'
  fold_markdown_headings { 6, 5, 4, 3 }
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Fold all headings level 3 or above' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set('n', 'z;', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- vim.keymap.set("n", "<leader>mf;", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd 'edit!'
  -- Unfold everything first or I had issues
  vim.cmd 'normal! zR'
  fold_markdown_headings { 6, 5, 4 }
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Fold all headings level 4 or above' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
-- vim.keymap.set('n', '<CR>', function()
--   -- Get the current line number
--   local line = vim.fn.line '.'
--   -- Get the fold level of the current line
--   local foldlevel = vim.fn.foldlevel(line)
--   if foldlevel == 0 then
--     vim.notify('No fold found', vim.log.levels.INFO)
--   else
--     vim.cmd 'normal! za'
--     vim.cmd 'normal! zz' -- center the cursor line on screen
--   end
-- end, { desc = '[P]Toggle fold' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for unfolding markdown headings of level 2 or above
-- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- zj, zk, zl, z; and zu respectively lamw25wmal
vim.keymap.set('n', 'zu', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- vim.keymap.set("n", "<leader>mfu", function()
  -- Reloads the file to reflect the changes
  vim.cmd 'edit!'
  vim.cmd 'normal! zR' -- Unfold all headings
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Unfold all headings level 2 or above' })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- gk jummps to the markdown heading above and then folds it
-- zi by default toggles folding, but I don't need it lamw25wmal
vim.keymap.set('n', 'zi', function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd 'silent update'
  -- Difference between normal and normal!
  -- - `normal` executes the command and respects any mappings that might be defined.
  -- - `normal!` executes the command in a "raw" mode, ignoring any mappings.
  vim.cmd 'normal gk'
  -- This is to fold the line under the cursor
  vim.cmd 'normal! za'
  vim.cmd 'normal! zz' -- center the cursor line on screen
end, { desc = '[P]Fold the heading cursor currently on' })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------
