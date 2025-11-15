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

-- Obsidian nvim
vim.keymap.set({ 'n' }, '<leader>op', '<cmd>Obsidian paste_img<CR><CR><CR>', { desc = 'paste obsidian image' })
vim.keymap.set({ 'n' }, '<leader>ot', '<cmd>Obsidian template<CR>', { desc = 'templates' })
vim.keymap.set({ 'n' }, '<leader>os', '<cmd>Obsidian quick_switch<CR>', { desc = 'search md files' })
vim.keymap.set({ 'n' }, '<leader>ob', '<cmd>Obsidian backlinks<CR>', { desc = 'backlinks' })
vim.keymap.set({ 'n' }, '<leader>od', '<cmd>Obsidian dailies<CR>', { desc = 'daily notes' })
vim.keymap.set({ 'n' }, '<leader>og', '<cmd>Obsidian tags<CR>', { desc = 'tags' })
vim.keymap.set({ 'n' }, '<leader>oo', '<cmd>Obsidian<CR>', { desc = 'open obsidian general search' })

-- Disable diagnostics and enable spell for markdown-like files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt', 'env' },
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 }) -- disable for current buffer
    vim.opt.spelllang = 'en_us,es'
    vim.opt.spell = true
    vim.opt.linebreak = true
    -- vim.cmd 'colorscheme vage'
  end,
})

-- Re-enable diagnostics when entering non-markdown buffers
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= 'markdown' and ft ~= 'txt' and ft ~= 'env' then
      vim.diagnostic.enable(true, { bufnr = 0 }) -- enable for current buffer
      vim.opt.spell = false
      vim.opt.linebreak = false
    end
  end,
})

-- Save markdown files on exit
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*.md',
  callback = function()
    vim.cmd 'silent! write'
    -- vim.cmd 'colorscheme vage'
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

-- Keybinding: yank text inside [] and create markdown file
vim.keymap.set('n', '<leader>cm', function()
  -- Yank text inside []
  vim.cmd 'normal! yi['
  -- Get yanked text
  local name = vim.fn.getreg '"'
  -- Call the function
  create_md(name)
end, { noremap = true, silent = true, desc = 'create markdown file within []' })

-- fzf
vim.keymap.set('n', '<leader>z', function()
  -- Yank text inside []
  vim.cmd 'normal yi['

  -- Get the yanked text from register "
  local text = vim.fn.getreg '"'

  -- Open a terminal and run the script with the text
  vim.cmd('split | terminal sh -c "~/.config/scripts/fzf_zathura.sh ' .. vim.fn.shellescape(text) .. '"')
end, { desc = 'file search inside []', noremap = true, silent = false })

-------------------------------------------------------------------------------
--                           Folding section
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
vim.keymap.set('n', '<CR>', function()
  -- Get the current line number
  local line = vim.fn.line '.'
  -- Get the fold level of the current line
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify('No fold found', vim.log.levels.INFO)
  else
    vim.cmd 'normal! za'
    vim.cmd 'normal! zz' -- center the cursor line on screen
  end
end, { desc = '[P]Toggle fold' })

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
