return {
  {
    'yousefhadder/markdown-plus.nvim',
    ft = 'markdown',
    opts = {
      -- Feature toggles (all default: true)
      features = {
        list_management = true, -- default: true (list auto-continue / indent / renumber / checkboxes)
        text_formatting = true, -- default: true (bold/italic/strike/code + clear)
        headers_toc = true, -- default: true (headers nav + TOC generation & window)
        links = true, -- default: true (insert/edit/convert/reference links)
        images = true, -- default: true (insert/edit image links + toggle link/image)
        quotes = true, -- default: true (blockquote toggle)
        callouts = true, -- default: true (GFM callouts/admonitions)
        code_block = true, -- default: true (visual selection -> fenced block)
        table = true, -- default: true (table creation & editing)
      },

      -- TOC window configuration
      toc = {
        initial_depth = 2, -- default: 2 (range 1-6) depth shown in :Toc window and generated TOC
      },

      -- Callouts configuration
      callouts = {
        default_type = 'NOTE', -- default: "NOTE"  default callout type when inserting
        custom_types = {}, -- default: {}  add custom types (e.g., { "DANGER", "SUCCESS" })
      },

      -- Table configuration
      table = {
        auto_format = true, -- default: true  auto format table after operations
        default_alignment = 'left', -- default: "left"  alignment used for new columns
        confirm_destructive = true, -- default: true  confirm before transpose/sort operations
        keymaps = { -- Table-specific keymaps (prefix based)
          enabled = true, -- default: true  provide table keymaps
          prefix = '<leader>t', -- default: "<leader>t"  prefix for table ops
          insert_mode_navigation = true, -- default: true  Alt+hjkl cell navigation
        },
      },
      keymaps = {
        enabled = true, -- default: true  set false to disable ALL default maps (use <Plug>)
      },
    },
  },
}
