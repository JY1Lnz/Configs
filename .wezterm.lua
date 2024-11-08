local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font ('ComicShannsMono Nerd Font Mono')
config.font_size = 18
config.color_scheme = 'Chalk'

return config
