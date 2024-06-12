local super = {"ctrl", "alt", "cmd", "shift"}

-- Toggle dark mode from menu bar
local function systemSetDm(state)
  return hs.osascript.javascript(
    string.format(
      "Application('System Events').appearancePreferences.darkMode.set(%s)",
      state
    )
  )
end

local function dmIsOn()
  local _, darkModeState = hs.osascript.javascript(
    'Application("System Events").appearancePreferences.darkMode()'
  )
  return darkModeState
end

function setDm(state)
	systemSetDm(state)
    if state then
        darkmode:setTitle("☾")
    else
        darkmode:setTitle("☀")
    end
end

function darkmodeClicked()
    setDm(not dmIsOn())
end

darkmode = hs.menubar.new()
if darkmode then
    darkmode:setClickCallback(darkmodeClicked)
    setDm(dmIsOn())
end

-- END dark mode

function killWorkApps()
  local appsToKill = {"Firefox", "Slack", "Notion", "iTerm", "Rider", "Webstorm", "VS Code"}
  for _, appName in ipairs(appsToKill) do
    local app = hs.application.find(appName)
    if app then
      app:kill()
    end
  end
end

-- Bindings
hs.hotkey.bind(super, "R", function() hs.reload() end)
hs.hotkey.bind(super, "D", function() darkmodeClicked() end)
hs.hotkey.bind(super, "X", function() killWorkApps() end)
hs.hotkey.bind(super, "A", function() 
	hs.execute('SwitchAudioSource -u 90-9C-4A-E0-9D-33:output', true) 
	hs.notify.new({title="Hammerspoon", informativeText="Output device set to AirPods Max"}):send()
	print("Changing output device")
end)

hs.alert.show("Config loaded")
