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


function printDebug()
  -- print(hs.inspect.inspect(hs.screen:screenPositions()))
end

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
  self.menubarItem:setMenu(obj.getMenuItems())
  return self
end

function obj.setRight(mods, item)
  local screen = hs.screen.primaryScreen():next()
  printDebug();
  -- setMode: w, h, scale, freq, depth
  screen:setMode(1536, 960, 2.0, 59.0, 8.0)
  screen:setOrigin(2000,200)
  hs.notify.new({title="Hammerspoon", informativeText=tostring('Moved second display to right')}):send()
  -- reload menu
  obj.menubarItem:setMenu(obj.getMenuItems())
end

function obj.setBottom(mods, item)
  local screen = hs.screen.primaryScreen():next()
  printDebug();
  -- setMode: w, h, scale, freq, depth
  screen:setMode(1536, 960, 2.0, 59.0, 8.0)
  screen:setOrigin(-2000,200)
  hs.notify.new({title="Hammerspoon", informativeText=tostring('Moved second display to left')}):send()
  -- reload menu
  obj.menubarItem:setMenu(obj.getMenuItems())
end

function obj.setBottom(mods, item)
  local screen = hs.screen.primaryScreen():next()
  -- setMode: w, h, scale, freq, depth
  -- 1792, 1120, 2.0, 59.0, 8.0
  printDebug();
  screen:setOrigin(400,2000)
  screen:setMode(1792, 1120, 2.0, 59.0, 8.0)
  hs.notify.new({title="Hammerspoon", informativeText=tostring('Moved second display to bottom')}):send()
  -- reload menu
  obj.menubarItem:setMenu(obj.getMenuItems())
end

function obj.getPosition(which)
  -- x = 1 = right
  -- y = 1 = bottom
  x, y = hs.screen"Built":position()
  -- print(x, y)

  if which == 'right' then
    return x == 1
  elseif which == 'left' then
    return x == -1
  elseif which == 'bottom' then
    return y == 1
  else
    return false
  end

end

function obj.getMenuItems()
  return {
    { title = "Place screen on the right ", fn = obj.setRight, checked = obj.getPosition('right')},
    { title = "Place screen on the left ", fn = obj.setLeft, checked = obj.getPosition('left')},
    { title = "Place screen on the bottom", fn = obj.setBottom, checked = obj.getPosition('bottom')},
  }
end

return obj
