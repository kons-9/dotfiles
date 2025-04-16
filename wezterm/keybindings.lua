local wezterm = require 'wezterm'
local act = wezterm.action

local function merge(config)
    config.keys = {
        { key = "v", mods = "CMD",        action = act.PasteFrom 'Clipboard' },
        { key = "c", mods = "CMD",        action = act.CopyTo 'Clipboard' },
        { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab "DefaultDomain" },
        { key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab { confirm = false } },
        { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom 'Clipboard' },
        { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo 'Clipboard' },
        { key = "l", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
        { key = "h", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
        { key = "Backspace", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
        -- { key = "p", mods = "CTRL",       action = act.SendKey { key = "UpArrow" } },
        -- { key = "n", mods = "CTRL",       action = act.SendKey { key = "DownArrow" } },
        -- { key = "[", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
        -- { key = "]", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

    }
    config.disable_default_key_bindings = true
    config.use_dead_keys = false
end

return {
    merge = merge
}
