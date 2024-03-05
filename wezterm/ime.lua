local function merge(config)
    -- ime
    config.use_ime = true
    config.xim_im_name = "ibus"
end

return {
    merge = merge
}
