
--========================================
-- YUXNG HUB V2
-- Rayfield UI
--========================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

-- DEFAULT CONFIG
local Defaults = {
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

local Config = table.clone(Defaults)

-- RAYFIELD
local Rayfield = loadstring(game:HttpGet(
    "https://sirius.menu/rayfield"
))()

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

-- TABS
local Main = Window:CreateTab("Main")
local Pets = Window:CreateTab("Pet Rarity")
local Collect = Window:CreateTab("Auto Collect")
local Treadmill = Window:CreateTab("Treadmill")
local Events = Window:CreateTab("Auto Event")
local Speed = Window:CreateTab("Speed")
local Configs = Window:CreateTab("Configs")

-- MAIN
Main:CreateSection("Welcome")

Main:CreateParagraph({
    Title = "YUXNG HUB V2",
    Content = "Welcome to your custom Steal an Egg hub!"
})

-- PET RARITY
Pets:CreateSection("Choose Pet Rarities")

local function CreateRarity(name)
    Pets:CreateToggle({
        Name = name,
        CurrentValue = Config[name],
        Flag = name,
        Callback = function(value)
            Config[name] = value
        end
    })
end

CreateRarity("Cosmic")
CreateRarity("Divine")
CreateRarity("Eternal")
CreateRarity("Secret")

Pets:CreateButton({
    Name = "Select All",
    Callback = function()
        for _, name in ipairs({
            "Cosmic", "Divine", "Eternal", "Secret"
        }) do
            Config[name] = true
        end
        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "All rarities selected!",
            Duration = 3
        })
    end
})

Pets:CreateButton({
    Name = "Deselect All",
    Callback = function()
        for _, name in ipairs({
            "Cosmic", "Divine", "Eternal", "Secret"
        }) do
            Config[name] = false
        end
        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "All rarities deselected!",
            Duration = 3
        })
    end
})

-- AUTO COLLECT
Collect:CreateSection("Pet Collection")

Collect:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(value)
        Config.AutoCollect = value
        print("Auto Collect:", value)
    end
})

-- TREADMILL
Treadmill:CreateSection("Treadmill Automation")

Treadmill:CreateToggle({
    Name = "Auto Treadmill",
    CurrentValue = false,
    Flag = "AutoTreadmill",
    Callback = function(value)
        Config.AutoTreadmill = value
        print("Auto Treadmill:", value)
    end
})

-- EVENTS
Events:CreateSection("Event Automation")

Events:CreateToggle({
    Name = "Auto Event",
    CurrentValue = false,
    Flag = "AutoEvent",
    Callback = function(value)
        Config.AutoEvent = value
        print("Auto Event:", value)
    end
})

-- SPEED
Speed:CreateSection("Movement")

local function ApplySpeed()
    local Character = Player.Character
    local Humanoid = Character and
        Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        Humanoid.WalkSpeed =
            Config.SpeedEnabled and Config.Speed or 16
    end
end

Speed:CreateToggle({
    Name = "Enable Speed",
    CurrentValue = false,
    Flag = "SpeedEnabled",
    Callback = function(value)
        Config.SpeedEnabled = value
        ApplySpeed()
    end
})

Speed:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 350},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Speed",
    Callback = function(value)
        Config.Speed = value
        ApplySpeed()
    end
})

Speed:CreateButton({
    Name = "Reset Speed",
    Callback = function()
        Config.Speed = 16
        Config.SpeedEnabled = false
        ApplySpeed()
    end
})

-- CHARACTER RESPAWN
Player.CharacterAdded:Connect(function()
    task.wait(1)
    ApplySpeed()
end)

-- CONFIGS
Configs:CreateSection("Configuration")

Configs:CreateButton({
    Name = "Show Current Config",
    Callback = function()
        print(HttpService:JSONEncode(Config))
        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "Config printed to console!",
            Duration = 3
        })
    end
})

Configs:CreateButton({
    Name = "Reset All Settings",
    Callback = function()
        Config = table.clone(Defaults)
        ApplySpeed()

        Rayfield:Notify({
            Title = "YUXNG HUB",
            Content = "Settings reset!",
            Duration = 3
        })
    end
})

Rayfield:Notify({
    Title = "YUXNG HUB V2",
    Content = "Successfully loaded!",
    Duration = 5
})

print("YUXNG HUB V2 loaded!")
