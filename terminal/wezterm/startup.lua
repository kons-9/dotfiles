local function merge(config)
    local wezterm = require 'wezterm'
    -- 最初からフルスクリーンで起動
    local mux = wezterm.mux
    wezterm.on("gui-startup", function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        -- window:gui_window():toggle_fullscreen()
        window:gui_window():maximize()
    end)
end

return {
    merge = merge
}
