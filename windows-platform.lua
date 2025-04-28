-- Windows implementation, should live in ~.config/wezterm/...

local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
	-- apply config changes here, could also include adding in local private functions defined above. see: https://wezterm.org/config/files.html#making-your-own-lua-modules
	-- for example config.color_scheme = 'Batman'
	config.default_prog = { "powershell.exe" }

	config.keys = {
		{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
		{ key = "!", mods = "CTRL", action = act.ActivateTab(0) },
		{ key = "s", mods = "LEADER|ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "LEADER|SHIFT|ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		-- Tab Navigation
		{ key = "Tab", mods = "LEADER|ALT", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "LEADER|SHIFT|ALT", action = act.ActivateTabRelative(-1) },
		{ key = "1", mods = "LEADER|ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER|ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER|ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "LEADER|ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "LEADER|ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "LEADER|ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "LEADER|ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "LEADER|ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "LEADER|ALT", action = act.ActivateTab(-1) },
		--
		{ key = "c", mods = "CTRL", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

		{ key = "f", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
		-- { key = "H", mods = "CTRL", action = act.HideApplication },
		{ key = "h", mods = "CTRL", action = act.HideApplication },
		{
			key = "l",
			mods = "CTRL",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
		{
			key = "l",
			mods = "SUPER",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
		{
			key = "c",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)

					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
				end
			end),
		},
		{
			key = "c",
			mods = "SUPER",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)

					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
				end
			end),
		},
		-- { key = "K", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
		{ key = "m", mods = "CTRL", action = act.Hide },
		{ key = "n", mods = "CTRL", action = act.SpawnWindow },
		{ key = "p", mods = "CTRL", action = act.ActivateCommandPalette },
		{ key = "q", mods = "CTRL", action = act.QuitApplication },
		{ key = "r", mods = "LEADER|ALT", action = act.ReloadConfiguration },
		-- { key = "R", mods = "LEADER|SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		-- { key = "T", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "U",
			mods = "CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{
			key = "U",
			mods = "SHIFT|CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		-- { key = "W", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "w", mods = "LEADER|ALT", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "x", mods = "CTRL", action = act.ActivateCopyMode },
		{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "c", mods = "CTRL", action = act.CopyTo("Clipboard") },

		{ key = "z", mods = "LEADER|ALT", action = act.TogglePaneZoomState },
		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
		-- { key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		-- { key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
		-- { key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
		-- { key = "^", mods = "CTRL", action = act.ActivateTab(5) },
		-- { key = "^", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
		-- { key = "_", mods = "CTRL", action = act.DecreaseFontSize },
		-- { key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
		-- { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		-- { key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		-- { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
		-- { key = "h", mods = "SHIFT|CTRL", action = act.HideApplication },
		-- { key = "h", mods = "SUPER", action = act.HideApplication },
		-- { key = "k", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
		-- { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
		-- { key = "m", mods = "SHIFT|CTRL", action = act.Hide },
		-- { key = "m", mods = "SUPER", action = act.Hide },
		-- { key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
		-- { key = "n", mods = "SUPER", action = act.SpawnWindow },
		-- { key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		-- { key = "q", mods = "SHIFT|CTRL", action = act.QuitApplication },
		-- { key = "q", mods = "SUPER", action = act.QuitApplication },
		-- { key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		-- { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		-- { key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "u",
			mods = "SHIFT|CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		-- { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		-- { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
		-- { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
		-- { key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
		-- { key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		-- { key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		-- { key = "{", mods = "SUPER", action = act.ActivateTabRelative(-1) },
		-- { key = "{", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
		-- { key = "}", mods = "SUPER", action = act.ActivateTabRelative(1) },
		-- { key = "}", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
		-- { key = "h", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
		-- { key = "l", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
		-- { key = "k", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
		-- { key = "j", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	}
end

return module
