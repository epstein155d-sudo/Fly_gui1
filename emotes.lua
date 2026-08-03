-- R15 Emote Hub (Mobile & Fully Draggable)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("EmoteHubGUI") then
    CoreGui.EmoteHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EmoteHubGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Головна рамка
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 320)
MainFrame.Position = UDim2.new(0.5, -120, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Можна пересувати меню!
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 105, 180) -- Рожевий неоновий контур
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🎭 Emote Hub (R15)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Збережені треки анімацій
local currentTrack = nil

local function playAnimation(animId)
    pcall(function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            if currentTrack then
                currentTrack:Stop()
            end
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. tostring(animId)
            currentTrack = humanoid:LoadAnimation(anim)
            currentTrack:Play()
        end
    end)
end

local function stopAnimation()
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
end

-- Поле ID (для будь-яких 2500+ анімацій)
local IdBox = Instance.new("TextBox")
IdBox.Size = UDim2.new(0.65, 0, 0, 30)
IdBox.Position = UDim2.new(0.05, 0, 0.13, 0)
IdBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
IdBox.PlaceholderText = "Введіть Emote ID..."
IdBox.Text = ""
IdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
IdBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
IdBox.TextSize = 12
IdBox.Font = Enum.Font.SourceSans
IdBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = IdBox

local PlayIdBtn = Instance.new("TextButton")
PlayIdBtn.Size = UDim2.new(0.23, 0, 0, 30)
PlayIdBtn.Position = UDim2.new(0.72, 0, 0.13, 0)
PlayIdBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
PlayIdBtn.Text = "▶ Play"
PlayIdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayIdBtn.TextSize = 12
PlayIdBtn.Font = Enum.Font.SourceSansBold
PlayIdBtn.Parent = MainFrame

local PlayCorner = Instance.new("UICorner")
PlayCorner.CornerRadius = UDim.new(0, 6)
PlayCorner.Parent = PlayIdBtn

PlayIdBtn.MouseButton1Click:Connect(function()
    local cleanId = IdBox.Text:gsub("%D", "")
    if cleanId ~= "" then
        playAnimation(cleanId)
    end
end)

-- Скролл для списку емоцій
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0.9, 0, 0, 180)
ScrollFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 6)
ScrollCorner.Parent = ScrollFrame

-- Функція додавання кнопок в скролл
local function addEmoteButton(name, id)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.96, 0, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = ScrollFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        playAnimation(id)
    end)
end

-- 1. 🔥 Популярні танці
addEmoteButton("🔥 Floss Dance", 10714340543)
addEmoteButton("🕺 Shuffle Dance", 10714392496)
addEmoteButton("💃 Hype Dance", 10714389470)
addEmoteButton("✨ Breakdance", 10214311282)

-- 2. 😂 Тролінг / Смішні
addEmoteButton("😂 Laugh", 10714352288)
addEmoteButton("💀 Play Dead (Притворитися мертвим)", 10714332483)
addEmoteButton("🤷 Confused (Розвести руками)", 10714324503)
addEmoteButton("🛌 Lay Down (Лежати)", 10714378120)

-- 3. ⛔ Кнопка зупинки
local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(0.9, 0, 0, 32)
StopBtn.Position = UDim2.new(0.05, 0, 0.86, 0)
StopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
StopBtn.Text = "⏹ Stop Emote"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.TextSize = 14
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.Parent = MainFrame

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 6)
StopCorner.Parent = StopBtn

StopBtn.MouseButton1Click:Connect(function()
    stopAnimation()
end)

-- 4. Пересувна кнопка відкриття/закриття
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ToggleBtn.Text = "🎭"
ToggleBtn.TextSize = 20
ToggleBtn.Active = true
ToggleBtn.Draggable = true -- Кнопку ТЕЖ можна перетягувати!
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 20)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 105, 180)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
