-- wezterm config file
local wezterm = require 'wezterm'
local act = wezterm.action
-- depends on OS
-- windows
local os = wezterm.target_triple
local config = {}

if wezterm.config and wezterm.config_builder then
  config = wezterm.config_builder()
end

if os:find("windows") then
  config.default_prog = { "wsl.exe", "--distribution", "Ubuntu", "--exec", "/usr/bin/zsh", "-l" }
end
-- macos
if os:find("darwin") then
  config.native_macos_fullscreen_mode = false
end
-- linux
if os:find("linux") then
  -- hoge
end

-- 最初からフルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

config.color_scheme = 'Hybrid (Gogh)'
config.font = wezterm.font("Hack Nerd Font Mono")
config.window_background_opacity = 0.85
config.font_size = 11.0

config.disable_default_key_bindings = true
config.use_dead_keys = false

config.keys = {
  { key = "v", mods = "CMD",        action = act.PasteFrom 'Clipboard' },
  { key = "c", mods = "CMD",        action = act.CopyTo 'Clipboard' },
  { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab "DefaultDomain" },
  { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab { confirm = false } },
  { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom 'Clipboard' },
  { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo 'Clipboard' },
  { key = "l", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
  { key = "h", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
  -- { key = "[", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
  -- { key = "]", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

}

return config
