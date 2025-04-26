getgenv().ESPTracers = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function AssignTracers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerChar = game.Workspace:FindFirstChild(player.Name)
            local LocalChar = LocalPlayer.Character
            if not PlayerChar or not LocalChar or not LocalChar:FindFirstChild("HumanoidRootPart") then
                return
            end


            local beam
            if PlayerChar and LocalChar then
                if PlayerChar:FindFirstChild("ESPBeam") then
                    beam = PlayerChar:FindFirstChild("ESPBeam")
                    if beam then
                        beam.Enabled = getgenv().ESPTracers
                        local attachment0 = Instance.new("Attachment", LocalChar:WaitForChild("HumanoidRootPart"))
                        beam.Attachment0 = attachment0
                    end
                end

                if not beam and getgenv().ESPTracers then
                    local attachment0 = Instance.new("Attachment", LocalChar:WaitForChild("HumanoidRootPart"))
                    local attachment1 = Instance.new("Attachment", PlayerChar:WaitForChild("HumanoidRootPart"))

                    beam = Instance.new("Beam")
                    beam.Name = "ESPBeam"
                    beam.Attachment0 = attachment0
                    beam.Attachment1 = attachment1
                    beam.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
                    beam.FaceCamera = true
                    beam.Width0 = 0.15
                    beam.Width1 = 0.15
                    beam.Parent = PlayerChar
                    beam.AlwaysOnTop = true
                end
            end
        end
    end
end

AssignTracers()

Players.PlayerAdded:Connect(function(player)
    repeat wait() until player.Character or wait(2)
    AssignTracers()
end)

LocalPlayer.CharacterAdded:Connect(function()
    repeat wait() until LocalPlayer.Character or wait(2)
    AssignTracers()
end)

--- Simple player highlighting and nametag script with toggle feature now
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local MaxDistance = 400.5 -- Range in studs for nametags to show

-- Toggle variable
local NametagsEnabled = false 

-- Function to create a nametag for a player
local function CreateNametag(Player)
    if Player == LocalPlayer then return end -- Skip local player

    local function SetupNametag(Character)
        local Head = Character:FindFirstChild("Head")
        if not Head then return end -- If no head, exit

        -- Remove existing nametag if it exists
        local OldNametag = Head:FindFirstChild("Nametag")
        if OldNametag then
            OldNametag:Destroy()
        end

        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "Nametag"
        BillboardGui.Adornee = Head
        BillboardGui.Size = UDim2.new(0, 75, 0, 150)
        BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
        BillboardGui.AlwaysOnTop = true

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Text = Player.Name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextStrokeTransparency = 0.75 -- Outline for better visibility
        TextLabel.Font = Enum.Font.Code
        TextLabel.TextScaled = true
        TextLabel.Parent = BillboardGui

        BillboardGui.Parent = Head

        -- Function to update visibility based on distance and toggle
        local function UpdateVisibility()
            if NametagsEnabled and Player.Character and Player.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                local Distance = (Player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                BillboardGui.Enabled = (Distance <= MaxDistance)
            else
                BillboardGui.Enabled = false
            end
        end

        -- Monitor visibility
        local Connection
        Connection = RunService.Heartbeat:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("Head") then
                UpdateVisibility()
            else
                BillboardGui:Destroy() -- Clean up nametag when player dies
                Connection:Disconnect()
            end
        end)
    end

    -- Apply when character spawns or respawns
    if Player.Character then
        SetupNametag(Player.Character)
    end
    Player.CharacterAdded:Connect(SetupNametag)
end

-- Function to apply ESP/Highlight to a player
local function ApplyHighlight(Player)
    if Player == LocalPlayer then return end -- Skip local player

    local function SetupHighlight(Character)
        -- Remove old highlights
        for _, v in pairs(Character:GetChildren()) do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end

        local Highlighter = Instance.new("Highlight")
        Highlighter.Parent = Character

        local function UpdateFillColor()
            local DefaultColor = Color3.fromRGB(255, 0, 0) -- Default red color
            Highlighter.FillColor = Player.TeamColor and Player.TeamColor.Color or DefaultColor
        end

        UpdateFillColor()
        Player:GetPropertyChangedSignal("TeamColor"):Connect(UpdateFillColor)

        -- Remove highlight when player dies
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.Died:Connect(function()
                Highlighter:Destroy()
            end)
        end
    end

    -- Apply highlight on spawn and respawn
    if Player.Character then
        SetupHighlight(Player.Character)
    end
    Player.CharacterAdded:Connect(SetupHighlight)
end

-- Function to toggle nametags
local function ToggleNametags()
    NametagsEnabled = not NametagsEnabled -- Flip the toggle state
    print("Nametags Enabled:", NametagsEnabled)

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
            local Nametag = Player.Character.Head:FindFirstChild("Nametag")
            if Nametag then
                Nametag.Enabled = NametagsEnabled
            end
        end
    end
end

-- Bind the toggle function to the "[" key
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if not GameProcessed and Input.KeyCode == Enum.KeyCode.LeftBracket then
        ToggleNametags()
    end
end)

-- Apply ESP and Nametags to all current players
for _, Player in pairs(Players:GetPlayers()) do
    CreateNametag(Player)
    ApplyHighlight(Player)
end

-- Apply ESP and Nametags to players who join later
Players.PlayerAdded:Connect(function(Player)
    CreateNametag(Player)
    ApplyHighlight(Player)
end)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Deaker Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Deaker Interface Suite",
   LoadingSubtitle = "by profeh",
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Deaker Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "discord.gg/https://EUSSWgT5Gg", -- The Discord invite code, do not include . E.g. discord.gg/https://EUSSWgT5Gg ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key System | @profeh_pot",
      Subtitle = "Deaker Hub",
      Note = "Join discord | https://discord.gg/EUSSWgT5Gg", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"яйко"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
   Title = "follow to discord",
   Content = "https://discord.gg/EUSSWgT5Gg",
   Duration = 3.5,
   Image = 4483362458,
})

local PlayerTab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Divider = PlayerTab:CreateDivider()

local Section = PlayerTab:CreateSection("Player")

Section:Set("Player")

local Slider = PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 250},
    Increment = 10,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
 })

 local Slider = PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(jump)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
    end,
 })

 local Slider = PlayerTab:CreateSlider({
    Name = "Health",
    Range = {100, 9999},
    Increment = 10,
    Suffix = "Health",
    CurrentValue = 100,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Health)
    game.Players.LocalPlayer.Character.Humanoid.Health = Health
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Health
    end,
 })

 local Button = PlayerTab:CreateButton({
    Name = "Tracers(wait 10-25 sec)",
    Callback = function(beam)
        getgenv().ESPTracers = true
    end,
 })
