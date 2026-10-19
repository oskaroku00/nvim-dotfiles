vim.pack.add {
  'https://github.com/norcalli/nvim-colorizer.lua',
}

require('colorizer').setup {
  -- RGB = false, -- #RGB hex coees
  -- RRGGBB = true, -- #RRGGBB hex codes
  -- names = false, -- "Name" codes like Blue
  -- RRGGBBAA = false, -- #RRGGBBAA hex codes
  -- rgb_fn = false, -- CSS rgb() and rgba() functions
  -- hsl_fn = false, -- CSS hsl() and hsla() functions
  -- css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  -- css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  -- -- Available modes: foreground, background
  -- mode = 'background', -- Set the display mode.
  '*'; -- Highlight all files, but customize some others.
  '!vim'; -- Exclude vim from highlighting.
}
