local function merge(config)
    local wezterm = require 'wezterm'
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

    config.window_background_opacity = opacity
end
return {
    merge = merge
}
