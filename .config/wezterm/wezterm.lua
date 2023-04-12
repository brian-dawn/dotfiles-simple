
local wezterm = require 'wezterm';

return {
  color_scheme = "Gruvbox Light",
  hide_tab_bar_if_only_one_tab = true,

  -- Option as meta. TODO: Verify use_ime needs to be false.
  send_composed_key_when_left_alt_is_pressed = false,
  use_ime = false,

  font = wezterm.font("Fira Code"),
  font_size = 13,
  check_for_updates = false,
  -- debug_key_events=true,
  keys = {
    -- Turn off the default CMD-m Hide action on macOS by making it
    -- send the empty string instead of hiding the window

        {key="h", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Left"}},
        {key="l", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Right"}},
        {key="j", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Down"}},
        {key="k", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Up"}},

        {key="Enter", mods="CTRL|SHIFT", action=wezterm.action{SplitVertical={ }}},
        {key="%", mods="CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="\"", mods="CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="\"", mods="CTRL", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}}
  },


  use_ime = true
}

