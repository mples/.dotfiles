-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config = {
	default_cursor_style = "SteadyBar",
	color_scheme = "Dracula (base16)",
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",
	-- window_decorations = "RESIZE",
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 12.5,
	check_for_updates = false,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	enable_tab_bar = false,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
}
config.default_domain = "WSL:Ubuntu-24.04"
-- and finally, return the configuration to wezterm
return config
