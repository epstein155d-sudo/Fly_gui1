-- =====================================================================
-- MM2 ULTIMATE HUB - UPDATED & FIXED VERSION
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Оптимізоване знаходження PlayerGui
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("MM2UltimateHub") then
    PlayerGui.MM2UltimateHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2UltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- =====================================================================
-- 1. ПЛАВАЮЧА КНОПКА
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

local isLocked = false
local LockButton = Instance.new("TextButton")
LockButton.Size = UDim2.new(0, 25, 0, 25)
LockButton.Position = UDim2.new(1, -30, 0, 5)
LockButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockButton.TextSize = 12
LockButton.Text = "🔒"
LockButton.Parent = ToggleButton

LockButton.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    LockButton.Text = isLocked and "❌" or "🔒"
end)

local dragging, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
    if isLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and not isLocked then
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- =====================================================================
-- 2. ОСНОВНЕ МЕНЮ
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

ToggleButton.MouseButton1Click:Connect(function()
    if dragging then return end
    MainFrame.Visible = not MainFrame.Visible
    ToggleButton.Text = MainFrame.Visible and "MM2 Hub [Закрито]" or "MM2 Hub [Відкрито]"
end)

-- =====================================================================
-- 3. БЕЗПЕЧНИЙ AIMLOCK (Heartbeat)
-- =====================================================================

local aimlockActive = false

local function getNearestMurderer()
    local nearestTarget = nil
    local shortestDistance = math.huge
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myRoot = myChar.HumanoidRootPart
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            local hasKnife = player.Character:FindFirstChild("Knife") or (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife"))
            if rootPart and hasKnife then
                local distance = (rootPart.Position - myRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestTarget = rootPart
                end
            end
        end
    end
    return nearestTarget
end

-- Виправлений блок (Heartbeat замість RenderStepped)
RunService.Heartbeat:Connect(function()
    if aimlockActive then
        pcall(function()
            local targetRoot = getNearestMurderer()
            if targetRoot then
                local targetPosition = targetRoot.Position + Vector3.new(0, 1, 0)
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
            end
        end)
    end
end)

-- =====================================================================
-- 4. КНОПКИ
-- =====================================================================

local AimBtn = Instance.new("TextButton")
AimBtn.Size = UDim2.new(0, 180, 0, 40)
AimBtn.Position = UDim2.new(0, 20, 0, 60)
AimBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
AimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimBtn.Text = "Aimlock: ВИМК"
AimBtn.Parent = MainFrame

AimBtn.MouseButton1Click:Connect(function()
    aimlockActive = not aimlockActive
    AimBtn.Text = aimlockActive and "Aimlock: УВІМК" or "Aimlock: ВИМК"
    AimBtn.BackgroundColor3 = aimlockActive and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(45, 45, 65)
end)

print("MM2 Master Hub завантажено успішно!")
