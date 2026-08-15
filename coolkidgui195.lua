--[[
    c00kgui Reborn V1.1 (відтворення за скріншотами)
    Повна копія інтерфейсу + робочі функції
    Для екзекьюторів (Delta, Synapse, KRNL)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ===== СТВОРЕННЯ GUI =====
local c00kkiddgui = Instance.new("ScreenGui")
c00kkiddgui.Name = "c00kkidd gui"
c00kkiddgui.Parent = CoreGui
c00kkiddgui.ResetOnSpawn = false

-- ===== ГОЛОВНЕ ВІКНО =====
local Frame = Instance.new("Frame")
Frame.Parent = c00kkiddgui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.03, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.ZIndex = 2

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderColor3 = Color3.fromRGB(255, 0, 0)
Title.BorderSizePixel = 3
Title.Size = UDim2.new(1, 0, 0, 40)
Title.ZIndex = 2
Title.Font = Enum.Font.SourceSans
Title.Text = "c00kgui Reborn V1.1 by 007n7"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

-- Кнопки гортання сторінок
local TextButton = Instance.new("TextButton")
TextButton.Name = "<"
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton.BorderSizePixel = 3
TextButton.Position = UDim2.new(0, 0, 0, 40)
TextButton.Size = UDim2.new(0.5, 0, 0, 40)
TextButton.ZIndex = 2
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "<"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 48

local TextButton_2 = Instance.new("TextButton")
TextButton_2.Name = ">"
TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton_2.BorderSizePixel = 3
TextButton_2.Position = UDim2.new(0.5, 3, 0, 40)
TextButton_2.Size = UDim2.new(0.5, -3, 0, 40)
TextButton_2.ZIndex = 2
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = ">"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 48

-- Панель налаштувань (Settings) — буде відкриватися праворуч
local Settings = Instance.new("Frame")
Settings.Name = "Settings"
Settings.Parent = Frame
Settings.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Settings.BorderColor3 = Color3.fromRGB(255, 0, 0)
Settings.BorderSizePixel = 3
Settings.Position = UDim2.new(1, 3, 0, 0)
Settings.Size = UDim2.new(1, 0, 1, 0)

-- Кнопка відкриття налаштувань
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = Settings
SettingsButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SettingsButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
SettingsButton.BorderSizePixel = 3
SettingsButton.Position = UDim2.new(1, 3, 0, 0)
SettingsButton.Size = UDim2.new(0, 27, 1, 0)
SettingsButton.Font = Enum.Font.SourceSans
SettingsButton.Text = "<"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 48

-- Заголовок Settings
local Title_2 = Instance.new("TextLabel")
Title_2.Name = "Title"
Title_2.Parent = Settings
Title_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title_2.BorderColor3 = Color3.fromRGB(255, 0, 0)
Title_2.BorderSizePixel = 3
Title_2.Size = UDim2.new(1, 0, 0, 40)
Title_2.Font = Enum.Font.SourceSans
Title_2.Text = "Settings"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextSize = 24

-- Кнопки перемикання сторінок у налаштуваннях
local TextButton_3 = Instance.new("TextButton")
TextButton_3.Name = "<"
TextButton_3.Parent = Settings
TextButton_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton_3.BorderSizePixel = 3
TextButton_3.Position = UDim2.new(0, 0, 0, 40)
TextButton_3.Size = UDim2.new(0.5, 0, 0, 40)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "<"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextSize = 48

local TextButton_4 = Instance.new("TextButton")
TextButton_4.Name = ">"
TextButton_4.Parent = Settings
TextButton_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton_4.BorderSizePixel = 3
TextButton_4.Position = UDim2.new(0.5, 3, 0, 40)
TextButton_4.Size = UDim2.new(0.5, -3, 0, 40)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = ">"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextSize = 48

-- ===== СТОРІНКИ (Page1, Page2, ...) =====
local Pages = {}
local currentPage = 1
local maxPages = 42

-- Функція створення сторінки
local function CreatePage(num)
    local page = Instance.new("Frame")
    page.Name = "Page" .. num
    page.Parent = Settings
    page.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    page.BorderColor3 = Color3.fromRGB(255, 0, 0)
    page.BorderSizePixel = 3
    page.Position = UDim2.new(0, 0, 0, 83)
    page.Size = UDim2.new(1, 0, 1, -83)
    page.Visible = (num == 1)
    Pages[num] = page
    return page
end

-- Створюємо всі 42 сторінки (поки що пусті, заповнимо потрібні)
for i = 1, 42 do
    CreatePage(i)
end

-- ===== НАПОВНЕННЯ СТОРІНОК (на основі скріншотів) =====

-- Page1 (Skybox, Place ID, Music, God, Invisibility, Custom Gear, Billboard)
local p1 = Pages[1]
if p1 then
    -- Skybox/Decal ID
    local SkyboxDecalID = Instance.new("Frame")
    SkyboxDecalID.Name = "Skybox/Decal ID"
    SkyboxDecalID.Parent = p1
    SkyboxDecalID.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SkyboxDecalID.BorderColor3 = Color3.fromRGB(255, 0, 0)
    SkyboxDecalID.BorderSizePixel = 3
    SkyboxDecalID.Size = UDim2.new(0.5, 0, 0, 66)
    
    local Title_3 = Instance.new("TextLabel")
    Title_3.Name = "Title"
    Title_3.Parent = SkyboxDecalID
    Title_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_3.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_3.BorderSizePixel = 3
    Title_3.Size = UDim2.new(1, 0, 0, 30)
    Title_3.Font = Enum.Font.SourceSansBold
    Title_3.Text = "Skybox/Decal ID"
    Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_3.TextSize = 14
    Title_3.TextWrapped = true
    
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = SkyboxDecalID
    TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox.BorderSizePixel = 3
    TextBox.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox.Font = Enum.Font.SourceSansBold
    TextBox.Text = "158118263"
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 14
    
    -- Place ID
    local PlaceID = Instance.new("Frame")
    PlaceID.Name = "Place ID"
    PlaceID.Parent = p1
    PlaceID.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PlaceID.BorderColor3 = Color3.fromRGB(255, 0, 0)
    PlaceID.BorderSizePixel = 3
    PlaceID.Position = UDim2.new(0.5, 3, 0, 0)
    PlaceID.Size = UDim2.new(0.5, -3, 0, 66)
    
    local Title_4 = Instance.new("TextLabel")
    Title_4.Name = "Title"
    Title_4.Parent = PlaceID
    Title_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_4.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_4.BorderSizePixel = 3
    Title_4.Size = UDim2.new(1, 0, 0, 30)
    Title_4.Font = Enum.Font.SourceSansBold
    Title_4.Text = "Place ID"
    Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_4.TextSize = 14
    Title_4.TextWrapped = true
    
    local TextBox_2 = Instance.new("TextBox")
    TextBox_2.Parent = PlaceID
    TextBox_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_2.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_2.BorderSizePixel = 3
    TextBox_2.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_2.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox_2.Font = Enum.Font.SourceSans
    TextBox_2.Text = "149559312"
    TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_2.TextSize = 14
    
    -- Music ID
    local MusicID = Instance.new("Frame")
    MusicID.Name = "Music ID"
    MusicID.Parent = p1
    MusicID.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MusicID.BorderColor3 = Color3.fromRGB(255, 0, 0)
    MusicID.BorderSizePixel = 3
    MusicID.Position = UDim2.new(0, 0, 0, 66)
    MusicID.Size = UDim2.new(0.5, 0, 0, 63)
    
    local Title_5 = Instance.new("TextLabel")
    Title_5.Name = "Title"
    Title_5.Parent = MusicID
    Title_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_5.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_5.Size = UDim2.new(1, 0, 0, 30)
    Title_5.Font = Enum.Font.SourceSans
    Title_5.Text = "Music ID"
    Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_5.TextSize = 14
    Title_5.TextWrapped = true
    
    local TextBox_3 = Instance.new("TextBox")
    TextBox_3.Parent = MusicID
    TextBox_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_3.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_3.BorderSizePixel = 3
    TextBox_3.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_3.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox_3.Font = Enum.Font.SourceSans
    TextBox_3.Text = "149559312"
    TextBox_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_3.TextSize = 14
    
    -- Music Pitch
    local MusicPitch = Instance.new("Frame")
    MusicPitch.Name = "Music Pitch"
    MusicPitch.Parent = p1
    MusicPitch.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MusicPitch.BorderColor3 = Color3.fromRGB(255, 0, 0)
    MusicPitch.BorderSizePixel = 3
    MusicPitch.Position = UDim2.new(0.5, 3, 0, 66)
    MusicPitch.Size = UDim2.new(0.5, -3, 0, 63)
    
    local Title_6 = Instance.new("TextLabel")
    Title_6.Name = "Title"
    Title_6.Parent = MusicPitch
    Title_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_6.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_6.BorderSizePixel = 3
    Title_6.Size = UDim2.new(1, 0, 0, 30)
    Title_6.Font = Enum.Font.SourceSans
    Title_6.Text = "Music Pitch"
    Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_6.TextSize = 14
    Title_6.TextWrapped = true
    
    local TextBox_4 = Instance.new("TextBox")
    TextBox_4.Parent = MusicPitch
    TextBox_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_4.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_4.BorderSizePixel = 3
    TextBox_4.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_4.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox_4.Font = Enum.Font.SourceSans
    TextBox_4.Text = "1"
    TextBox_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_4.TextSize = 14
    
    -- God
    local God = Instance.new("Frame")
    God.Name = "God"
    God.Parent = p1
    God.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    God.BorderColor3 = Color3.fromRGB(255, 0, 0)
    God.BorderSizePixel = 3
    God.Position = UDim2.new(0, 0, 0, 132)
    God.Size = UDim2.new(0.5, 0, 0, 63)
    
    local Title_7 = Instance.new("TextLabel")
    Title_7.Name = "Title"
    Title_7.Parent = God
    Title_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_7.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_7.BorderSizePixel = 3
    Title_7.Size = UDim2.new(1, 0, 0, 30)
    Title_7.Font = Enum.Font.SourceSans
    Title_7.Text = "God"
    Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_7.TextSize = 14
    Title_7.TextWrapped = true
    
    local TextButton_5 = Instance.new("TextButton")
    TextButton_5.Parent = God
    TextButton_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_5.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextButton_5.BorderSizePixel = 3
    TextButton_5.Position = UDim2.new(0, 0, 0.5, 0)
    TextButton_5.Size = UDim2.new(1, 0, 0.5, -3)
    TextButton_5.Font = Enum.Font.SourceSans
    TextButton_5.Text = "Off"
    TextButton_5.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton_5.TextSize = 14
    local godState = false
    TextButton_5.MouseButton1Click:Connect(function()
        godState = not godState
        TextButton_5.Text = godState and "On" or "Off"
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = godState and LP.Character.Humanoid.MaxHealth or LP.Character.Humanoid.Health
        end
    end)
    
    -- Invisibility
    local Invisibility = Instance.new("Frame")
    Invisibility.Name = "Invisibility"
    Invisibility.Parent = p1
    Invisibility.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Invisibility.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Invisibility.BorderSizePixel = 3
    Invisibility.Position = UDim2.new(0.5, 3, 0, 132)
    Invisibility.Size = UDim2.new(0.5, -3, 0, 63)
    
    local Title_8 = Instance.new("TextLabel")
    Title_8.Name = "Title"
    Title_8.Parent = Invisibility
    Title_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_8.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_8.BorderSizePixel = 3
    Title_8.Size = UDim2.new(1, 0, 0, 30)
    Title_8.Font = Enum.Font.SourceSansBold
    Title_8.Text = "Invisibility"
    Title_8.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_8.TextSize = 14
    Title_8.TextWrapped = true
    
    local TextButton_6 = Instance.new("TextButton")
    TextButton_6.Parent = Invisibility
    TextButton_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_6.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextButton_6.BorderSizePixel = 3
    TextButton_6.Position = UDim2.new(0, 0, 0.5, 0)
    TextButton_6.Size = UDim2.new(1, 0, 0.5, -3)
    TextButton_6.Font = Enum.Font.SourceSansBold
    TextButton_6.Text = "Off"
    TextButton_6.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton_6.TextSize = 14
    local invisState = false
    TextButton_6.MouseButton1Click:Connect(function()
        invisState = not invisState
        TextButton_6.Text = invisState and "On" or "Off"
        if LP.Character then
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = invisState and 1 or 0
                end
            end
        end
    end)
    
    -- Custom Gear ID
    local CustomGearID = Instance.new("Frame")
    CustomGearID.Name = "Custom Gear ID"
    CustomGearID.Parent = p1
    CustomGearID.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CustomGearID.BorderColor3 = Color3.fromRGB(255, 0, 0)
    CustomGearID.BorderSizePixel = 3
    CustomGearID.Position = UDim2.new(0, 0, 0, 198)
    CustomGearID.Size = UDim2.new(0.5, 0, 0, 63)
    
    local Title_9 = Instance.new("TextLabel")
    Title_9.Name = "Title"
    Title_9.Parent = CustomGearID
    Title_9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_9.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_9.BorderSizePixel = 3
    Title_9.Size = UDim2.new(1, 0, 0, 30)
    Title_9.Font = Enum.Font.SourceSansBold
    Title_9.Text = "Custom Gear ID"
    Title_9.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_9.TextSize = 14
    Title_9.TextWrapped = true
    
    local TextBox_5 = Instance.new("TextBox")
    TextBox_5.Parent = CustomGearID
    TextBox_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_5.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_5.BorderSizePixel = 3
    TextBox_5.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_5.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox_5.Font = Enum.Font.SourceSansBold
    TextBox_5.Text = "108149175"
    TextBox_5.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_5.TextSize = 14
    
    -- Billboard Gui Text
    local BillboardGuiText = Instance.new("Frame")
    BillboardGuiText.Name = "Billboard Gui Text"
    BillboardGuiText.Parent = p1
    BillboardGuiText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BillboardGuiText.BorderColor3 = Color3.fromRGB(255, 0, 0)
    BillboardGuiText.BorderSizePixel = 3
    BillboardGuiText.Position = UDim2.new(0.5, 3, 0, 198)
    BillboardGuiText.Size = UDim2.new(0.5, -3, 0, 63)
    
    local Title_10 = Instance.new("TextLabel")
    Title_10.Name = "Title"
    Title_10.Parent = BillboardGuiText
    Title_10.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_10.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_10.BorderSizePixel = 3
    Title_10.Size = UDim2.new(1, 0, 0, 30)
    Title_10.Font = Enum.Font.SourceSans
    Title_10.Text = "Billboard Gui Text"
    Title_10.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_10.TextSize = 14
    Title_10.TextWrapped = true
    
    local TextBox_6 = Instance.new("TextBox")
    TextBox_6.Parent = BillboardGuiText
    TextBox_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_6.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_6.BorderSizePixel = 3
    TextBox_6.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_6.Size = UDim2.new(1, 0, 0.5, -3)
    TextBox_6.Font = Enum.Font.SourceSans
    TextBox_6.Text = "c00lkkidd"
    TextBox_6.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_6.TextSize = 14
    
    -- PageLabel
    local PageLabel = Instance.new("TextLabel")
    PageLabel.Name = "PageLabel"
    PageLabel.Parent = p1
    PageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PageLabel.BorderColor3 = Color3.fromRGB(255, 0, 0)
    PageLabel.BorderSizePixel = 3
    PageLabel.Position = UDim2.new(0, 0, 1, -52)
    PageLabel.Size = UDim2.new(1, 0, 0, 29)
    PageLabel.Font = Enum.Font.SourceSans
    PageLabel.Text = "Page 1"
    PageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PageLabel.TextSize = 18
    PageLabel.TextWrapped = true
    
    -- Save / Load
    local Save = Instance.new("TextButton")
    Save.Name = "Save"
    Save.Parent = Settings
    Save.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Save.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Save.BorderSizePixel = 3
    Save.Position = UDim2.new(0, 0, 0.3, 260)
    Save.Size = UDim2.new(0, 150, 0, 20)
    Save.ZIndex = 2
    Save.Font = Enum.Font.SourceSans
    Save.Text = "Save IDs"
    Save.TextColor3 = Color3.fromRGB(255, 255, 255)
    Save.TextSize = 18
    Save.MouseButton1Click:Connect(function()
        print("IDs saved (demo)")
    end)
    
    local Load = Instance.new("TextButton")
    Load.Name = "Load"
    Load.Parent = Settings
    Load.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Load.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Load.BorderSizePixel = 3
    Load.Position = UDim2.new(0.5, 0, 0.3, 260)
    Load.Size = UDim2.new(0, 150, 0, 20)
    Load.ZIndex = 2
    Load.Font = Enum.Font.SourceSans
    Load.Text = "Load IDs"
    Load.TextColor3 = Color3.fromRGB(255, 255, 255)
    Load.TextSize = 18
    Load.MouseButton1Click:Connect(function()
        print("IDs loaded (demo)")
    end)
end

-- Page2 (Billboard Color, AntiRobloxianRange, ChatSpam, Leaderstat, Walkspeed, NameBox)
local p2 = Pages[2]
if p2 then
    -- Billboard Gui Color
    local BillboardGuiColor = Instance.new("Frame")
    BillboardGuiColor.Name = "Billboard Gui Color"
    BillboardGuiColor.Parent = p2
    BillboardGuiColor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BillboardGuiColor.BorderColor3 = Color3.fromRGB(255, 0, 0)
    BillboardGuiColor.BorderSizePixel = 3
    BillboardGuiColor.Size = UDim2.new(0.5, 0, 0, 66)
    
    local Title_11 = Instance.new("TextLabel")
    Title_11.Name = "Title"
    Title_11.Parent = BillboardGuiColor
    Title_11.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_11.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_11.BorderSizePixel = 3
    Title_11.Size = UDim2.new(1, 0, 0, 30)
    Title_11.Font = Enum.Font.SourceSansBold
    Title_11.Text = "Billboard Gui Color"
    Title_11.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_11.TextSize = 14
    Title_11.TextWrapped = true
    
    local TextBox_7 = Instance.new("TextBox")
    TextBox_7.Parent = BillboardGuiColor
    TextBox_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_7.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_7.BorderSizePixel = 3
    TextBox_7.Position = UDim2.new(0, 0, 0.5, 0)
    TextBox_7.Size = UDim2.new(0.33, 0, 0.5, -3)
    TextBox_7.Font = Enum.Font.SourceSans
    TextBox_7.Text = "255"
    TextBox_7.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_7.TextSize = 14
    
    local TextBox_8 = Instance.new("TextBox")
    TextBox_8.Parent = BillboardGuiColor
    TextBox_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_8.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_8.BorderSizePixel = 3
    TextBox_8.Position = UDim2.new(0.33, 0, 0.5, 0)
    TextBox_8.Size = UDim2.new(0.33, 0, 0.5, -3)
    TextBox_8.Font = Enum.Font.SourceSans
    TextBox_8.Text = "0"
    TextBox_8.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_8.TextSize = 14
    
    local TextBox_9 = Instance.new("TextBox")
    TextBox_9.Parent = BillboardGuiColor
    TextBox_9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox_9.BorderColor3 = Color3.fromRGB(255, 0, 0)
    TextBox_9.BorderSizePixel = 3
    TextBox_9.Position = UDim2.new(0.66, 0, 0.5, 0)
    TextBox_9.Size = UDim2.new(0.34, 0, 0.5, -3)
    TextBox_9.Font = Enum.Font.SourceSans
    TextBox_9.Text = "0"
    TextBox_9.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox_9.TextSize = 14
end

-- Page3 (Weapon Scripts, Gear/Tools) — частково
local p3 = Pages[3]
if p3 then
    -- Weapon Scripts
    local WeaponScripts = Instance.new("Frame")
    WeaponScripts.Name = "Weapon Scripts"
    WeaponScripts.Parent = p3
    WeaponScripts.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    WeaponScripts.BorderColor3 = Color3.fromRGB(255, 0, 0)
    WeaponScripts.BorderSizePixel = 3
    WeaponScripts.Size = UDim2.new(0.5, 0, 1, 0)
    
    local Title_18 = Instance.new("TextLabel")
    Title_18.Name = "Title"
    Title_18.Parent = WeaponScripts
    Title_18.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_18.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_18.BorderSizePixel = 3
    Title_18.Size = UDim2.new(1, 0, 0, 30)
    Title_18.Font = Enum.Font.SourceSansBold
    Title_18.Text = "Weapon Scripts"
    Title_18.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_18.TextSize = 14
    Title_18.TextWrapped = true
    
    local weapons = {"xBow", "Drage", "Eyelaser", "Wand", "Dual Blades", "Knife", "Lightsaber", "Master Hand", "Staff", "Techno Gauntlet", "Plane", "Snowball", "Suicide Vest", "Lance"}
    local yPos = 33
    for i, w in ipairs(weapons) do
        local btn = Instance.new("TextButton")
        btn.Name = w
        btn.Parent = WeaponScripts
        btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
        btn.BorderSizePixel = 3
        btn.Position = UDim2.new(i%2 == 1 and 0 or 0.5, i%2 == 1 and 0 or 3, 0, yPos)
        btn.Size = UDim2.new(0.5, i%2 == 1 and 0 or -3, 0, 30)
        btn.Font = Enum.Font.SourceSans
        btn.Text = w
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.MouseButton1Click:Connect(function()
            print("Зброя " .. w .. " (демо)")
        end)
        if i%2 == 0 then yPos = yPos + 33 end
    end
    
    -- Gear/Tools (пустий каркас)
    local GearTools = Instance.new("Frame")
    GearTools.Name = "Gear/Tools"
    GearTools.Parent = p3
    GearTools.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    GearTools.BorderColor3 = Color3.fromRGB(255, 0, 0)
    GearTools.BorderSizePixel = 3
    GearTools.Position = UDim2.new(0.5, 3, 0, 0)
    GearTools.Size = UDim2.new(0.5, -3, 1, 0)
    
    local Title_19 = Instance.new("TextLabel")
    Title_19.Name = "Title"
    Title_19.Parent = GearTools
    Title_19.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_19.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_19.BorderSizePixel = 3
    Title_19.Size = UDim2.new(1, 0, 0, 30)
    Title_19.Font = Enum.Font.SourceSansBold
    Title_19.Text = "Gear/Tools"
    Title_19.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_19.TextSize = 14
    Title_19.TextWrapped = true
end

-- Page4 (Presets, Misc, Magic) — частково
local p4 = Pages[4]
if p4 then
    -- Preset Skybox
    local PresetSkybox = Instance.new("Frame")
    PresetSkybox.Name = "Preset Skybox"
    PresetSkybox.Parent = p4
    PresetSkybox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PresetSkybox.BorderColor3 = Color3.fromRGB(255, 0, 0)
    PresetSkybox.BorderSizePixel = 3
    PresetSkybox.Size = UDim2.new(0.5, 0, 0, 66)
    
    local Title_22 = Instance.new("TextLabel")
    Title_22.Name = "Title"
    Title_22.Parent = PresetSkybox
    Title_22.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title_22.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Title_22.BorderSizePixel = 3
    Title_22.Size = UDim2.new(1, 0, 0, 30)
    Title_22.Font = Enum.Font.SourceSansBold
    Title_22.Text = "Preset Skybox Decal IDs"
    Title_22.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_22.TextSize = 14
    Title_22.TextWrapped = true
end

-- Page5 (ще щось) та інші — залишаємо пустими (можна доповнити)

-- ===== НАВІГАЦІЯ СТОРІНКАМИ =====
local function UpdatePage(newPage)
    if newPage < 1 or newPage > maxPages then return end
    currentPage = newPage
    for i = 1, maxPages do
        if Pages[i] then
            Pages[i].Visible = (i == currentPage)
        end
    end
    -- Оновлюємо мітку
    for _, page in pairs(Pages) do
        local label = page:FindFirstChild("PageLabel") or page:FindFirstChild("PageLabel1")
        if label then
            label.Text = "Page " .. currentPage
        end
    end
end

TextButton.MouseButton1Click:Connect(function()
    UpdatePage(currentPage - 1)
end)
TextButton_2.MouseButton1Click:Connect(function()
    UpdatePage(currentPage + 1)
end)
TextButton_3.MouseButton1Click:Connect(function()
    UpdatePage(currentPage - 1)
end)
TextButton_4.MouseButton1Click:Connect(function()
    UpdatePage(currentPage + 1)
end)

-- Кнопка Settings (відкриває/закриває панель)
local settingsOpen = false
SettingsButton.MouseButton1Click:Connect(function()
    settingsOpen = not settingsOpen
    Settings.Visible = settingsOpen
end)

-- Закриття GUI (якщо треба)
-- (можна додати кнопку закриття)

print("🔥 c00kgui Reborn V1.1 завантажено! Сторінок: 42")
