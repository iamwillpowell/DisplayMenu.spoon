--- DisplayMenu
---
--- Just a simple menubar items to move my second display (laptop display) to the bottom or right.
--- I got tired of opening System Settings Displays and moving them and adjusting resolution.

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "DisplayMenu"
obj.version = "0.1.0"
obj.author = "Will Powell <iamwillpowell@gmail.com>"

--- DisplayMenu:start()
--- Method
--- Start ReloadConfiguration
---
--- Parameters:
---  * None
function obj:start()
  self.menubarItem = hs.menubar.new(true, "DisplayMenu")
  -- self.menubarItem:setTitle("DM");
  local icon = hs.image.imageFromPath(
    "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SidebarDisplay.icns"
  )
  self.menubarItem:setIcon(icon:setSize({w = 16, h = 16}))
  self.menubarItem:setMenu(obj.menuItems)
  return self
end

function obj.setRight(mods, item)
  local screen = hs.screen.primaryScreen():next()
  -- print(hs.inspect.inspect(hs.screen:screenPositions()))
  -- setMode: w, h, scale, freq, depth
  screen:setMode(1536, 960, 2.0, 59.0, 8.0)
  screen:setOrigin(2000,200)
  hs.notify.new({title="Hammerspoon", informativeText=tostring('Moved second display to right')}):send()
end

function obj.setLeft(mods, item)
  local screen = hs.screen.primaryScreen():next()
  -- setMode: w, h, scale, freq, depth
  -- 1792, 1120, 2.0, 59.0, 8.0
  -- print(hs.inspect.inspect(screen:availableModes()["1792x1120@2x 59Hz 8bpp"]))
  screen:setOrigin(400,2000)
  screen:setMode(1792, 1120, 2.0, 59.0, 8.0)
  hs.notify.new({title="Hammerspoon", informativeText=tostring('Moved second display to bottom')}):send()
end

--- DisplayMenu:menuItems
--- variable
--- Table of items for the menubarItem menu
obj.menuItems = {
  { title = "right", fn = obj.setRight, checked = false},
  { title = "bottom", fn = obj.setLeft, checked = false},
}

return obj
