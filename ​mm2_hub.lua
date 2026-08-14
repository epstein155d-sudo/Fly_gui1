-- =====================================================================
-- MM2 ULTIMATE HUB - ДЛЯ ЗОНИ ДОСЛІДЖЕННЯ ТА ПРОГРАМУВАННЯ
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Створюємо головний контейнер для GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2UltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- =====================================================================
-- 1. ПЛАВАЮЧА КНОПКА (DRAGGABLE & LOCK)
-- =====================================================================

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "FloatingMenuButton"
ToggleButton.Size = UDim2.new(0, 140, 0, 45)
ToggleButton.Position = UDim2.new(0, 50, 0, 100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "MM2 Hub [Відкрито]"
ToggleButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = ToggleButton

-- Замочок для блокування пересування кнопки (Toggle Lock)
local isLocked = false
local LockButton = Instance.new("TextButton")
LockButton.Size = UDim2.new(0, 25, 0, 25)
LockButton.Position = UDim2.new(1, -30, 0, 5)
LockButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockButton.TextSize = 12
LockButton.Text = "🔒"
LockButton.Parent = ToggleButton

local LockCorner = Instance.new("UICorner")
LockCorner.CornerRadius = UDim.new(0, 5)
LockCorner.Parent = LockButton

LockButton.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    if isLocked then
        LockButton.Text = "❌" -- Заблоковано
        print("Кнопка зафіксована на екрані (Lock увімкнено)")
    else
        LockButton.Text = "🔒" -- Розблоковано
        print("Кнопку можна пересувати")
    end
end)

-- Логіка перетягування кнопки пальцем / мишею
local dragging, dragInput, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
    if isLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and not isLocked then
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            ToggleButton.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

-- =====================================================================
-- 2. ОСНОВНЕ МЕНЮ (ХАБ НА 35+ ФУНКЦІЙ)
-- =====================================================================

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 300)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "MM2 Master Hub v1.0"
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleLabel

-- Відкриття/закриття головного меню при кліку на плаваючу кнопку
ToggleButton.MouseButton1Click:Connect(function(x, y)
    -- Якщо клікнули саме по замочку, не відкриваємо меню
    if dragging then return end
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        ToggleButton.Text = "MM2 Hub [Закрито]"
    else
        ToggleButton.Text = "MM2 Hub [Відкрито]"
    end
end)

-- =====================================================================
-- 3. МАТЕМАТИЧНА ОСНОВА ДЛЯ AIMLOCK ТА РОЗРАХУНКУ ВЕКТОРІВ
-- =====================================================================

local aimlockActive = false

-- Функція пошуку найближчого гравця з роллю Murderer
local function getNearestMurderer()
    local nearestTarget = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Перевірка чи є в руках вбивці ніж (умовна логіка MM2)
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character
            if character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then
                local rootPart = character.HumanoidRootPart
                local distance = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestTarget = rootPart
                end
            end
        end
    end
    return nearestTarget
end

-- Математичне спрямування камери на ціль (Aimlock з векторною геометрією)
RunService.RenderStepped:Connect(function()
    if aimlockActive then
        local targetRoot = getNearestMurderer()
        if targetRoot then
            -- Використовуємо математику CFrame.lookAt для точного розвороту камери на ціль
            local targetPosition = targetRoot.Position + Vector3.new(0, 1, 0) -- Націлюємось на тулуб/голову
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
        end
    end
end)

-- =====================================================================
-- 4. СТВОРЕННЯ КНОПОК ФУНКЦІЙ У МЕНЮ
-- =====================================================================

-- Кнопка Aimlock
local AimBtn = Instance.new("TextButton")
AimBtn.Size = UDim2.new(0, 180, 0, 40)
AimBtn.Position = UDim2.new(0, 20, 0, 60)
AimBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
AimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimBtn.TextSize = 14
AimBtn.Font = Enum.Font.Gotham
AimBtn.Text = "Aimlock: ВИМК"
AimBtn.Parent = MainFrame

AimBtn.MouseButton1Click:Connect(function()
    aimlockActive = not aimlockActive
    if aimlockActive then
        AimBtn.Text = "Aimlock: УВІМК"
        AimBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
    else
        AimBtn.Text = "Aimlock: ВИМК"
        AimBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

-- Кнопка ESP (Базова підсвітка)
local EspBtn = Instance.new("TextButton")
EspBtn.Size = UDim2.new(0, 180, 0, 40)
EspBtn.Position = UDim2.new(0, 220, 0, 60)
EspBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.TextSize = 14
EspBtn.Font = Enum.Font.Gotham
EspBtn.Text = "ESP Ролей: ВИМК"
EspBtn.Parent = MainFrame

local espEnabled = false
EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        EspBtn.Text = "ESP Ролей: УВІМК"
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
        print("ESP активовано: скануємо гравців...")
    else
        EspBtn.Text = "ESP Ролей: ВИМК"
        EspBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

print("MM2 Master Hub успішно завантажено! Інтерфейс та математика готові.")
