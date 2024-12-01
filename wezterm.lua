local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font = wezterm.font("RobotoMono Nerd Font")
config.color_scheme = "Sonokai (Gogh)"
return config
