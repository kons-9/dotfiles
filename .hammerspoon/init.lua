hs.hotkey.bind( {"cmd"}, "e", function()
  wez = hs.application.find("WezTerm")
  if wez then
    if wez:isFrontmost() then
      wez:hide()
    else
      -- hs.application.launchOrFocus("WezTerm")
      wez:activate()
    end
  end
end)
