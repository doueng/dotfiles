local wezterm = require 'wezterm';
return {
  default_prog = {"/opt/homebrew/bin/fish"},
  window_decorations = "RESIZE",
  adjust_window_size_when_changing_font_size = false,
  default_cursor_style = "SteadyUnderline",
  color_scheme = "deep",
  window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
  },
  font_size = 16.0,
  font = wezterm.font("Fira Code"),
  window_background_opacity = 0.9,
  window_close_confirmation = "NeverPrompt",
  exit_behavior = "Close",
  tab_bar_at_bottom = true,
  window_padding = {
	left = 10, right = 10,
	top = 10, bottom = 10,
  },
  keys = {
	-- search for things that look like git hashes
	{key="H", mods="SHIFT|CTRL", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
	{key="UpArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=-1}},
	{key="DownArrow", mods="SHIFT", action=wezterm.action{ScrollToPrompt=1}},
	{key="S", mods="CMD|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
	{key="l", mods="CMD", action=wezterm.action{SendString="ls\n"}},
	{key="g", mods="CMD", action=wezterm.action{SendString="gs\n"}},
  },
}
