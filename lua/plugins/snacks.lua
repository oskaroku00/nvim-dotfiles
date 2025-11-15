return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        enable = true,
        resolve = function(path, src)
          if require("obsidian.api").path_is_note(path) then
            return require("obsidian.api").resolve_image_path(src)
          end
        end,
        -- hover = true,
        doc = {
          -- hover = true,
          inline = vim.g.neovim_mode == "skitty" and true or false,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          -- Sets the size of the image
          max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
          max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
        },
      },
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
    },
  },
}
