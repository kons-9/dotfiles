local function merge(config)
    local wezterm = require 'wezterm'
    -- config.color_scheme = 'Hybrid (Gogh)'
    config.color_scheme = 'zenwritten_dark'
    config.font = wezterm.font("JetBrains Mono")
    config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    -- config.color_scheme = 'Kanagawa (Gogh)'
    -- config.colors = {
        -- Make the selection text color fully transparent.
        -- When fully transparent, the current text color will be used.
        -- selection_fg = 'none',
        -- Set the selection background color with alpha.
        -- When selection_bg is transparent, it will be alpha blended over
        -- the current cell background color, rather than replace it
        -- selection_bg = 'rgba(50% 50% 50% 50%)',

        -- compose_cursor = string.format('rgba(%d%% %d%% %d%% %f)', 0x1b, 0x1b, 0x20, opacity),
        -- compose_cursor = 'none',
    -- }
    -- config.ime_preedit_rendering = 'System'
end
return {
    merge = merge
}
