-- custom hightlight 

local scheme = {
  ["type"] = {
    guifg = "#ff0000",
  },
  ["function"] = {
    guifg = "#FF8000"
  },
}

local base_str = ":hi @lsp.type."

local function get_str(scope, config)
  local tmp = base_str .. scope
  for k, v in pairs(config) do
    tmp = tmp .. " " .. k .. "=" .. v
  end
  return tmp
end


for k, v in pairs(scheme) do
  vim.api.nvim_command(get_str(k, v))
end

vim.api.nvim_exec([[ hi @type guifg=#FFD700 ]], true)
vim.api.nvim_exec([[ hi rainbowcol1 guifg=#BDB76B]], true)
vim.api.nvim_exec([[ hi rainbowcol2 guifg=#569CD6]], true)

