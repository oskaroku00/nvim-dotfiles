-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fn.stdpath 'config' .. '/lua/plugins'
for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
  if file:match '%.lua$' and file ~= 'init.lua' then
    local module = file:gsub('%.lua$', '')
    require('plugins.' .. module)
  end
end
