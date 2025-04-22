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
    local currentDevice = hs.execute('/opt/homebrew/bin/SwitchAudioSource -c'):gsub("%s+$", "")

    local allDevicesOutput = hs.execute('/opt/homebrew/bin/SwitchAudioSource -a')
    local allDevices = {}
    for device in allDevicesOutput:gmatch("[^\r\n]+") do
        table.insert(allDevices, device)
    end

    local preferredDevices = {
        "MacBook Pro Speakers",
        "AirPods Max",
        "AirPods Pro"
    }

    local function contains(str, substr)
        return string.find(string.lower(str), string.lower(substr)) ~= nil
    end

    local availablePreferred = {}
    local addedDevices = {}
    for _, device in ipairs(allDevices) do
        for _, preferred in ipairs(preferredDevices) do
            if contains(device, preferred) and not addedDevices[device] then
                table.insert(availablePreferred, device)
                addedDevices[device] = true
                break
            end
        end
    end

    print("Available preferred devices:")
    for i, device in ipairs(availablePreferred) do
        print(i .. ": " .. device)
    end

    if #availablePreferred == 0 then
        hs.alert.show("No preferred audio devices available")
        return
    end

    local currentIndex = 0
    for i, device in ipairs(availablePreferred) do
        if contains(currentDevice, device) or contains(device, currentDevice) then
            currentIndex = i
            break
        end
    end

    local nextIndex = (currentIndex % #availablePreferred) + 1
    local nextDevice = availablePreferred[nextIndex]

    local output, status = hs.execute('/opt/homebrew/bin/SwitchAudioSource -s "' .. nextDevice .. '"')
    hs.alert.show("Output device: " .. nextDevice)
    print("Changing output device to " .. nextDevice)
end)
hs.alert.show("Config loaded")
