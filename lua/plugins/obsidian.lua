vim.pack.add {
  {
    src = 'https://github.com/obsidian-nvim/obsidian.nvim',
    version = vim.version.range '*', -- use latest release, remove to use latest commit
  },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/nvim-telescope/telescope.nvim',
}
require('obsidian').setup {
  legacy_commands = false,
  workspaces = {
    {
      name = 'personal-vault',
      path = '~/vault/md',
    },
  },
  completion = {
    min_chars = 0,
  },
  frontmatter = {
    enabled = true,
  },
  daily_notes = {
    folder = '/daily',
    date_format = '%d-%m-%Y',
    alias_format = '%B %-d, %Y',
    template = 'daily',
    workdays_only = false,
  },
  footer = {
    enabled = true,
  },
  new_notes_location = 'current_dir',
  ui = { enable = false },
  note_id_func = function(title)
    if title ~= nil then
      -- If you want to use the exact title you typed as the filename:
      return title
      
      -- ALTERNATIVE: If you prefer to sanitize the title to ensure it makes a safe filename 
      -- (e.g., lowercase and replace spaces with hyphens), you would use this instead:
      -- return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- Fallback: If you create a note without a title, it will use a timestamp
      return tostring(os.time()) .. "-" .. tostring(math.random(1000, 9999))
    end
  end,
  attachments = {
    folder = '/assets',
    img_name_func = function()
      -- Get the current working directory (assumes Neovim is opened at your vault root)
      -- If your setup is different, you might need to hardcode your absolute vault path here.
      local vault_path = vim.fn.getcwd()
      local assets_path = vault_path .. '/assets'

      local max_num = 0

      -- Check if the directory exists to prevent errors on the first paste
      if vim.fn.isdirectory(assets_path) == 1 then
        -- Read all files in the assets directory
        local files = vim.fn.readdir(assets_path)

        for _, file in ipairs(files) do
          -- Extract the number from files matching "image_123.png"
          local num_str = file:match '^image_(%d+)%.'
          if num_str then
            local num = tonumber(num_str)
            if num > max_num then max_num = num end
          end
        end
      end

      -- Return the incremented name. obsidian.nvim will automatically append the extension (e.g., .png)
      return string.format('image_%d', max_num + 1)
    end,
    -- img_text_func = function(path)
    --   local name = vim.fs.basename(tostring(path))
    --   return string.format("![[%s]]", name)
    --   -- returd of given image = ![[Pasted image 20260729175236.png]]
    -- end,
  },
  templates = {
    folder = 'templates',
    date_format = '%d-%m-%Y',
  },
  checkbox = {
    enabled = true,
    create_new = false,
    order = { ' ', 'x' },
  },
}

-- local bridge_settings = {
--   obsidian_server_address = "http://localhost:27123",
--   scroll_sync = false, -- See "Sync of buffer scrolling" section below
--   cert_path = nil, -- See "SSL configuration" section below
--   warnings = true, -- Show misconfiguration warnings
--   picker = "telescope", -- Picker to use with ObsidianBridgePickCommand ("telescope" | "fzf_lua")
-- }
-- vim.pack.add {
--   'https://github.com/oflisback/obsidian-bridge.nvim',
-- }
-- require("obsidian-bridge").setup()
