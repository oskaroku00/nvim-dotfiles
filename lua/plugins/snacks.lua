vim.pack.add {
  'https://github.com/folke/snacks.nvim',
}
require('snacks').setup {
  image = {
    enable = true,
    -- resolve = function(path, src)
    --   if vim.bo.filetype == 'org' then
    --     local impath = path + '/assets/nil'
    --     return impath
    --   end
    --   if require('obsidian.api').path_is_note(path) then
    --     return require('obsidian.api').resolve_image_path(src)
    --   end
    -- end,
    resolve = function(path, src)
      -- 1. Org-mode Specific Logic
      if vim.bo.filetype == 'org' then
        -- Use .. for string concatenation in Lua
        -- This assumes images are in an 'assets' folder relative to the org file
        return vim.fn.expand '%:p:h' .. '/assets/' .. src
      end

      return require('obsidian.api').resolve_image_path(src)
    end,
    formats = {
      'png',
      'jpg',
      'jpeg',
      'gif',
      'bmp',
      'webp',
      'tiff',
      'heic',
      'avif',
      'webm',
      'icns',
    },
    doc = {
      enable = true,
      -- hover = true,
      inline = vim.g.neovim_mode == 'skitty' and true or false,
      -- render the image in a floating window
      -- only used if `opts.inline` is disabled
      float = true,
      -- Sets the size of the image
      max_width = vim.g.neovim_mode == 'skitty' and 20 or 60,
      max_height = vim.g.neovim_mode == 'skitty' and 10 or 30,
    },
  },
  styles = {
    snacks_image = {
      relative = 'editor',
      col = -1,
    },
  },
}
