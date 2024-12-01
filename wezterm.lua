local wezterm = require("wezterm")
local westerm_action = wezterm.action
local wezterm_mux = wezterm.mux

local config = wezterm.config_builder()

-- UI
config.color_scheme = "Sonokai (Gogh)"
config.font = wezterm.font("RobotoMono Nerd Font")
config.font_size = 13

-- UI.TabBar
config.use_fancy_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.hide_tab_bar_if_only_one_tab = false

-- Keybind
config.keys = {
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
}
return config
