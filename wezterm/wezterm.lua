-- wezterm config file
local wezterm = require 'wezterm';
-- depends on OS
-- windows
local os = wezterm.target_triple
local config = {}

if os:find("windows") then
  config.default_prog = {"wsl.exe", "--distribution", "Ubuntu-20.04", "--exec", "/usr/bin/zsh", "-l"}
end
-- macos
if os:find("darwin") then
  -- hoge
end
-- linux
if os:find("linux") then
  -- hoge
end

return config
