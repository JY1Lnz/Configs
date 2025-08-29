local colorscheme = "onedark"
local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status then
  vim.notify("colorscheme " .. colorscheme .. "not found")
  return
end

local color = {
  none = 'NONE',
  -- bg0 = '#282c34',
  bg0 = '#1E1E1E',
  -- bg1 = '#21252b',
  bg1 = '#1E1E1E',
  bg_highlight = '#000000',
  bg_visual = '#393f4a',
  black0 = '#20232A',
  blue0 = '#61afef',
  blue1 = '#528bff',
  cyan0 = '#56b6c2',
  -- cyan0 = '#ff0000',
  fg0 = '#abb2bf',
  fg_dark = '#798294',
  fg_gutter = '#5c6370',
  fg_light = '#adbac7',
  green0 = '#98c379',
  orange0 = '#e59b4e',
  orange1 = '#d19a66',
  purple0 = '#c678dd',
  red0 = '#e06c75',
  red1 = '#e86671',
  red2 = '#f65866',
  yellow0 = '#ebd09c',
  yellow1 = '#e5c07b',
  dev_icons = {
    blue = '#519aba',
    green0 = '#8dc149',
    yellow = '#cbcb41',
    orange = '#e37933',
    red = '#cc3e44',
    purple = '#a074c4',
    pink = '#f55385',
    gray = '#4d5a5e',
  },
  m_yellow0 = '#FFD700',
  m_yellow1 = '#BDB76B',
  m_orange0 = '#FF8000',
  m_white0 = '#BFBFB4',
  m_purple0 = '#8F5DAF',
  m_purple1 = '#D8A0DF',
  m_blue0 = '#00E2C8',
  m_green0 = '#57A64A',
  m_red0 = '#D69D85',
}
vim.api.nvim_set_hl(0, '@type.builtin', {
  fg = color.m_purple1
})
