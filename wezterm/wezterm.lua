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
    config.enable_wayland = false
    -- config.default_prog = { "nvim" }
    config.default_prog = { "zsh", "-l"}
end

-- 最初からフルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

local opacity = 0.87

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
    local index = ''
    if #tabs > 1 then
        index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
    end
    local title = "nvim_wezterm: " .. pane.title .. index
    return title
end)

wezterm.on("format-tab-title",
    function(tab, tabs, panes, config)
        local index = ''
        if #tabs > 1 then
            index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
        end
        local title = tab.active_pane.title .. " " .. index
        -- local color = 'navy'
        local color = string.format('rgba(%d%% %d%% %d%% %f)', 0x1b, 0x1b, 0x20, opacity)

        if tab.is_active then
            color = string.format('rgba(%d%% %d%% %d%% %f)', 0x10, 0x10, 0x12, opacity)
        end

        return {
            { Background = { Color = color } },
            { Attribute = { Underline = 'Single' } },
            { Text = title },
        }
    end
)

-- config.color_scheme = 'Hybrid (Gogh)'
-- config.font = wezterm.font("Hack Nerd Font Mono")
config.color_scheme = 'Kanagawa (Gogh)'
config.window_background_opacity = opacity
config.font_size = 10

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
    { key = "p", mods = "CTRL",       action = act.SendKey { key = "UpArrow" } },
    { key = "n", mods = "CTRL",       action = act.SendKey { key = "DownArrow" } },
    -- { key = "[", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
    -- { key = "]", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

}

return config
