-- User configuration
local config = {
    super = { "ctrl", "alt", "cmd", "shift" },
    preferredAudioDevices = {
        "MacBook Pro Speakers",
        "AirPods Max",
        "AirPods Pro"
    }
}

-- Dark Mode management
local darkmode = {}
function darkmode.init()
    darkmode.menubar = hs.menubar.new()
    if darkmode.menubar then
        darkmode.menubar:setClickCallback(darkmode.toggle)
        darkmode.set(darkmode.isEnabled())
    end
end

function darkmode.systemSet(state)
    return hs.osascript.javascript(
        string.format(
            "Application('System Events').appearancePreferences.darkMode.set(%s)",
            state
        )
    )
end

function darkmode.isEnabled()
    local _, darkModeState = hs.osascript.javascript(
        'Application("System Events").appearancePreferences.darkMode()'
    )
    return darkModeState
end

function darkmode.set(state)
    darkmode.systemSet(state)
    if darkmode.menubar then
        darkmode.menubar:setTitle(state and "☾" or "☀")
    end
end

function darkmode.toggle()
    darkmode.set(not darkmode.isEnabled())
end

-- Night Shift management
local nightshift = {
    isEnabled = false
}

function nightshift.toggle()
    if nightshift.isEnabled then
        hs.execute('shortcuts run "Turn Night Shift Off"')
        nightshift.isEnabled = false
        hs.alert.show("Night Shift: OFF")
    else
        hs.execute('shortcuts run "Turn Night Shift On"')
        nightshift.isEnabled = true
        hs.alert.show("Night Shift: ON")
    end
end

-- Audio device management
local audio = {}
function audio.cycleOutputDevices()
    local currentDevice = hs.execute('/opt/homebrew/bin/SwitchAudioSource -c'):gsub("%s+$", "")
    local allDevicesOutput = hs.execute('/opt/homebrew/bin/SwitchAudioSource -a')
    
    local allDevices = {}
    for device in allDevicesOutput:gmatch("[^\r\n]+") do
        table.insert(allDevices, device)
    end

    local function contains(str, substr)
        return string.find(string.lower(str), string.lower(substr)) ~= nil
    end

    local availablePreferred = {}
    local addedDevices = {}
    for _, device in ipairs(allDevices) do
        for _, preferred in ipairs(config.preferredAudioDevices) do
            if contains(device, preferred) and not addedDevices[device] then
                table.insert(availablePreferred, device)
                addedDevices[device] = true
                break
            end
        end
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

    hs.execute('/opt/homebrew/bin/SwitchAudioSource -s "' .. nextDevice .. '"')
    hs.alert.show("Output device: " .. nextDevice)
end

-- Hotkey help system
local hotkeys = {
    definitions = {
        { key = "R", description = "Reload Hammerspoon config" },
        { key = "D", description = "Toggle dark mode" },
        { key = "A", description = "Cycle audio output devices" },
        { key = "N", description = "Toggle Night Shift" },
        { key = "H", description = "Show this hotkey help" }
    }
}

function hotkeys.showHelp()
    local helpText = "Available hotkeys (using Super modifier):\n"
    for _, hotkey in ipairs(hotkeys.definitions) do
        helpText = helpText .. "Super+" .. hotkey.key .. ": " .. hotkey.description .. "\n"
    end
    hs.alert.closeAll()
    hs.alert.show(helpText, 5)
end

-- Initialize components
darkmode.init()

-- Set up hotkeys
hs.hotkey.bind(config.super, "R", hs.reload)
hs.hotkey.bind(config.super, "D", darkmode.toggle)
hs.hotkey.bind(config.super, "A", audio.cycleOutputDevices)
hs.hotkey.bind(config.super, "N", nightshift.toggle)
hs.hotkey.bind(config.super, "H", hotkeys.showHelp)

hs.alert.show("Config loaded")