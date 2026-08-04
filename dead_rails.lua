-- Martin Hub | Dead Rails :) (Mobile Friendly & Fully Draggable)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("MartinHubDeadRails") then
    CoreGui.MartinHubDeadRails:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinHubDeadRails"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Головне вікно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 370)
MainFrame.Position = UDim2.new(0.5, -130, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 170, 0) -- Теплий пустельний/залізничний колір
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок Martin Hub
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 38)
Title.BackgroundTransparency = 1
Title.Text = "🚂 Martin Hub | Dead Rails :)"
Title.TextColor3 = Color3.fromRGB(255, 200, 50)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Скролл для кнопок
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(0.92, 0, 0.85, 0)
Scroll.Position = UDim2.new(0.04, 0, 0.12, 0)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0, 0, 0, 520)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Scroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- Функція створення кнопок-перемикачів
local function createToggle(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = text .. " [ON]"
            btn.TextColor3 = Color3.fromRGB(255, 170, 0)
            btn.BackgroundColor3 = Color3.fromRGB(50, 45, 35)
        else
            btn.Text = text .. " [OFF]"
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end
        pcall(callback, state)
    end)
    return btn
end

---------------------------------------------------------
-- 🛡️ 1. Режим Безсмертя та Захисту
---------------------------------------------------------

-- 1. Godmode / Anti-Damage (Зомбі не зносять HP)
local godmodeConn = nil
createToggle("🛡️ Godmode (No Damage)", function(active)
    if active then
        godmodeConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
            end
        end)
    else
        if godmodeConn then godmodeConn:Disconnect() end
    end
end)

-- 2. Zombie Anti-Target (Зомбі не реагують на тебе)
local antiTargetConn = nil
createToggle("👻 Zombie Anti-Target", function(active)
    if active then
        antiTargetConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = false
                    end
                end
            end
        end)
    else
        if antiTargetConn then antiTargetConn:Disconnect() end
    end
end)

---------------------------------------------------------
-- ⚔️ 2. Бій та Автоматизація
---------------------------------------------------------

-- 3. KillAura / Auto-Melee (Авто-удар по зомбі)
local killAuraConn = nil
createToggle("⚔️ KillAura (Auto-Hit Zombies)", function(active)
    if active then
        killAuraConn = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myPos = LocalPlayer.Character.HumanoidRootPart.Position
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Humanoid") and obj.Parent ~= LocalPlayer.Character and obj.Health > 0 then
                        local root = obj.Parent:FindFirstChild("HumanoidRootPart") or obj.Parent:FindFirstChild("Torso")
                        if root and (root.Position - myPos).Magnitude < 15 then
                            obj:TakeDamage(25)
                        end
                    end
                end
            end
        end)
    else
        if killAuraConn then killAuraConn:Disconnect() end
    end
end)

---------------------------------------------------------
-- 🚂 3. Помічник Потяга
---------------------------------------------------------

-- 4. Auto-Clear Sand Wheels (Чищення коліс під час бурі)
local sandClearConn = nil
createToggle("🧹 Auto-Clear Sand Wheels", function(active)
    if active then
        sandClearConn = RunService.RenderStepped:Connect(function()
            for _, item in pairs(Workspace:GetDescendants()) do
                if item.Name:lower():find("sand") or item.Name:lower():find("dust") then
                    if item:IsA("BasePart") then
                        item.CanCollide = false
                    end
                end
            end
        end)
    else
        if sandClearConn then sandClearConn:Disconnect() end
    end
end)

---------------------------------------------------------
-- 👁️ 4. Візуали (ESP)
---------------------------------------------------------

local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESPFolder"

-- 5. Zombie ESP
createToggle("👁️ Zombie ESP", function(active)
    espFolder:ClearAllChildren()
    if active then
        task.spawn(function()
            for _, model in pairs(Workspace:GetDescendants()) do
                if model:IsA("Model") and model:FindFirstChild("Humanoid") and model ~= LocalPlayer.Character then
                    local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
                    if root then
                        local bb = Instance.new("BillboardGui", espFolder)
                        bb.Adornee = root
                        bb.Size = UDim2.new(0, 100, 0, 30)
                        bb.AlwaysOnTop = true

                        local txt = Instance.new("TextLabel", bb)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🧟 " .. model.Name
                        txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                        txt.TextSize = 12
                        txt.Font = Enum.Font.SourceSansBold
                    end
                end
            end
        end)
    end
end)

-- 6. Fullbright (Нічне бачення)
local Light = game:GetService("Lighting")
createToggle("💡 Fullbright (Night Vision)", function(active)
    if active then
        Light.Ambient = Color3.fromRGB(255, 255, 255)
        Light.Brightness = 2
    else
        Light.Ambient = Color3.fromRGB(128, 128, 128)
        Light.Brightness = 1
    end
end)

---------------------------------------------------------
-- ⚡ 5. Рух та Фізика
---------------------------------------------------------

-- 7. Speed Boost
createToggle("⚡ Speed Boost", function(active)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = active and 40 or 16
    end
end)

-- 8. Noclip (Прохід крізь стіни)
local noclipConn = nil
createToggle("🚪 Noclip", function(active)
    if active then
        noclipConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end)

-- 9. Infinite Jump
local infJumpConn = nil
createToggle("🦘 Infinite Jump", function(active)
    if active then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        if infJumpConn then infJumpConn:Disconnect() end
    end
end)

-- Плаваюча кнопка відкриття/закриття
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
ToggleBtn.Text = "🚂"
ToggleBtn.TextSize = 20
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 21)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 170, 0)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
