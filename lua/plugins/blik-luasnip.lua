-- ============================================================
-- SECTION 7: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
vim.pack.add {
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  'https://github.com/Kaiser-Yang/blink-cmp-dictionary',
}
-- [[ Snippet Engine ]]
require('luasnip').setup {}

-- `friendly-snippets` contains a variety of premade snippets.
--    See the README about individual language/framework/plugin snippets:
--    https://github.com/rafamadriz/friendly-snippets
--
-- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()

-- [[ Autocomplete Engine ]]
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended) for mappings similar to built-in completions
    --   <c-y> to accept ([y]es) the completion.
    --    This will auto-import if your LSP supports it.
    --    This will expand snippets if the LSP sent a snippet.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'default',

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  -- sources = {
  --   default = { 'lsp', 'path', 'snippets' },
  -- },
  sources = {
    per_filetype = {
      org = { 'orgmode', 'path', 'snippets', 'buffer', 'dictionary' },
      markdown = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary' },
    },
    -- TODO: lazydev addition

    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      snippets = {
        score_offset = 100, -- the higher the number, the higher the priority
      },
      buffer = {
        name = 'Buffer',
        enabled = true,
        max_items = 3,
        module = 'blink.cmp.sources.buffer',
        min_keyword_length = 2,
        score_offset = 90, -- the higher the number, the higher the priority
      },
      -- lazydev = { module = 'lazydev.integrations.blink', score_offset = 90 },
      lsp = {
        name = 'lsp',
        enabled = true,
        module = 'blink.cmp.sources.lsp',
        -- kind = 'LSP',
        min_keyword_length = 0,
        score_offset = 80, -- the higher the number, the higher the priority
      },
      orgmode = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
        score_offset = 91,
      },
      path = {
        name = 'Path',
        module = 'blink.cmp.sources.path',
        score_offset = 40,
        -- When typing a path, I would get snippets and text in the
        -- suggestions, I want those to show only if there are no path
        -- suggestions
        fallbacks = { 'snippets', 'buffer' },
        min_keyword_length = 0,
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
          show_hidden_files_by_default = true,
        },
      },
      dictionary = {
        module = 'blink-cmp-dictionary',
        name = 'Dict',
        -- Make sure this is at least 2.
        -- 3 is recommended
        score_offset = 30, -- the higher the number, the higher the priority
        min_keyword_length = 3,
        max_items = 5,
        opts = {
          dictionary_files = function()
            if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'txt' or vim.bo.filetype == 'org' then
              local config_path = vim.fn.stdpath 'config'
              return {
                config_path .. '/spell/en.utf-8.add',
                config_path .. '/spell/0_palabras_todas.txt',
                config_path .. '/spell/words_alpha.txt',
              }
            end
            return { nil }
          end, -- options for blink-cmp-dictionary
        },
      },
    },
  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See `:help blink-cmp-config-fuzzy` for more information
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
