local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Fira Code+'
config.font = wezterm.font_with_fallback {'JetBrains Mono'}
config.color_scheme = 'Dracula+'
config.font_size = 12.0
config.window_background_opacity = 1
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 5,
  bottom = 0,
}

config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.tab_bar_at_bottom = true
-- config.freetype_load_target = "HorizontalLcd"
config.automatically_reload_config = true
return config
