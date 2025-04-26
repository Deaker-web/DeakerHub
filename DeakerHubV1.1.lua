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
      Key = {"deaker.wtf"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
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
