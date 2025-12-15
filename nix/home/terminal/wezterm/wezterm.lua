local config = {}

-- wezterm config file
local wezterm = require 'wezterm'
if wezterm.config and wezterm.config_builder then
    config = wezterm.config_builder()
end

local function helper(module, config)
    local conf_func = require(module)
    if not conf_func then
        return
    end
    return conf_func.merge(config)
end

helper('os_config', config)
helper('keybindings', config)
helper('startup', config)
helper('title', config)
helper('ime', config)
helper('colors', config)

helper('local_config', config)

return config
