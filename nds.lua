-- Natural Disaster Survival Hub (Mobile & Draggable)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

if CoreGui:FindFirstChild("NDSHubGUI") then
    CoreGui.NDSHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NDSHubGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Головне вікно (можна перетягувати)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 210, 0, 250)
MainFrame.Position = UDim2.new(0.5, -105, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Перетягування пальцем/мишкою!
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(150, 50, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🌪️ Natural Disaster Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Контейнер для сповіщень про катаклізм
local DisasterLabel = Instance.new("TextLabel")
DisasterLabel.Size = UDim2.new(0.9, 0, 0, 25)
DisasterLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
DisasterLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
DisasterLabel.Text = "Пошук катаклізму..."
DisasterLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
DisasterLabel.TextSize = 12
DisasterLabel.Font = Enum.Font.SourceSansSemibold
DisasterLabel.Parent = MainFrame

local LabelCorner = Instance.new("UICorner")
LabelCorner.CornerRadius = UDim.new(0, 6)
LabelCorner.Parent = DisasterLabel

-- Функція для кнопок
local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. Детектор катаклізму (Notification/Radar)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local tag = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("SurvivalTag")
            if tag then
                DisasterLabel.Text = "⚠️ " .. tag.Value
            else
                DisasterLabel.Text = "⏳ Очікування раунду..."
            end
        end)
    end
end)

-- 2. Безпечний острів / Платформа у повітрі (Safe Platform)
local safePlatform = nil
createButton("🛡️ Safe Zone Platform", 75, function()
    pcall(function()
        if not safePlatform or not safePlatform.Parent then
            safePlatform = Instance.new("Part")
            safePlatform.Name = "SafeZoneNDS"
            safePlatform.Size = Vector3.new(30, 2, 30)
            safePlatform.Position = Vector3.new(0, 180, 0) -- Високо в небі
            safePlatform.Anchored = true
            safePlatform.Material = Enum.Material.ForceField
            safePlatform.Color = Color3.fromRGB(150, 50, 255)
            safePlatform.Parent = Workspace
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = safePlatform.CFrame + Vector3.new(0, 5, 0)
        end
    end)
end)

-- 3. Телепорт на Острів / Карту (Island Teleport)
createButton("🏝️ Teleport to Island", 115, function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2, 48, 0)
        end
    end)
end)

-- 4. Швидкість для втечі (WalkSpeed Boost)
createButton("⚡ Speed Boost (30)", 155, function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 30
        end
    end)
end)

-- Маленька кнопка відкриття/закриття меню
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 35, 0, 35)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.Text = "🌪️"
ToggleBtn.TextSize = 16
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 18)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(150, 50, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
