-- Ultimate Brookhaven RP Hub (Mobile Friendly & Draggable)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("BrookhavenHubGUI") then
    CoreGui.BrookhavenHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrookhavenHubGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Головне вікно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Position = UDim2.new(0.5, -130, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🏡 Brookhaven Ultimate Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Скролл для кнопок (щоб вмістити всі 12 функцій)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(0.92, 0, 0.86, 0)
Scroll.Position = UDim2.new(0.04, 0, 0.11, 0)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0, 0, 0, 560)
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
            btn.TextColor3 = Color3.fromRGB(50, 255, 100)
            btn.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
        else
            btn.Text = text .. " [OFF]"
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end
        pcall(callback, state)
    end)
    return btn
end

-- Функція звичайних кнопок
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    return btn
end

---------------------------------------------------------
-- 👻 1. Вкладка "Тролінг та Рух"
---------------------------------------------------------

-- 1. Noclip (Прохід крізь стіни та двері)
local noclipConn = nil
createToggle("🚪 Noclip (Walking)", function(active)
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

-- 2. Ghost Mode (Напівпрозорість для лякання)
createToggle("👻 Ghost / Invis Mode", function(active)
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = active and 0.6 or 0
            end
        end
    end
end)

-- 3. Jumpscare Spin (Божевільне обертання для переляку)
local spinConn = nil
createToggle("😱 Scream Jumpscare Spin", function(active)
    if active then
        spinConn = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
            end
        end)
    else
        if spinConn then spinConn:Disconnect() end
    end
end)

-- 4. Infinite Jump
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

-- 5. Speed Boost (Персонаж)
createToggle("⚡ Player Speed Boost", function(active)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = active and 50 or 16
    end
end)

---------------------------------------------------------
-- 🏎️ 2. Вкладка "Машини та Тюнінг"
---------------------------------------------------------

-- Допоміжна функція пошуку машини гравця
local function getVehicle()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local seat = LocalPlayer.Character.Humanoid.SeatPart
        if seat and seat.Parent then
            return seat.Parent
        end
    end
    return nil
end

-- 6. Fly Car (Політ на авто)
local carFlyConn = nil
createToggle("✈️ Fly Car", function(active)
    if active then
        carFlyConn = RunService.RenderStepped:Connect(function()
            local veh = getVehicle()
            if veh and veh:IsA("Model") then
                local primary = veh.PrimaryPart or veh:FindFirstChildWhichIsA("BasePart")
                if primary then
                    local cam = Workspace.CurrentCamera
                    primary.AssemblyLinearVelocity = cam.CFrame.LookVector * 70
                end
            end
        end)
    else
        if carFlyConn then carFlyConn:Disconnect() end
    end
end)

-- 7. Vehicle Speed Boost (Супер-швидкість авто)
local carSpeedConn = nil
createToggle("🚀 Car Speed Boost", function(active)
    if active then
        carSpeedConn = RunService.RenderStepped:Connect(function()
            local veh = getVehicle()
            if veh and veh:IsA("Model") then
                local primary = veh.PrimaryPart or veh:FindFirstChildWhichIsA("BasePart")
                if primary and primary.AssemblyLinearVelocity.Magnitude > 2 then
                    primary.AssemblyLinearVelocity = primary.AssemblyLinearVelocity * 1.3
                end
            end
        end)
    else
        if carSpeedConn then carSpeedConn:Disconnect() end
    end
end)

-- 8. Car No-Clip (Прохід авто крізь стіни)
local carNoclipConn = nil
createToggle("🚙 Car No-Clip", function(active)
    if active then
        carNoclipConn = RunService.Stepped:Connect(function()
            local veh = getVehicle()
            if veh then
                for _, part in pairs(veh:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if carNoclipConn then carNoclipConn:Disconnect() end
    end
end)

-- 9. Auto-Flip Car (Переворот авто на колеса)
createButton("🔄 Auto-Flip Car", function()
    local veh = getVehicle()
    if veh and veh:IsA("Model") then
        local primary = veh.PrimaryPart or veh:FindFirstChildWhichIsA("BasePart")
        if primary then
            veh:SetPrimaryPartCFrame(CFrame.new(primary.Position + Vector3.new(0, 3, 0)) * CFrame.Angles(0, math.rad(primary.Orientation.Y), 0))
        end
    end
end)

---------------------------------------------------------
-- 👁️ 3. Вкладка "Візуали та Телепорти"
---------------------------------------------------------

-- 10. Fullbright (Нічне бачення)
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

-- 11. Player ESP (Підсвічування гравців)
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESP"
createToggle("👁️ Player ESP", function(active)
    espFolder:ClearAllChildren()
    if active then
        task.spawn(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local bb = Instance.new("BillboardGui", espFolder)
                    bb.Adornee = plr.Character.HumanoidRootPart
                    bb.Size = UDim2.new(0, 100, 0, 30)
                    bb.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", bb)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Text = plr.Name
                    txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                    txt.TextSize = 12
                    txt.Font = Enum.Font.SourceSansBold
                end
            end
        end)
    end
end)

-- 12. Teleport Hub (Швидкі телепорти)
createButton("📍 Teleport: Spawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-25, 18, 15)
    end
end)

createButton("🏦 Teleport: Bank", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12, 18, -165)
    end
end)

-- Маленька плаваюча кнопка відкриття/закриття
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.Text = "🏡"
ToggleBtn.TextSize = 18
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 20)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
