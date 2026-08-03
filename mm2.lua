-- MM2 Mobile Hub (Compact Version)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("MM2MobileHub") then
    CoreGui.MM2MobileHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2MobileHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Головне вікно (компактне)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 260)
MainFrame.Position = UDim2.new(0.5, -100, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
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
Title.Text = "🔪 MM2 Mobile Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Функція створення кнопок
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

-- Змінні для функцій
local espEnabled = false
local autoGrabEnabled = false

-- 1. ESP (Шериф і Вбивця)
createButton("👁 ESP (Sheriff/Murder)", 40, function()
    espEnabled = not espEnabled
    print("ESP toggled: " .. tostring(espEnabled))
    -- Простий цикл підсвічування
    task.spawn(function()
        while espEnabled do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local backpack = p:FindFirstChild("Backpack")
                    local char = p.Character
                    local highlight = char:FindFirstChild("MM2Highlight") or Instance.new("Highlight")
                    highlight.Name = "MM2Highlight"
                    highlight.Parent = char
                    
                    -- Шукаємо роль за зброєю
                    local hasGun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
                    local hasKnife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
                    
                    if hasKnife then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Червоний (Вбивця)
                    elseif hasGun then
                        highlight.FillColor = Color3.fromRGB(0, 100, 255) -- Синій (Шериф)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Зелений (Мирний)
                    end
                end
            end
            task.wait(1)
        end
        -- Видаляємо хайлайти при вимкненні
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("MM2Highlight") then
                p.Character.MM2Highlight:Destroy()
            end
        end
    end)
end)

-- 2. Автопідбір пістолета (Auto Grab Gun)
createButton("🔫 Auto Grab Gun", 78, function()
    autoGrabEnabled = not autoGrabEnabled
    task.spawn(function()
        while autoGrabEnabled do
            task.wait(0.5)
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "GunDrop" and obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    end
                end
            end)
        end
    end)
end)

-- 3. Швидкість (Speed Hack)
createButton("⚡ Speed Boost (25)", 116, function()
    pcall(function()
        LocalPlayer.Character.Humanoid.WalkSpeed = 25
    end)
end)

-- 4. Флінг гравців (Fling All)
createButton("🌪 Fling Players", 154, function()
    pcall(function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local bav = Instance.new("BodyAngularVelocity")
            bav.MaxTorque = Vector3.new(0, math.huge, 0)
            bav.AngularVelocity = Vector3.new(0, 5000, 0)
            bav.Parent = hrp
            task.wait(0.3)
            bav:Destroy()
        end
    end)
end)

-- Кнопка закриття/відкриття меню (менюшка-іконка збоку)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 35, 0, 35)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.35, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.Text = "🔪"
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
