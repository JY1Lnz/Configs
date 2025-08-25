local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font ('ComicShannsMono Nerd Font Mono')
config.font_size = 18
config.color_scheme = 'Chalk'
config.underline_position = -4
config.underline_thickness = 3
config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'o',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- {
  --   key = 'j',
  --   mods = 'CTRL',
  --   action = wezterm.action.DisableDefaultAssignment,
  -- },
}

return config
