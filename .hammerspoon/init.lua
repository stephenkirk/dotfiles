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

-- Pomodoro timer
local defaultDuration = 25 * 60
local secondsLeft = defaultDuration
local timer = hs.timer.new(1, function() updateTimer() end)
local timerIsActive = false
local timerMenu

function updateTimer()
	secondsLeft = secondsLeft - 1
	updateTimerMenu()
	if secondsLeft <= 0 then
		-- TODO: Log finished pomodoro's somewhere
		stopTimer()
		hs.alert.show("Timer done!")
		-- TODO: Alert
	end
end

function updateTimerMenu()
	if not timerMenu then 
		timerMenu = hs.menubar.new()
		timerMenu:setTooltip("Timer")
	end
	timerMenu:returnToMenuBar();

	if timerIsActive then
		timerMenu:setTitle("work")
	else
		timerMenu:setTitle("paused")
	end

    local minutes = math.floor(secondsLeft / 60)
	local seconds = secondsLeft - (minutes * 60)
	local timeLeft = string.format("%02d:%02d", minutes, seconds)

    local items = {
            {title = "Stop", fn = function() stopTimer() end},
        }

    if timerIsActive then
        table.insert(items, 1, {title = "Pause", fn = function() pauseTimer() end})
    else
        table.insert(items, 1, {title = "Start", fn = function() startTimer() end})
    end
    table.insert(items, 1, {title = timeLeft})

    timerMenu:setMenu(items)
end

function toggleTimer()
    if timerIsActive then 
    	pauseTimer()
    else 
    	startTimer()
    end
end

function startTimer()
    if timerIsActive then return end
    timer:start()
    timerIsActive = true
end

function pauseTimer()
	timer:stop()
	timerIsActive = false
	updateTimerMenu()
end

function stopTimer()
	pauseTimer()
	secondsLeft = defaultDuration
	timerIsActive = false
	timerMenu:delete()
end

hs.hotkey.bind(super, "T", function() toggleTimer() end)
hs.hotkey.bind(super, "Y", function() stopTimer() end)

--

hs.hotkey.bind(super, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded")