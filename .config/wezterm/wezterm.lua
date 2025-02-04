local wezterm = require 'wezterm'
local config = {}

config.max_fps = 240
config.font = wezterm.font('Fira Code', { weight = 'ExtraBold'})
config.font = wezterm.font_with_fallback {'JetBrains Mono'}
config.font_size = 13.0
config.color_scheme = 'Dracula+'
config.window_background_image = '/Users/paul.allen/Downloads/spaceman.png'
config.window_background_opacity = 1
config.text_background_opacity = 0.5
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.front_end ="OpenGL"
config.cell_width = 0.8
config.freetype_load_target = "Light"
config.window_padding = {
  left = 5,
  right = 0,
  top = 10,
  bottom = 0,
}

config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_target = "Normal"
config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'

config.window_background_image_hsb = {
  brightness = 0.02,
  hue = 1.0,
  saturation = 1.0
}

return config
