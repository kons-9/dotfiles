-- wezterm config file
local wezterm = require 'wezterm';
-- depends on OS
-- windows
local os = wezterm.target_triple
local config = {}

if wezterm.config and wezterm.config.builder then
  config = wezterm.config.builder()
end

if os:find("windows") then
  config.default_prog = {"wsl.exe", "--distribution", "Ubuntu-20.04", "--exec", "/usr/bin/zsh", "-l"}
end
-- macos
if os:find("darwin") then
  config.color_scheme = "Dracula"
end
-- linux
if os:find("linux") then
  -- hoge
end

config.color_scheme = 'Hybrid (Gogh)'
config.font = wezterm.font("Hack Nerd Font Mono")
config.window_background_opacity = 0.85
config.font_size = 14.0

return config
