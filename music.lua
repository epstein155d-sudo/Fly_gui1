-- Music Player GUI (Mobile Compatible)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Видаляємо старий GUI, якщо він вже є
if CoreGui:FindFirstChild("MusicPlayerGUI") then
    CoreGui.MusicPlayerGUI:Destroy()
end

-- Створюємо новий Sound об'єкт для програвання
local sound = Instance.new("Sound")
sound.Name = "CustomMusicPlayer"
sound.Parent = workspace
sound.Volume = 1
sound.Looped = true

-- Створення інтерфейсу
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MusicPlayerGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(138, 43, 226) -- Фіолетова рамка
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🎵 Music Player"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Поле для введення ID
local IdBox = Instance.new("TextBox")
IdBox.Size = UDim2.new(0.9, 0, 0, 35)
IdBox.Position = UDim2.new(0.05, 0, 0.22, 0)
IdBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
IdBox.Text = ""
IdBox.PlaceholderText = "Вставити Sound ID..."
IdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
IdBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
IdBox.TextSize = 14
IdBox.Font = Enum.Font.SourceSans
IdBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = IdBox

-- Кнопка PLAY
local PlayBtn = Instance.new("TextButton")
PlayBtn.Size = UDim2.new(0.42, 0, 0, 35)
PlayBtn.Position = UDim2.new(0.05, 0, 0.48, 0)
PlayBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
PlayBtn.Text = "▶ Play"
PlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayBtn.TextSize = 16
PlayBtn.Font = Enum.Font.SourceSansBold
PlayBtn.Parent = MainFrame

local PlayCorner = Instance.new("UICorner")
PlayCorner.CornerRadius = UDim.new(0, 6)
PlayCorner.Parent = PlayBtn

-- Кнопка STOP
local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(0.42, 0, 0, 35)
StopBtn.Position = UDim2.new(0.53, 0, 0.48, 0)
StopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StopBtn.Text = "⏹ Stop"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.TextSize = 16
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.Parent = MainFrame

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 6)
StopCorner.Parent = StopBtn

-- Логіка роботи кнопок
PlayBtn.MouseButton1Click:Connect(function()
    local cleanId = IdBox.Text:gsub("%D", "") -- залишаємо тільки цифри
    if cleanId ~= "" then
        sound.SoundId = "rbxassetid://" .. cleanId
        sound:Play()
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    sound:Stop()
end)

-- Кнопка згортання/розгортання (Toggle Button)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ToggleBtn.Text = "🎵"
ToggleBtn.TextSize = 22
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 22)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(138, 43, 226)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
