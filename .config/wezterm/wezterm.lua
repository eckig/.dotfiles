local wezterm = require 'wezterm'
local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
})
end

return {
  keys = {
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  },
  font = wezterm.font 'Berkeley Mono',
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
  initial_rows = 45,
  use_dead_keys = false,
  launch_menu = launch_menu,
}
