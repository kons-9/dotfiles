local function merge(config)
    local wezterm = require 'wezterm'
    local os = wezterm.target_triple
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
        config.default_prog = { "zsh", "-l" }
    end
end

return {
    merge = merge
}
