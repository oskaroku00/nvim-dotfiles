-- 1. Add Harpoon and its dependency via vim.pack
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ThePrimeagen/harpoon',
}

-- 2. Configure Harpoon
local harpoon = require 'harpoon'
harpoon.setup {
  -- log level can be set with vim.g.harpoon_log_level
  -- Add your custom configuration here
}

-- 3. Basic Keymaps
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

vim.keymap.set('n', '<leader>a', mark.add_file, {desc = "add harpoon file"})
vim.keymap.set('n', '<leader>H', ui.toggle_quick_menu, {desc = "open harpoon menopen harpoon menuu"})

-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function() ui.nav_file(i) end, { desc = 'Harpoon to ' .. i })
end
