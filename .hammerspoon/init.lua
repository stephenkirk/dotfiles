local super = { "ctrl", "alt", "cmd", "shift" }

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

-- Night Shift toggle
-- Had to set up Shortcuts manually because of course Apple won't just expose this API.
-- Relies on two shortcuts: "Turn Night Shift On" and "Turn Night Shift Off"
local nightShiftState = false

function toggleNightShift()
    if nightShiftState then
        hs.execute('shortcuts run "Turn Night Shift Off"')
        nightShiftState = false
        hs.alert.show("Night Shift: OFF")
    else
        hs.execute('shortcuts run "Turn Night Shift On"')
        nightShiftState = true
        hs.alert.show("Night Shift: ON")
    end
end
-- END Night Shift toggle

function killWorkApps()
    local appsToKill = { "Firefox", "Slack", "Notion", "iTerm", "Rider", "Webstorm", "VS Code" }
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
hs.hotkey.bind(super, "N", function() toggleNightShift() end)
hs.hotkey.bind(super, "A", function()
    local currentDevice = hs.execute('/opt/homebrew/bin/SwitchAudioSource -c')
    if currentDevice:find("MacBook Pro") then
        local output, status = hs.execute('/opt/homebrew/bin/SwitchAudioSource -s "Stephen’s AirPods Max #2"')
        hs.notify.new({ title = "Hammerspoon", informativeText = "Output device set to AirPods Max" }):send()
        print("Changing output device to AirPods Max")
    else
        local output, status = hs.execute('/opt/homebrew/bin/SwitchAudioSource -s "MacBook Pro Speakers"')
        hs.notify.new({ title = "Hammerspoon", informativeText = "Output device set to MacBook Pro Speakers" }):send()
        print("Changing output device to MacBook Pro Speakers")
    end
end)

hs.alert.show("Config loaded")
