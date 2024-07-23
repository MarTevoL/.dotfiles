local wezterm = require("wezterm")
local config = {}
--use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- setttings
config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte, Mocha
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", scale = 1.2, weight = "Regular" },
	{ family = "Fira Code", scale = 1.3, weight = "Light" },
	{ family = "Iosevka Nerd Font Mono", scale = 1.3, weight = "Medium" },
	{ family = "Hack Nerd Font Mono", scale = 1.3 },
	{ family = "FantasqueSansM Nerd Font", scale = 1.3 },
})
config.font_size = 15

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.60
config.macos_window_background_blur = 50
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

return config
