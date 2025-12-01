-- Requires: nvim-treesitter and telescope.nvim
local ts_utils = require 'nvim-treesitter.ts_utils'
local builtin = require 'telescope.builtin'

-- Function to get text inside [] on current line
local function get_bracket_text()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return ''
  end

  local line = vim.api.nvim_get_current_line()
  -- local match = line:match '%[[(.-)%]]' -- capture text inside []
  local match = line:match '%[%[(.-)%]%]' -- capture text inside [[ ]]
  vim.fn.setreg('"', match)
  return match or ''
end

-- Keybind to search files excluding markdown and images
vim.keymap.set('n', '<leader>sz', function()
  local query = get_bracket_text()
  builtin.find_files {
    prompt_title = 'Search Files',
    default_text = query,
    cwd = vim.fn.getcwd(),
    find_command = {
      'rg',
      '--files',
      '--glob',
      '!.md',
      '--glob',
      '!*png',
      '--glob',
      '!*jpg',
      '--glob',
      '!*jpeg',
      '--glob',
      '!*gif',
    },
    -- Split Verticslly
    vim.cmd 'sv',
    -- attach_mapping = function(_, map)
    --   local filepath = vim.fn.expand '%:p' -- current file full path
    --   vim.cmd('edit ' .. filepath)
    --   vim.cmd("silent! call netrw#BrowseX('" .. filepath .. "', 0)")
    --   vim.cmd 'bd' -- 'bd' stands for :bdelete, which closes the current buffer
    -- end,
  }
end, { desc = 'Search files excluding markdown/images with query from []' })

local function open_current_file()
  local filepath = vim.fn.expand '%:p' -- current file full path
  vim.cmd('edit ' .. filepath)
  vim.cmd("silent! call netrw#BrowseX('" .. filepath .. "', 0)")
  vim.cmd 'bd' -- 'bd' stands for :bdelete, which closes the current buffer
end

vim.keymap.set('n', '<leader>O', open_current_file, { desc = 'Open current file like <leader>e gx' })
