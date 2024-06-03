local wezterm = require("wezterm")
local config = {}
--use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- setttings
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Nerd Font", scale = 1.2, weight = "Medium" },
	{ family = "FantasqueSansM Nerd Font", scale = 1.3 },
})
config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 8
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

return config
