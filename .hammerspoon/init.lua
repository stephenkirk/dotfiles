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

function killWorkApps()
  local appsToKill = {"Firefox", "Slack", "Notion", "iTerm", "Rider", "Webstorm", "VS Code"}
  for _, appName in ipairs(appsToKill) do
    local app = hs.application.find(appName)
    if app then
      app:kill()
    end
  end
end

function openEssentials()
  -- Go to desktop 1
  hs.eventtap.keyStroke({"ctrl"}, "1")
  
  -- Open dev apps
  hs.application.launchOrFocus("iTerm")
  hs.application.launchOrFocus("Rider")
  hs.application.launchOrFocus("1Password 7")
  hs.application.launchOrFocus("Webstorm")
  hs.application.launchOrFocus("Code")
  
  hs.timer.doAfter(2, function()
    hs.eventtap.keyStroke({"ctrl"}, "2")
    hs.application.launchOrFocus("Spotify")
    hs.application.launchOrFocus("Firefox")
    hs.application.launchOrFocus("Slack")
    hs.application.launchOrFocus("Notion")
  end)
  
  
end

-- Bindings
hs.hotkey.bind(super, "R", function() hs.reload() end)
hs.hotkey.bind(super, "D", function() darkmodeClicked() end)
hs.hotkey.bind(super, "Z", function() openEssentials() end)
hs.hotkey.bind(super, "X", function() killWorkApps() end)
hs.hotkey.bind(super, "A", function() 
	hs.execute('SwitchAudioSource -u 90-9C-4A-E0-9D-33:output', true) 
	hs.notify.new({title="Hammerspoon", informativeText="Output device set to AirPods Max"}):send()
	print("Changing output device")
end)

hs.alert.show("Config loaded")
