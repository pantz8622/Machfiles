local wezterm = require 'wezterm'
local colors = wezterm.color.load_scheme("/home/wadeyao/.config/wezterm/assets/colors/tokyonight_storm.toml")

return {
    font = wezterm.font 'Xiaolai Mono SC',
    font_size = 12,
    line_height = 1.3,
    enable_tab_bar = false,
    colors = colors,
}
