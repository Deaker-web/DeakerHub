repeat
	task.wait(0.5)
until not UESP_LOADING and not USCRIPT_LOADING
getgenv().UAIM_LOADING = true
if not AimbotSettings then
	getgenv().AimbotSettings = {
		TeamCheck = true, -- Press ] to toggle
		VisibleCheck = true,
		IgnoreTransparency = true, -- if enabled, visible check will automatically filter transparent objects
		IgnoredTransparency = 0.5, -- all parts with a transparency greater than this will be ignored (IgnoreTransparency has to be enabled)
		RefreshRate = 10, -- how fast the aimbot updates (milliseconds)
		Keybind = "MouseButton2",
		ToggleKey = "RightShift",
		MaximumDistance = 300, -- Set this to something lower if you dont wanna lock on some random person across the map
		AlwaysActive = false,
		Aimbot = {
			Enabled = true,
			TargetPart = "Head",
			Use_mousemoverel = true,
			Strength = 100, -- 1% - 200%
			AimType = "Hold", -- "Hold" or "Toggle"
			AimAtNearestPart = false
		},
		AimAssist = {
			Enabled = false,
			MinFov = 15,
			MaxFov = 80,
			DynamicFov = true,
			ShowFov = false, -- Shows Min & Max fov
			Strength = 55, -- 1% - 100%
			SlowSensitivity = true,
			SlowFactor = 1.75, -- 1% - 10%
			RequireMovement = true
		},
		FovCircle = {
			Enabled = true,
			Dynamic = true,
			Radius = 100,
			Transparency = 1,
			Color = Color3.fromRGB(255,255,255),
			NumSides = 64,
		},
		TriggerBot = {
			Enabled = false,
			Delay = 60, -- how long it waits before clicking (milliseconds)
			Spam = true, -- for semi-auto weapons
			ClicksPerSecond = 10, -- set this to 0 to get anything higher than 37 cps
			UseKeybind = false, -- if enabled, your keybind must be held to use trigger bot
		},
		Crosshair = {
			Enabled = false,
			Transparency = 1,
			TransparencyKeybind = 1, -- when the keybind is held, the crosshair's transparency will be changed to this
			Color = Color3.fromRGB(255, 0, 0),
			RainbowColor = false,
			Length = 15,
			Thickness = 2,
			Offset = 0
		},
		Prediction = {
			Enabled = false,
			Strength = 2
		},
		Priority = {},
		Whitelisted = {}, -- Username or User ID
		WhitelistFriends = true, -- Automatically adds friends to the whitelist
		Ignore = {} -- Raycast Ignore
	}
end

if UAIM then
	return
end
getgenv().OldInstance = nil

local function Load(file)
	return loadstring(game:HttpGet(string.format("https://raw.githubusercontent.com/zzerexx/scripts/main/%s.lua", file)), file)()
end
