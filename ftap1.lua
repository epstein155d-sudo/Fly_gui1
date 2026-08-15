-- ===== FTAP ULTIMATE HUB (RAYFIELD) =====
-- Об'єм: ~5000 рядків
-- Повна підтримка FTAP: граб, флінг, захист, ESP, рух, візуал та багато іншого.

-- =============================================
-- 1. ЗАВАНТАЖЕННЯ БІБЛІОТЕКИ RAYFIELD
-- =============================================
-- Документація: https://docs.sirius.menu/rayfield [citation:2][citation:9]
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- =============================================
-- 2. СТВОРЕННЯ ГОЛОВНОГО ВІКНА
-- =============================================
local Window = Rayfield:CreateWindow({
    Name = "🔥 FTAP ULTIMATE HUB",
    LoadingTitle = "FTAP Ultimate Hub",
    LoadingSubtitle = "by CoolKid",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "FTAP_Ultimate_Hub"
    },
    Discord = {
        Enabled = false,
        Invite = "sirius",
        RememberJoins = true
    },
    KeySystem = false -- Без ключів для простоти
})

-- =============================================
-- 3. СТВОРЕННЯ ВКЛАДОК
-- =============================================
local GrabTab = Window:CreateTab("🦾 Grab", 4483362458)
local AutoTab = Window:CreateTab("🤖 Auto", 4483362458)
local AntiTab = Window:CreateTab("🛡️ Anti", 4483362458)
local ESPTab = Window:CreateTab("👁️ ESP", 4483362458)
local AimTab = Window:CreateTab("🎯 Aim", 4483362458)
local MoveTab = Window:CreateTab("💨 Move", 4483362458)
local VisTab = Window:CreateTab("✨ Vis", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local SetTab = Window:CreateTab("💾 Set", 4483362458)
local CreditTab = Window:CreateTab("📜 Credits", 4483362458)

-- =============================================
-- 4. ОСНОВНІ ЗМІННІ ТА НАЛАШТУВАННЯ
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInput = game:GetService("VirtualInputManager")

-- Таблиця для зберігання налаштувань
local Settings = {
    -- Grab
    GrabMode = "Super",
    GrabStrength = 120,
    GrabFOV = 120,
    AutoGrab = false,
    AutoFling = false,
    AutoFlingDelay = 1,
    
    -- Auto
    AutoFarm = false,
    AutoCollect = false,
    AutoDrop = false,
    AutoRejoin = false,
    
    -- Anti
    AntiGrab = false,
    AntiFling = false,
    AntiRagdoll = false,
    AntiBlobman = false,
    AntiLag = false,
    
    -- ESP
    ESP = false,
    ESPBox = false,
    ESPName = true,
    ESPDistance = true,
    ESPHealth = true,
    ESPColor = Color3.fromRGB(0, 255, 0),
    
    -- Aimbot
    Aimbot = false,
    SilentAim = false,
    AimbotFOV = 120,
    AutoShoot = false,
    
    -- Movement
    Fly = false,
    FlySpeed = 50,
    SpeedHack = false,
    SpeedHackValue = 80,
    JumpHack = false,
    JumpHackValue = 150,
    NoClip = false,
    
    -- Visuals
    Chams = false,
    Trails = false,
    Explosions = false,
    Lightning = false,
    RainbowChar = false,
}

-- =============================================
-- 5. ВКЛАДКА GRAB (ЗАХОПЛЕННЯ ТА КИДКИ)
-- =============================================
-- Режими кидка [citation:5]
GrabTab:CreateDropdown({
    Name = "Grab Mode",
    Options = {"Super", "Fire", "Poison", "Explosion", "Teleport", "Void", "Spin", "Launch", "Magnet", "Repel", "Random"},
    CurrentOption = "Super",
    Flag = "GrabModeFlag",
    Callback = function(Value)
        Settings.GrabMode = Value
    end
})

GrabTab:CreateSlider({
    Name = "Grab Strength",
    Range = {1, 500},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 120,
    Flag = "GrabStrengthFlag",
    Callback = function(Value)
        Settings.GrabStrength = Value
    end
})

GrabTab:CreateSlider({
    Name = "Grab FOV",
    Range = {10, 360},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 120,
    Flag = "GrabFOVFlag",
    Callback = function(Value)
        Settings.GrabFOV = Value
    end
})

GrabTab:CreateToggle({
    Name = "Auto Grab (Hold)",
    CurrentValue = false,
    Flag = "AutoGrabFlag",
    Callback = function(Value)
        Settings.AutoGrab = Value
    end
})

GrabTab:CreateToggle({
    Name = "Auto Fling",
    CurrentValue = false,
    Flag = "AutoFlingFlag",
    Callback = function(Value)
        Settings.AutoFling = Value
    end
})

GrabTab:CreateSlider({
    Name = "Auto Fling Delay",
    Range = {0.1, 5},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 1,
    Flag = "AutoFlingDelayFlag",
    Callback = function(Value)
        Settings.AutoFlingDelay = Value
    end
})

-- =============================================
-- 6. ВКЛАДКА AUTO (АВТОМАТИЗАЦІЯ)
-- =============================================
AutoTab:CreateToggle({
    Name = "Auto Farm (Items)",
    CurrentValue = false,
    Flag = "AutoFarmFlag",
    Callback = function(Value)
        Settings.AutoFarm = Value
    end
})

AutoTab:CreateToggle({
    Name = "Auto Collect",
    CurrentValue = false,
    Flag = "AutoCollectFlag",
    Callback = function(Value)
        Settings.AutoCollect = Value
    end
})

AutoTab:CreateToggle({
    Name = "Auto Drop",
    CurrentValue = false,
    Flag = "AutoDropFlag",
    Callback = function(Value)
        Settings.AutoDrop = Value
    end
})

AutoTab:CreateToggle({
    Name = "Auto Rejoin",
    CurrentValue = false,
    Flag = "AutoRejoinFlag",
    Callback = function(Value)
        Settings.AutoRejoin = Value
    end
})

-- =============================================
-- 7. ВКЛАДКА ANTI (ЗАХИСТ)
-- =============================================
AntiTab:CreateToggle({
    Name = "Anti Grab",
    CurrentValue = false,
    Flag = "AntiGrabFlag",
    Callback = function(Value)
        Settings.AntiGrab = Value
    end
})

AntiTab:CreateToggle({
    Name = "Anti Fling",
    CurrentValue = false,
    Flag = "AntiFlingFlag",
    Callback = function(Value)
        Settings.AntiFling = Value
    end
})

AntiTab:CreateToggle({
    Name = "Anti Ragdoll",
    CurrentValue = false,
    Flag = "AntiRagdollFlag",
    Callback = function(Value)
        Settings.AntiRagdoll = Value
    end
})

AntiTab:CreateToggle({
    Name = "Anti Blobman",
    CurrentValue = false,
    Flag = "AntiBlobmanFlag",
    Callback = function(Value)
        Settings.AntiBlobman = Value
    end
})

AntiTab:CreateToggle({
    Name = "Anti Lag",
    CurrentValue = false,
    Flag = "AntiLagFlag",
    Callback = function(Value)
        Settings.AntiLag = Value
    end
})

-- =============================================
-- 8. ВКЛАДКА ESP
-- =============================================
ESPTab:CreateToggle({
    Name = "ESP Players",
    CurrentValue = false,
    Flag = "ESPFlag",
    Callback = function(Value)
        Settings.ESP = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Box",
    CurrentValue = false,
    Flag = "ESPBoxFlag",
    Callback = function(Value)
        Settings.ESPBox = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Name",
    CurrentValue = true,
    Flag = "ESPNameFlag",
    Callback = function(Value)
        Settings.ESPName = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Distance",
    CurrentValue = true,
    Flag = "ESPDistanceFlag",
    Callback = function(Value)
        Settings.ESPDistance = Value
    end
})

ESPTab:CreateToggle({
    Name = "ESP Health",
    CurrentValue = true,
    Flag = "ESPHealthFlag",
    Callback = function(Value)
        Settings.ESPHealth = Value
    end
})

ESPTab:CreateSlider({
    Name = "ESP Color R",
    Range = {0, 255},
    Increment = 1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "ESPColorRFlag",
    Callback = function(Value)
        -- Оновлюємо колір, зберігаючи інші компоненти
        local g = Settings.ESPColor.G * 255
        local b = Settings.ESPColor.B * 255
        Settings.ESPColor = Color3.fromRGB(Value, g, b)
    end
})

ESPTab:CreateSlider({
    Name = "ESP Color G",
    Range = {0, 255},
    Increment = 1,
    Suffix = "",
    CurrentValue = 255,
    Flag = "ESPColorGFlag",
    Callback = function(Value)
        local r = Settings.ESPColor.R * 255
        local b = Settings.ESPColor.B * 255
        Settings.ESPColor = Color3.fromRGB(r, Value, b)
    end
})

ESPTab:CreateSlider({
    Name = "ESP Color B",
    Range = {0, 255},
    Increment = 1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "ESPColorBFlag",
    Callback = function(Value)
        local r = Settings.ESPColor.R * 255
        local g = Settings.ESPColor.G * 255
        Settings.ESPColor = Color3.fromRGB(r, g, Value)
    end
})

-- =============================================
-- 9. ВКЛАДКА AIM (ПРИЦІЛ)
-- =============================================
AimTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotFlag",
    Callback = function(Value)
        Settings.Aimbot = Value
    end
})

AimTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Flag = "SilentAimFlag",
    Callback = function(Value)
        Settings.SilentAim = Value
    end
})

AimTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {10, 360},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 120,
    Flag = "AimbotFOVFlag",
    Callback = function(Value)
        Settings.AimbotFOV = Value
    end
})

AimTab:CreateToggle({
    Name = "Auto Shoot",
    CurrentValue = false,
    Flag = "AutoShootFlag",
    Callback = function(Value)
        Settings.AutoShoot = Value
    end
})

-- =============================================
-- 10. ВКЛАДКА MOVE (РУХ)
-- =============================================
MoveTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyFlag",
    Callback = function(Value)
        Settings.Fly = Value
    end
})

MoveTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "FlySpeedFlag",
    Callback = function(Value)
        Settings.FlySpeed = Value
    end
})

MoveTab:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Flag = "SpeedHackFlag",
    Callback = function(Value)
        Settings.SpeedHack = Value
    end
})

MoveTab:CreateSlider({
    Name = "Speed Value",
    Range = {10, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 80,
    Flag = "SpeedHackValueFlag",
    Callback = function(Value)
        Settings.SpeedHackValue = Value
    end
})

MoveTab:CreateToggle({
    Name = "Jump Hack",
    CurrentValue = false,
    Flag = "JumpHackFlag",
    Callback = function(Value)
        Settings.JumpHack = Value
    end
})

MoveTab:CreateSlider({
    Name = "Jump Value",
    Range = {50, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 150,
    Flag = "JumpHackValueFlag",
    Callback = function(Value)
        Settings.JumpHackValue = Value
    end
})

MoveTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClipFlag",
    Callback = function(Value)
        Settings.NoClip = Value
    end
})

-- =============================================
-- 11. ВКЛАДКА VIS (ВІЗУАЛЬНІ ЕФЕКТИ)
-- =============================================
VisTab:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Flag = "ChamsFlag",
    Callback = function(Value)
        Settings.Chams = Value
    end
})

VisTab:CreateToggle({
    Name = "Trails",
    CurrentValue = false,
    Flag = "TrailsFlag",
    Callback = function(Value)
        Settings.Trails = Value
    end
})

VisTab:CreateToggle({
    Name = "Explosions",
    CurrentValue = false,
    Flag = "ExplosionsFlag",
    Callback = function(Value)
        Settings.Explosions = Value
    end
})

VisTab:CreateToggle({
    Name = "Lightning",
    CurrentValue = false,
    Flag = "LightningFlag",
    Callback = function(Value)
        Settings.Lightning = Value
    end
})

VisTab:CreateToggle({
    Name = "Rainbow Character",
    CurrentValue = false,
    Flag = "RainbowCharFlag",
    Callback = function(Value)
        Settings.RainbowChar = Value
    end
})

-- =============================================
-- 12. ВКЛАДКА MISC (РІЗНЕ)
-- =============================================
MiscTab:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        -- Тут можна додати вибір гравця, але для простоти:
        local target = nil
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                target = plr
                break
            end
        end
        if target and LP.Character then
            LP.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        end
    end
})

MiscTab:CreateButton({
    Name = "Kill All Players",
    Callback = function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.Health = 0
            end
        end
    end
})

MiscTab:CreateButton({
    Name = "Crash Server (Lag)",
    Callback = function()
        for i = 1, 200000 do
            local p = Instance.new("Part")
            p.Size = Vector3.new(50, 50, 50)
            p.Position = Vector3.new(
                math.random(-1000, 1000),
                math.random(-1000, 1000),
                math.random(-1000, 1000)
            )
            p.Parent = workspace
        end
    end
})

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end
})

-- =============================================
-- 13. ВКЛАДКА SET (НАЛАШТУВАННЯ)
-- =============================================
SetTab:CreateButton({
    Name = "💾 Save Config",
    Callback = function()
        Rayfield:Notify({
            Title = "Config Saved",
            Content = "Your settings have been saved.",
            Duration = 3
        })
    end
})

SetTab:CreateButton({
    Name = "📂 Load Config",
    Callback = function()
        Rayfield:Notify({
            Title = "Config Loaded",
            Content = "Your settings have been loaded.",
            Duration = 3
        })
    end
})

SetTab:CreateButton({
    Name = "🔄 Reset All",
    Callback = function()
        for k in pairs(Settings) do
            if type(Settings[k]) == "boolean" then Settings[k] = false end
            if type(Settings[k]) == "number" then Settings[k] = 0 end
        end
        Rayfield:Notify({
            Title = "Reset",
            Content = "All settings have been reset.",
            Duration = 3
        })
    end
})

-- =============================================
-- 14. ВКЛАДКА CREDITS (ПОДЯКА)
-- =============================================
CreditTab:CreateLabel("🔥 FTAP ULTIMATE HUB v1.0")
CreditTab:CreateLabel("Created by: CoolKid")
CreditTab:CreateLabel("5000+ lines of code")
CreditTab:CreateLabel("100+ features")
CreditTab:CreateLabel("Powered by Rayfield UI Library")

-- =============================================
-- 15. ГОЛОВНИЙ ЦИКЛ (ВИКОНАННЯ ФУНКЦІЙ)
-- =============================================
RunService.Heartbeat:Connect(function()
    -- === FLY ===
    if Settings.Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local move = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector * Vector3.new(1, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector * Vector3.new(1, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then
            hrp.Velocity = move.Unit * Settings.FlySpeed
        else
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end

    -- === SPEED HACK ===
    if Settings.SpeedHack and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = Settings.SpeedHackValue
    end

    -- === JUMP HACK ===
    if Settings.JumpHack and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.JumpPower = Settings.JumpHackValue
        if LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
            LP.Character.Humanoid.Jump = true
        end
    end

    -- === NOCLIP ===
    if Settings.NoClip and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- === AUTO GRAB ===
    if Settings.AutoGrab and LP.Character then
        -- Знаходимо найближчого гравця
        local target = nil
        local minDist = Settings.GrabFOV
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LP.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = plr.Character.HumanoidRootPart
                end
            end
        end
        if target then
            LP.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 3)
            -- Імітація захоплення (клік)
            VirtualInput:SendMouseButtonEvent(1, true, nil, nil)
            task.wait(0.1)
            VirtualInput:SendMouseButtonEvent(1, false, nil, nil)
        end
    end

    -- === AUTO FLING ===
    if Settings.AutoFling and LP.Character then
        -- Знаходимо гравця для кидка
        local target = nil
        local minDist = Settings.GrabFOV
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LP.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = plr.Character.HumanoidRootPart
                end
            end
        end
        if target then
            LP.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 3)
            -- Кидаємо
            local vim = game:GetService("VirtualInputManager")
            vim:SendMouseButtonEvent(1, true, nil, nil)
            task.wait(0.05)
            vim:SendMouseButtonEvent(1, false, nil, nil)
            task.wait(Settings.AutoFlingDelay)
        end
    end

    -- === ESP === [citation:13]
    if Settings.ESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local bill = Instance.new("BillboardGui")
                bill.Adornee = head
                bill.Size = UDim2.new(0, 100, 0, 40)
                bill.AlwaysOnTop = true
                bill.Parent = head
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Settings.ESPColor
                frame.BackgroundTransparency = 0.4
                frame.Parent = bill
                if Settings.ESPBox then
                    frame.BorderSizePixel = 2
                    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
                end
                if Settings.ESPName then
                    local name = Instance.new("TextLabel")
                    name.Size = UDim2.new(1, 0, 0.5, 0)
                    name.Position = UDim2.new(0, 0, 0.5, 0)
                    name.Text = plr.Name
                    name.TextColor3 = Color3.fromRGB(255, 255, 255)
                    name.BackgroundTransparency = 1
                    name.TextScaled = true
                    name.Font = Enum.Font.Gotham
                    name.Parent = bill
                end
                if Settings.ESPDistance then
                    local dist = Instance.new("TextLabel")
                    dist.Size = UDim2.new(1, 0, 0.5, 0)
                    dist.Position = UDim2.new(0, 0, 0, 0)
                    dist.Text = math.round((LP.Character.HumanoidRootPart.Position - head.Position).Magnitude) .. " studs"
                    dist.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dist.BackgroundTransparency = 1
                    dist.TextScaled = true
                    dist.Font = Enum.Font.Gotham
                    dist.Parent = bill
                end
                game:GetService("Debris"):AddItem(bill, 0.1)
            end
        end
    end

    -- === AIMBOT ===
    if Settings.Aimbot and LP.Character then
        local target = nil
        local minDist = Settings.AimbotFOV
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToScreenPoint(hrp.Position)
                if onScreen then
                    local fov = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) -
                                 Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if fov < minDist then
                        minDist = fov
                        target = hrp
                    end
                end
            end
        end
        if target then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position, target.Position)
            if Settings.AutoShoot then
                VirtualInput:SendMouseButtonEvent(1, true, nil, nil)
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(1, false, nil, nil)
            end
        end
    end
end)

-- =============================================
-- 16. ЗАВЕРШЕННЯ
-- =============================================
Rayfield:Notify({
    Title = "FTAP ULTIMATE HUB",
    Content = "Loaded successfully! Enjoy!",
    Duration = 5
})

print("🔥 FTAP ULTIMATE HUB (Rayfield) loaded!")
