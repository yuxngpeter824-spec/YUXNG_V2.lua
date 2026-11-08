--====================================
-- YUXNG HUB V2
-- UI FOUNDATION
--====================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Config = {
    Cosmic = true,
    Divine = true,
    Eternal = true,
    Secret = true,

    AutoCollect = false,
    AutoTreadmill = false,
    AutoEvent = false,

    SpeedEnabled = false,
    Speed = 16
}

local Rayfield = require(
    game.ReplicatedStorage:WaitForChild("Rayfield")
)

local Window = Rayfield:CreateWindow({
    Name = "YUXNG HUB | Steal an Egg",
    LoadingTitle = "YUXNG HUB",
    LoadingSubtitle = "Version 2.0",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "YUXNG_HUB",
        FileName = "MainConfig"
    },
    KeySystem = false
})

local Main = Window:CreateTab("Main")
local Pets = Window:CreateTab("Pet Rarity")
local Collect = Window:CreateTab("Auto Collect")
local Treadmill = Window:CreateTab("Treadmill")
local Events = Window:CreateTab("Auto Event")
local Speed = Window:CreateTab("Speed")
local Configs = Window:CreateTab("Configs")

Main:CreateParagraph({
    Title = "YUXNG HUB V2",
    Content = "Welcome to YUXNG HUB!"
})

-- PET RARITY

local Rarities = {
    "Cosmic",
    "Divine",
    "Eternal",
    "Secret"
}

for _, rarity in ipairs(Rarities) do
    Pets:CreateToggle({
        Name = rarity,
        CurrentValue = Config[rarity],
        Callback = function(value)
            Config[rarity] = value
        end
    })
end

Pets:CreateButton({
    Name = "Select All",
    Callback = function()
        for _, rarity in ipairs(Rarities) do
            Config[rarity] = true
        end
        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "All rarities selected!"
        })
    end
})

Pets:CreateButton({
    Name = "Deselect All",
    Callback = function()
        for _, rarity in ipairs(Rarities) do
            Config[rarity] = false
        end
        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "All rarities deselected!"
        })
    end
})

-- FEATURE SWITCHES

local function AddToggle(tab, name, key)
    tab:CreateToggle({
        Name = name,
        CurrentValue = Config[key],
        Callback = function(value)
            Config[key] = value
        end
    })
end

AddToggle(Collect, "Auto Collect", "AutoCollect")
AddToggle(Treadmill, "Auto Treadmill", "AutoTreadmill")
AddToggle(Events, "Auto Event", "AutoEvent")

-- SPEED

Speed:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 350},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value)
        Config.Speed = value
    end
})

Speed:CreateToggle({
    Name = "Enable Speed",
    CurrentValue = false,
    Callback = function(value)
        Config.SpeedEnabled = value
    end
})

-- CONFIG

Configs:CreateButton({
    Name = "Show Current Config",
    Callback = function()
        print("YUXNG CONFIG:")
        for key, value in pairs(Config) do
            print(key, value)
        end
    end
})

Configs:CreateButton({
    Name = "Reset Config",
    Callback = function()
        Config = {
            Cosmic = true,
            Divine = true,
            Eternal = true,
            Secret = true,
            AutoCollect = false,
            AutoTreadmill = false,
            AutoEvent = false,
            SpeedEnabled = false,
            Speed = 16
        }

        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "Configuration reset!"
        })
    end
})

Rayfield:Notify({
    Title = "YUXNG HUB",
    Content = "Version 2.0 loaded!"
})
