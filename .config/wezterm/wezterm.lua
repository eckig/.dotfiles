local wezterm = require 'wezterm'
return {
  font = wezterm.font 'JetBrains Mono',
  font_size = 10,
  color_scheme = "Gruvbox dark, medium (base16)",
  default_prog = { 'C:/cygwin64/bin/zsh', '--login' },
  window_padding = {
    left = '0',
    right = '1cell',
    top = '0.5cell',
    bottom = '0.5cell',
  },
  tab_max_width = 70,
  use_fancy_tab_bar = false,
  initial_cols = 200,
  initial_rows = 40,
}
