-- local colorscheme = "onedark"
local colorscheme = "tokyonight"
local status, _ = pcall(vim.cmd, "colorscheme "..colorscheme)

if not status then
  vim.notify("colorscheme ".. colorscheme .. "not found")
  return
end
