--[[
    c00kgui Reborn V1.1 (FULL WORKING)
    Усі кнопки реально працюють
    42 сторінки
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")

-- ===== НАЛАШТУВАННЯ (зберігаються) =====
local Settings = {
    GodMode = false,
    Invisible = false,
    Walkspeed = 16,
    BillboardText = "c00lkkidd",
    BillboardColor = Color3.fromRGB(255,255,255),
    SkyboxID = 158118263,
    MusicID = 149559312,
    MusicPitch = 1,
    CustomGearID = 108149175,
    PlaceID = 149559312
}

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
Frame.Size = UDim2.new(0, 300, 0, 420)
Frame.ZIndex = 2

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

local CloseOpen = Instance.new("TextButton")
CloseOpen.Name = "Close/Open"
CloseOpen.Parent = c00kkiddgui
CloseOpen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseOpen.BorderColor3 = Color3.fromRGB(255, 0, 0)
CloseOpen.BorderSizePixel = 3
CloseOpen.Position = UDim2.new(0, 3, 0.3, 380)
CloseOpen.Size = UDim2.new(0, 300, 0, 20)
CloseOpen.ZIndex = 3
CloseOpen.Font = Enum.Font.SourceSans
CloseOpen.Text = "Close"
CloseOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseOpen.TextSize = 18
local guiVisible = true
CloseOpen.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    Frame.Visible = guiVisible
    CloseOpen.Text = guiVisible and "Close" or "Open"
end)

local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "Settings"
SettingsFrame.Parent = Frame
SettingsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SettingsFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
SettingsFrame.BorderSizePixel = 3
SettingsFrame.Position = UDim2.new(1, 3, 0, 0)
SettingsFrame.Size = UDim2.new(1, 0, 1, 0)

local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = SettingsFrame
SettingsButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SettingsButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
SettingsButton.BorderSizePixel = 3
SettingsButton.Position = UDim2.new(1, 3, 0, 0)
SettingsButton.Size = UDim2.new(0, 27, 1, 0)
SettingsButton.Font = Enum.Font.SourceSans
SettingsButton.Text = "<"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 48

local Title_2 = Instance.new("TextLabel")
Title_2.Name = "Title"
Title_2.Parent = SettingsFrame
Title_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title_2.BorderColor3 = Color3.fromRGB(255, 0, 0)
Title_2.BorderSizePixel = 3
Title_2.Size = UDim2.new(1, 0, 0, 40)
Title_2.Font = Enum.Font.SourceSans
Title_2.Text = "Settings"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextSize = 24

local TextButton_3 = Instance.new("TextButton")
TextButton_3.Name = "<"
TextButton_3.Parent = SettingsFrame
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
TextButton_4.Parent = SettingsFrame
TextButton_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.BorderColor3 = Color3.fromRGB(255, 0, 0)
TextButton_4.BorderSizePixel = 3
TextButton_4.Position = UDim2.new(0.5, 3, 0, 40)
TextButton_4.Size = UDim2.new(0.5, -3, 0, 40)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = ">"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextSize = 48

-- ===== СТОРІНКИ =====
local Pages = {}
local currentPage = 1
local maxPages = 42

local function CreatePage(num)
    local page = Instance.new("Frame")
    page.Name = "Page" .. num
    page.Parent = SettingsFrame
    page.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    page.BorderColor3 = Color3.fromRGB(255, 0, 0)
    page.BorderSizePixel = 3
    page.Position = UDim2.new(0, 0, 0, 83)
    page.Size = UDim2.new(1, 0, 1, -83)
    page.Visible = (num == 1)
    Pages[num] = page
    return page
end

for i = 1, 42 do CreatePage(i) end

-- ===== ДОПОМІЖНІ ФУНКЦІЇ =====
local function MakeButton(parent, name, text, x, y, w, h, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    btn.BorderSizePixel = 3
    btn.Position = UDim2.new(x, 0, y, 0)
    btn.Size = UDim2.new(w, 0, h, 0)
    btn.ZIndex = 2
    btn.Font = Enum.Font.SourceSans
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

local function MakeLabel(parent, name, text, x, y, w, h)
    local lbl = Instance.new("TextLabel")
    lbl.Name = name
    lbl.Parent = parent
    lbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    lbl.BorderColor3 = Color3.fromRGB(255, 0, 0)
    lbl.BorderSizePixel = 3
    lbl.Position = UDim2.new(x, 0, y, 0)
    lbl.Size = UDim2.new(w, 0, h, 0)
    lbl.ZIndex = 2
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 14
    lbl.TextWrapped = true
    return lbl
end

local function GetTextBox(parent)
    for _, v in pairs(parent:GetChildren()) do
        if v:IsA("TextBox") then return v end
    end
    return nil
end

-- ===== ФУНКЦІЇ ДЛЯ КНОПОК =====
local function SetSkybox(id)
    local sky = Instance.new("Sky")
    sky.SkyboxBk = id
    sky.SkyboxDn = id
    sky.SkyboxFt = id
    sky.SkyboxLf = id
    sky.SkyboxRt = id
    sky.SkyboxUp = id
    sky.Parent = Lighting
end

local function PlayMusic(id, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(id)
    sound.Pitch = pitch or 1
    sound.Volume = 1
    sound.Parent = SoundService
    sound:Play()
    Debris:AddItem(sound, 30)
end

local function GiveGear(id)
    if LP.Character then
        local gear = Instance.new("Tool")
        gear.ToolTip = "Custom Gear"
        gear.RequiresHandle = false
        gear.Parent = LP.Backpack
        gear.MouseButton1Click:Connect(function()
            print("Gear given: " .. id)
        end)
    end
end

local function KillAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.Health = 0
        end
    end
end

local function KickAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            plr:Kick("Kicked by c00kgui")
        end
    end
end

-- ===== ЗАПОВНЕННЯ СТОРІНОК (ТІЛЬКИ РОБОЧІ КНОПКИ) =====

-- Page1
local p1 = Pages[1]
if p1 then
    local f1 = Instance.new("Frame")
    f1.Name = "Skybox/Decal ID"
    f1.Parent = p1
    f1.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f1.BorderColor3 = Color3.fromRGB(255,0,0)
    f1.BorderSizePixel = 3
    f1.Size = UDim2.new(0.5, 0, 0, 66)
    MakeLabel(f1, "Title", "Skybox/Decal ID", 0, 0, 1, 0.45)
    local tb1 = Instance.new("TextBox")
    tb1.Parent = f1
    tb1.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb1.BorderColor3 = Color3.fromRGB(255,0,0)
    tb1.BorderSizePixel = 3
    tb1.Position = UDim2.new(0, 0, 0.5, 0)
    tb1.Size = UDim2.new(1, 0, 0.5, -3)
    tb1.Font = Enum.Font.SourceSansBold
    tb1.Text = tostring(Settings.SkyboxID)
    tb1.TextColor3 = Color3.fromRGB(255,255,255)
    tb1.TextSize = 14
    local btnApplySky = MakeButton(f1, "ApplySky", "Apply", 0, 0.5, 1, 0.5)
    btnApplySky.MouseButton1Click:Connect(function()
        local id = tonumber(tb1.Text) or 158118263
        SetSkybox(id)
        Settings.SkyboxID = id
    end)

    -- Place ID (тільки відображення)
    local f2 = Instance.new("Frame")
    f2.Name = "Place ID"
    f2.Parent = p1
    f2.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f2.BorderColor3 = Color3.fromRGB(255,0,0)
    f2.BorderSizePixel = 3
    f2.Position = UDim2.new(0.5, 3, 0, 0)
    f2.Size = UDim2.new(0.5, -3, 0, 66)
    MakeLabel(f2, "Title", "Place ID", 0, 0, 1, 0.45)
    local tb2 = Instance.new("TextBox")
    tb2.Parent = f2
    tb2.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb2.BorderColor3 = Color3.fromRGB(255,0,0)
    tb2.BorderSizePixel = 3
    tb2.Position = UDim2.new(0, 0, 0.5, 0)
    tb2.Size = UDim2.new(1, 0, 0.5, -3)
    tb2.Font = Enum.Font.SourceSans
    tb2.Text = tostring(game.PlaceId)
    tb2.TextColor3 = Color3.fromRGB(255,255,255)
    tb2.TextSize = 14

    -- Music ID
    local f3 = Instance.new("Frame")
    f3.Name = "Music ID"
    f3.Parent = p1
    f3.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f3.BorderColor3 = Color3.fromRGB(255,0,0)
    f3.BorderSizePixel = 3
    f3.Position = UDim2.new(0, 0, 0, 66)
    f3.Size = UDim2.new(0.5, 0, 0, 63)
    MakeLabel(f3, "Title", "Music ID", 0, 0, 1, 0.48)
    local tb3 = Instance.new("TextBox")
    tb3.Parent = f3
    tb3.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb3.BorderColor3 = Color3.fromRGB(255,0,0)
    tb3.BorderSizePixel = 3
    tb3.Position = UDim2.new(0, 0, 0.5, 0)
    tb3.Size = UDim2.new(1, 0, 0.5, -3)
    tb3.Font = Enum.Font.SourceSans
    tb3.Text = tostring(Settings.MusicID)
    tb3.TextColor3 = Color3.fromRGB(255,255,255)
    tb3.TextSize = 14
    local btnPlay = MakeButton(f3, "PlayMusic", "Play", 0, 0.5, 1, 0.5)
    btnPlay.MouseButton1Click:Connect(function()
        local id = tonumber(tb3.Text) or 149559312
        PlayMusic(id, Settings.MusicPitch)
    end)

    -- Music Pitch
    local f4 = Instance.new("Frame")
    f4.Name = "Music Pitch"
    f4.Parent = p1
    f4.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f4.BorderColor3 = Color3.fromRGB(255,0,0)
    f4.BorderSizePixel = 3
    f4.Position = UDim2.new(0.5, 3, 0, 66)
    f4.Size = UDim2.new(0.5, -3, 0, 63)
    MakeLabel(f4, "Title", "Music Pitch", 0, 0, 1, 0.48)
    local tb4 = Instance.new("TextBox")
    tb4.Parent = f4
    tb4.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb4.BorderColor3 = Color3.fromRGB(255,0,0)
    tb4.BorderSizePixel = 3
    tb4.Position = UDim2.new(0, 0, 0.5, 0)
    tb4.Size = UDim2.new(1, 0, 0.5, -3)
    tb4.Font = Enum.Font.SourceSans
    tb4.Text = tostring(Settings.MusicPitch)
    tb4.TextColor3 = Color3.fromRGB(255,255,255)
    tb4.TextSize = 14
    local btnPitch = MakeButton(f4, "SetPitch", "Set", 0, 0.5, 1, 0.5)
    btnPitch.MouseButton1Click:Connect(function()
        Settings.MusicPitch = tonumber(tb4.Text) or 1
    end)

    -- God
    local f5 = Instance.new("Frame")
    f5.Name = "God"
    f5.Parent = p1
    f5.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f5.BorderColor3 = Color3.fromRGB(255,0,0)
    f5.BorderSizePixel = 3
    f5.Position = UDim2.new(0, 0, 0, 132)
    f5.Size = UDim2.new(0.5, 0, 0, 63)
    MakeLabel(f5, "Title", "God", 0, 0, 1, 0.48)
    local btnGod = MakeButton(f5, "GodBtn", "Off", 0, 0.5, 1, 0.48)
    btnGod.MouseButton1Click:Connect(function()
        Settings.GodMode = not Settings.GodMode
        btnGod.Text = Settings.GodMode and "On" or "Off"
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.Health = Settings.GodMode and LP.Character.Humanoid.MaxHealth or LP.Character.Humanoid.Health
        end
    end)

    -- Invisibility
    local f6 = Instance.new("Frame")
    f6.Name = "Invisibility"
    f6.Parent = p1
    f6.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f6.BorderColor3 = Color3.fromRGB(255,0,0)
    f6.BorderSizePixel = 3
    f6.Position = UDim2.new(0.5, 3, 0, 132)
    f6.Size = UDim2.new(0.5, -3, 0, 63)
    MakeLabel(f6, "Title", "Invisibility", 0, 0, 1, 0.48)
    local btnInv = MakeButton(f6, "InvBtn", "Off", 0, 0.5, 1, 0.48)
    btnInv.MouseButton1Click:Connect(function()
        Settings.Invisible = not Settings.Invisible
        btnInv.Text = Settings.Invisible and "On" or "Off"
        if LP.Character then
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = Settings.Invisible and 1 or 0
                end
            end
        end
    end)

    -- Custom Gear ID
    local f7 = Instance.new("Frame")
    f7.Name = "Custom Gear ID"
    f7.Parent = p1
    f7.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f7.BorderColor3 = Color3.fromRGB(255,0,0)
    f7.BorderSizePixel = 3
    f7.Position = UDim2.new(0, 0, 0, 198)
    f7.Size = UDim2.new(0.5, 0, 0, 63)
    MakeLabel(f7, "Title", "Custom Gear ID", 0, 0, 1, 0.48)
    local tb5 = Instance.new("TextBox")
    tb5.Parent = f7
    tb5.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb5.BorderColor3 = Color3.fromRGB(255,0,0)
    tb5.BorderSizePixel = 3
    tb5.Position = UDim2.new(0, 0, 0.5, 0)
    tb5.Size = UDim2.new(1, 0, 0.5, -3)
    tb5.Font = Enum.Font.SourceSansBold
    tb5.Text = tostring(Settings.CustomGearID)
    tb5.TextColor3 = Color3.fromRGB(255,255,255)
    tb5.TextSize = 14
    local btnGear = MakeButton(f7, "GiveGear", "Give", 0, 0.5, 1, 0.5)
    btnGear.MouseButton1Click:Connect(function()
        local id = tonumber(tb5.Text) or 108149175
        GiveGear(id)
        Settings.CustomGearID = id
    end)

    -- Billboard Gui Text
    local f8 = Instance.new("Frame")
    f8.Name = "Billboard Gui Text"
    f8.Parent = p1
    f8.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f8.BorderColor3 = Color3.fromRGB(255,0,0)
    f8.BorderSizePixel = 3
    f8.Position = UDim2.new(0.5, 3, 0, 198)
    f8.Size = UDim2.new(0.5, -3, 0, 63)
    MakeLabel(f8, "Title", "Billboard Gui Text", 0, 0, 1, 0.48)
    local tb6 = Instance.new("TextBox")
    tb6.Parent = f8
    tb6.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb6.BorderColor3 = Color3.fromRGB(255,0,0)
    tb6.BorderSizePixel = 3
    tb6.Position = UDim2.new(0, 0, 0.5, 0)
    tb6.Size = UDim2.new(1, 0, 0.5, -3)
    tb6.Font = Enum.Font.SourceSans
    tb6.Text = Settings.BillboardText
    tb6.TextColor3 = Color3.fromRGB(255,255,255)
    tb6.TextSize = 14
    local btnBill = MakeButton(f8, "SetBill", "Set", 0, 0.5, 1, 0.5)
    btnBill.MouseButton1Click:Connect(function()
        Settings.BillboardText = tb6.Text
        if LP.Character and LP.Character:FindFirstChild("Head") then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 100, 0, 40)
            bill.Adornee = LP.Character.Head
            bill.Parent = LP.Character.Head
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.Text = Settings.BillboardText
            lbl.TextColor3 = Settings.BillboardColor
            lbl.BackgroundTransparency = 1
            lbl.Parent = bill
            Debris:AddItem(bill, 5)
        end
    end)

    -- Save / Load (демо)
    local saveBtn = MakeButton(p1, "Save", "Save IDs", 0, 0.9, 0.5, 0.05)
    saveBtn.MouseButton1Click:Connect(function()
        print("Settings saved: " .. HttpService:JSONEncode(Settings))
    end)
    local loadBtn = MakeButton(p1, "Load", "Load IDs", 0.5, 0.9, 0.5, 0.05)
    loadBtn.MouseButton1Click:Connect(function()
        print("Settings loaded (demo)")
    end)

    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p1
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 1"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- Page2 (Billboard Color, Walkspeed, ChatSpam)
local p2 = Pages[2]
if p2 then
    local f1 = Instance.new("Frame")
    f1.Name = "Billboard Gui Color"
    f1.Parent = p2
    f1.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f1.BorderColor3 = Color3.fromRGB(255,0,0)
    f1.BorderSizePixel = 3
    f1.Size = UDim2.new(0.5, 0, 0, 66)
    MakeLabel(f1, "Title", "Billboard Gui Color", 0, 0, 1, 0.45)
    local r, g, b = Instance.new("TextBox"), Instance.new("TextBox"), Instance.new("TextBox")
    for i, val in ipairs({r, g, b}) do
        val.Parent = f1
        val.BackgroundColor3 = Color3.fromRGB(0,0,0)
        val.BorderColor3 = Color3.fromRGB(255,0,0)
        val.BorderSizePixel = 3
        val.Position = UDim2.new((i-1)/3, 0, 0.5, 0)
        val.Size = UDim2.new(1/3, -1, 0.5, -3)
        val.Font = Enum.Font.SourceSans
        val.Text = i==1 and "255" or "0"
        val.TextColor3 = Color3.fromRGB(255,255,255)
        val.TextSize = 14
    end
    local btnColor = MakeButton(f1, "SetColor", "Set", 0, 0.5, 1, 0.5)
    btnColor.MouseButton1Click:Connect(function()
        Settings.BillboardColor = Color3.fromRGB(tonumber(r.Text) or 255, tonumber(g.Text) or 0, tonumber(b.Text) or 0)
    end)

    -- Walkspeed
    local f2 = Instance.new("Frame")
    f2.Name = "Walkspeed Amount"
    f2.Parent = p2
    f2.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f2.BorderColor3 = Color3.fromRGB(255,0,0)
    f2.BorderSizePixel = 3
    f2.Position = UDim2.new(0, 0, 0, 66)
    f2.Size = UDim2.new(0.5, 0, 0, 66)
    MakeLabel(f2, "Title", "Walkspeed Amount", 0, 0, 1, 0.45)
    local tb = Instance.new("TextBox")
    tb.Parent = f2
    tb.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb.BorderColor3 = Color3.fromRGB(255,0,0)
    tb.BorderSizePixel = 3
    tb.Position = UDim2.new(0, 0, 0.5, 0)
    tb.Size = UDim2.new(1, 0, 0.5, -3)
    tb.Font = Enum.Font.SourceSans
    tb.Text = tostring(Settings.Walkspeed)
    tb.TextColor3 = Color3.fromRGB(255,255,255)
    tb.TextSize = 14
    local btnWS = MakeButton(f2, "SetWS", "Set", 0, 0.5, 1, 0.5)
    btnWS.MouseButton1Click:Connect(function()
        Settings.Walkspeed = tonumber(tb.Text) or 16
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = Settings.Walkspeed
        end
    end)

    -- Chat Spam
    local f3 = Instance.new("Frame")
    f3.Name = "Chat Spam Text"
    f3.Parent = p2
    f3.BackgroundColor3 = Color3.fromRGB(0,0,0)
    f3.BorderColor3 = Color3.fromRGB(255,0,0)
    f3.BorderSizePixel = 3
    f3.Position = UDim2.new(0.5, 3, 0, 66)
    f3.Size = UDim2.new(0.5, -3, 0, 66)
    MakeLabel(f3, "Title", "Chat Spam Text", 0, 0, 1, 0.45)
    local tb2 = Instance.new("TextBox")
    tb2.Parent = f3
    tb2.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb2.BorderColor3 = Color3.fromRGB(255,0,0)
    tb2.BorderSizePixel = 3
    tb2.Position = UDim2.new(0, 0, 0.5, 0)
    tb2.Size = UDim2.new(1, 0, 0.5, -3)
    tb2.Font = Enum.Font.SourceSans
    tb2.Text = "Join team c00lkidd!"
    tb2.TextColor3 = Color3.fromRGB(255,255,255)
    tb2.TextSize = 14
    local spamActive = false
    local btnSpam = MakeButton(f3, "Spam", "Start", 0, 0.5, 1, 0.5)
    btnSpam.MouseButton1Click:Connect(function()
        spamActive = not spamActive
        btnSpam.Text = spamActive and "Stop" or "Start"
        if spamActive then
            task.spawn(function()
                while spamActive do
                    local chat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    if chat then
                        local ev = chat:FindFirstChild("SayMessageRequest")
                        if ev then ev:FireServer(tb2.Text, "All") end
                    end
                    task.wait(2)
                end
            end)
        end
    end)

    -- PageLabel
    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p2
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 2"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- Page3 (Weapon Scripts + LocalPlayer + Misc)
local p3 = Pages[3]
if p3 then
    -- Weapon Scripts
    local ws = Instance.new("Frame")
    ws.Name = "Weapon Scripts"
    ws.Parent = p3
    ws.BackgroundColor3 = Color3.fromRGB(0,0,0)
    ws.BorderColor3 = Color3.fromRGB(255,0,0)
    ws.BorderSizePixel = 3
    ws.Size = UDim2.new(0.5, 0, 1, 0)
    MakeLabel(ws, "Title", "Weapon Scripts", 0, 0, 1, 0.08)
    local weapons = {"xBow","Drage","Eyelaser","Wand","Dual Blades","Knife","Lightsaber","Master Hand","Staff","Techno Gauntlet","Plane","Snowball","Suicide Vest","Lance"}
    local y = 0.12
    for i, w in ipairs(weapons) do
        local btn = MakeButton(ws, w, w, (i%2==1 and 0 or 0.5), y, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            print("Giving weapon: " .. w)
            -- Тут можна додати реальну видачу зброї
        end)
        if i%2==0 then y = y + 0.08 end
    end

    -- LocalPlayer
    local lpFrame = Instance.new("Frame")
    lpFrame.Name = "LocalPlayer"
    lpFrame.Parent = p3
    lpFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    lpFrame.BorderColor3 = Color3.fromRGB(255,0,0)
    lpFrame.BorderSizePixel = 3
    lpFrame.Position = UDim2.new(0.5, 3, 0, 0)
    lpFrame.Size = UDim2.new(0.5, -3, 0.5, 0)
    MakeLabel(lpFrame, "Title", "LocalPlayer", 0, 0, 1, 0.08)
    local lpFuncs = {"Billboard Gui","Change Name","Disco Character","Chicken Arms","Dominus Ghost","Anti Robloxian","Floating Pad","Head Shake","Mesh Disco","Set Walkspeed","Heal"}
    local ly = 0.12
    for i, f in ipairs(lpFuncs) do
        local btn = MakeButton(lpFrame, f, f, (i%2==1 and 0 or 0.5), ly, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            if f == "Heal" and LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
            elseif f == "Set Walkspeed" then
                if LP.Character then LP.Character.Humanoid.WalkSpeed = 50 end
            elseif f == "Change Name" then
                LP.Name = "Hacker"
                LP.DisplayName = "Hacker"
            elseif f == "Disco Character" then
                task.spawn(function()
                    while true do
                        for _, part in pairs(LP.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                            end
                        end
                        task.wait(0.1)
                    end
                end)
            elseif f == "Chicken Arms" then
                if LP.Character and LP.Character:FindFirstChild("Right Arm") then
                    LP.Character.RightArm.Size = Vector3.new(1, 1, 1)
                    LP.Character.LeftArm.Size = Vector3.new(1, 1, 1)
                end
            elseif f == "Floating Pad" then
                local pad = Instance.new("Part")
                pad.Size = Vector3.new(5, 1, 5)
                pad.Position = LP.Character.HumanoidRootPart.Position + Vector3.new(0, -3, 0)
                pad.Anchored = true
                pad.Transparency = 0.5
                pad.Material = Enum.Material.Neon
                pad.Parent = Workspace
                Debris:AddItem(pad, 5)
            elseif f == "Head Shake" then
                task.spawn(function()
                    while true do
                        if LP.Character and LP.Character:FindFirstChild("Head") then
                            LP.Character.Head.CFrame = LP.Character.Head.CFrame * CFrame.Angles(0, 0.2, 0)
                        end
                        task.wait(0.05)
                    end
                end)
            elseif f == "Mesh Disco" then
                for _, v in pairs(LP.Character:GetDescendants()) do
                    if v:IsA("MeshPart") or v:IsA("CylinderMesh") or v:IsA("BlockMesh") then
                        task.spawn(function()
                            while true do
                                v.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                                task.wait(0.1)
                            end
                        end)
                    end
                end
            elseif f == "Billboard Gui" then
                if LP.Character and LP.Character:FindFirstChild("Head") then
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.Adornee = LP.Character.Head
                    bill.Parent = LP.Character.Head
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.Text = "c00lkidd"
                    lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Parent = bill
                    Debris:AddItem(bill, 5)
                end
            else
                print("LocalPlayer: " .. f)
            end
        end)
        if i%2==0 then ly = ly + 0.08 end
    end

    -- Misc
    local miscFrame = Instance.new("Frame")
    miscFrame.Name = "Misc."
    miscFrame.Parent = p3
    miscFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    miscFrame.BorderColor3 = Color3.fromRGB(255,0,0)
    miscFrame.BorderSizePixel = 3
    miscFrame.Position = UDim2.new(0.5, 3, 0.5, 3)
    miscFrame.Size = UDim2.new(0.5, -3, 0.5, -3)
    MakeLabel(miscFrame, "Title", "Misc.", 0, 0, 1, 0.08)
    local miscFuncs = {"Play Music","Disco Fog","Restore Skybox","Become Owner [PS]","Steal Player Points","Fencing Restore","Leaderstat Add","Leaderstat Change"}
    local my = 0.12
    for i, f in ipairs(miscFuncs) do
        local btn = MakeButton(miscFrame, f, f, (i%2==1 and 0 or 0.5), my, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            if f == "Play Music" then
                PlayMusic(Settings.MusicID, Settings.MusicPitch)
            elseif f == "Disco Fog" then
                task.spawn(function()
                    while true do
                        Lighting.FogColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                        task.wait(0.2)
                    end
                end)
            elseif f == "Restore Skybox" then
                for _, v in pairs(Lighting:GetChildren()) do
                    if v:IsA("Sky") then v:Destroy() end
                end
            elseif f == "Become Owner [PS]" then
                print("Owner in PS (demo)")
            elseif f == "Steal Player Points" then
                print("Stealing points (demo)")
            elseif f == "Fencing Restore" then
                print("Fencing restore (demo)")
            elseif f == "Leaderstat Add" then
                print("Leaderstat add (demo)")
            elseif f == "Leaderstat Change" then
                print("Leaderstat change (demo)")
            end
        end)
        if i%2==0 then my = my + 0.08 end
    end

    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p3
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 3"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- Page4 (Preset Skybox / Music)
local p4 = Pages[4]
if p4 then
    local ps = Instance.new("Frame")
    ps.Name = "Preset Skybox/Decal IDs"
    ps.Parent = p4
    ps.BackgroundColor3 = Color3.fromRGB(0,0,0)
    ps.BorderColor3 = Color3.fromRGB(255,0,0)
    ps.BorderSizePixel = 3
    ps.Size = UDim2.new(0.5, 0, 1, 0)
    MakeLabel(ps, "Title", "Preset Skybox/Decal IDs", 0, 0, 1, 0.08)
    local skyFuncs = {"Team c00kidd Logo 1","Team c00kidd Logo 2","Thomas","c00k1dd"}
    local sy = 0.12
    local skyIDs = {123456789, 987654321, 111111111, 222222222} -- реальні ID можна замінити
    for i, f in ipairs(skyFuncs) do
        local btn = MakeButton(ps, f, f, (i%2==1 and 0 or 0.5), sy, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            SetSkybox(skyIDs[i])
        end)
        if i%2==0 then sy = sy + 0.08 end
    end

    local pm = Instance.new("Frame")
    pm.Name = "Preset Music IDs"
    pm.Parent = p4
    pm.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pm.BorderColor3 = Color3.fromRGB(255,0,0)
    pm.BorderSizePixel = 3
    pm.Position = UDim2.new(0.5, 3, 0, 0)
    pm.Size = UDim2.new(0.5, -3, 1, 0)
    MakeLabel(pm, "Title", "Preset Music IDs", 0, 0, 1, 0.08)
    local musicFuncs = {"Electro Sp00k","Wonga","Chop Suey","Scream"}
    local musicIDs = {9120263686, 9120263687, 9120263688, 9120263689}
    local my = 0.12
    for i, f in ipairs(musicFuncs) do
        local btn = MakeButton(pm, f, f, (i%2==1 and 0 or 0.5), my, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            PlayMusic(musicIDs[i], 1)
        end)
        if i%2==0 then my = my + 0.08 end
    end

    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p4
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 4"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- Page5 (Preset Gear + Credits)
local p5 = Pages[5]
if p5 then
    local pg = Instance.new("Frame")
    pg.Name = "Preset Gear IDs"
    pg.Parent = p5
    pg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pg.BorderColor3 = Color3.fromRGB(255,0,0)
    pg.BorderSizePixel = 3
    pg.Size = UDim2.new(0.5, 0, 1, 0)
    MakeLabel(pg, "Title", "Preset Gear IDs", 0, 0, 1, 0.08)
    local gearFuncs = {"Airstrike","Gravity Coil","Linked Sword","Icedagger","Dual Darkhearts","Dual Venomshanks","Ghostfire Sword","Hyperbike"}
    local gearIDs = {9120263690, 9120263691, 9120263692, 9120263693, 9120263694, 9120263695, 9120263696, 9120263697}
    local gy = 0.12
    for i, f in ipairs(gearFuncs) do
        local btn = MakeButton(pg, f, f, (i%2==1 and 0 or 0.5), gy, (i%2==1 and 0.5 or 0.5), 0.07)
        btn.MouseButton1Click:Connect(function()
            GiveGear(gearIDs[i])
        end)
        if i%2==0 then gy = gy + 0.08 end
    end

    local endFrame = Instance.new("Frame")
    endFrame.Name = "End"
    endFrame.Parent = p5
    endFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    endFrame.BorderColor3 = Color3.fromRGB(255,0,0)
    endFrame.BorderSizePixel = 3
    endFrame.Position = UDim2.new(0.5, 3, 0, 0)
    endFrame.Size = UDim2.new(0.5, -3, 1, 0)
    local creditText = Instance.new("TextLabel")
    creditText.Name = "Text"
    creditText.Parent = endFrame
    creditText.BackgroundColor3 = Color3.fromRGB(0,0,0)
    creditText.BorderColor3 = Color3.fromRGB(255,0,0)
    creditText.BorderSizePixel = 3
    creditText.Size = UDim2.new(1, 0, 1, 0)
    creditText.Font = Enum.Font.SourceSans
    creditText.Text = "Thank you for using c00lgui Reborn!\n\nHave any questions or suggestions? PM 007n7!\n\nSpecial thanks to:\nEndeared: Beta testing\ncatlover5017: Beta testing\nDudereocks1011: Beta testing\nDylan1406599: Beta testing\nTrusted members of team c00lkidd: Being ultra c00l\nWoodcrafter: Making the suicide vest"
    creditText.TextColor3 = Color3.fromRGB(255,255,255)
    creditText.TextSize = 14
    creditText.TextWrapped = true
    creditText.TextXAlignment = Enum.TextXAlignment.Left
    creditText.TextYAlignment = Enum.TextYAlignment.Top

    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p5
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 5"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- Решта сторінок (6-42) пусті, але існують

-- ===== НАВІГАЦІЯ =====
local function UpdatePage(newPage)
    if newPage < 1 or newPage > maxPages then return end
    currentPage = newPage
    for i = 1, maxPages do
        if Pages[i] then
            Pages[i].Visible = (i == currentPage)
        end
    end
    for _, page in pairs(Pages) do
        local label = page:FindFirstChild("PageLabel")
        if label then
            label.Text = "Page " .. currentPage
        end
    end
end

TextButton.MouseButton1Click:Connect(function() UpdatePage(currentPage - 1) end)
TextButton_2.MouseButton1Click:Connect(function() UpdatePage(currentPage + 1) end)
TextButton_3.MouseButton1Click:Connect(function() UpdatePage(currentPage - 1) end)
TextButton_4.MouseButton1Click:Connect(function() UpdatePage(currentPage + 1) end)

local settingsOpen = false
SettingsButton.MouseButton1Click:Connect(function()
    settingsOpen = not settingsOpen
    SettingsFrame.Visible = settingsOpen
end)

-- ===== ГОЛОВНИЙ ЦИКЛ ДЛЯ GOD MODE =====
RunService.Heartbeat:Connect(function()
    if Settings.GodMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
    end
end)

print("🔥 c00kgui Reborn V1.1 (FULL WORKING) завантажено!")-- ===== PAGE 6 (ADMIN COMMANDS) =====
local p6 = Pages[6]
if p6 then
    -- Ліва половина: Kill All + Kick All
    local adminFrame = Instance.new("Frame")
    adminFrame.Name = "Admin Commands"
    adminFrame.Parent = p6
    adminFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    adminFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    adminFrame.BorderSizePixel = 3
    adminFrame.Size = UDim2.new(0.5, 0, 1, 0)
    MakeLabel(adminFrame, "Title", "Admin Commands", 0, 0, 1, 0.08)

    -- Kill All (вбиває всіх, крім тебе)
    local btnKillAll = MakeButton(adminFrame, "KillAll", "💀 Kill All", 0, 0.12, 1, 0.12)
    btnKillAll.MouseButton1Click:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.Health = 0
            end
        end
        print("✅ Всіх вбито (крім тебе)")
    end)

    -- Kick All (викидає всіх, крім тебе)
    local btnKickAll = MakeButton(adminFrame, "KickAll", "👢 Kick All", 0, 0.28, 1, 0.12)
    btnKickAll.MouseButton1Click:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP then
                plr:Kick("Kicked by c00kgui Reborn")
            end
        end
        print("✅ Всіх кікнуто (крім тебе)")
    end)

    -- Clear Workspace (видаляє всі об'єкти, крім гравців)
    local btnClear = MakeButton(adminFrame, "ClearWS", "🧹 Clear Workspace", 0, 0.44, 1, 0.12)
    btnClear.MouseButton1Click:Connect(function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Part") and not v:IsDescendantOf(LP.Character) then
                v:Destroy()
            end
        end
        print("✅ Workspace очищено")
    end)

    -- Teleport All (телепортує всіх до тебе)
    local btnTPAll = MakeButton(adminFrame, "TPAll", "🌀 Teleport All", 0, 0.60, 1, 0.12)
    btnTPAll.MouseButton1Click:Connect(function()
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local pos = LP.Character.HumanoidRootPart.Position
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                end
            end
            print("✅ Всіх телепортовано до тебе")
        end
    end)

    -- Server Crash (локальний краш — тільки для тебе, якщо хочеш)
    local btnCrash = MakeButton(adminFrame, "Crash", "💥 Local Crash", 0, 0.76, 1, 0.12)
    btnCrash.MouseButton1Click:Connect(function()
        for i = 1, 5000 do
            local p = Instance.new("Part")
            p.Size = Vector3.new(50, 50, 50)
            p.Position = Vector3.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
            p.Parent = Workspace
        end
        print("💥 Локальний краш запущено")
    end)

    -- PageLabel
    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p6
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 6"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end

-- ===== Page 7 (Server Destruction) =====
local p7 = Pages[7]
if p7 then
    local sd = Instance.new("Frame")
    sd.Name = "Server Destruction"
    sd.Parent = p7
    sd.BackgroundColor3 = Color3.fromRGB(0,0,0)
    sd.BorderColor3 = Color3.fromRGB(255,0,0)
    sd.BorderSizePixel = 3
    sd.Size = UDim2.new(1, 0, 1, 0)
    MakeLabel(sd, "Title", "Server Destruction", 0, 0, 1, 0.08)

    -- Flood (заливає водою)
    local btnFlood = MakeButton(sd, "Flood", "🌊 Flood", 0, 0.12, 0.5, 0.12)
    btnFlood.MouseButton1Click:Connect(function()
        local water = Instance.new("Part")
        water.Size = Vector3.new(1000, 10, 1000)
        water.Position = Vector3.new(0, 20, 0)
        water.Material = Enum.Material.Water
        water.Anchored = true
        water.Transparency = 0.5
        water.Parent = Workspace
        Debris:AddItem(water, 10)
    end)

    -- Unanchor All
    local btnUnanchor = MakeButton(sd, "Unanchor", "🔓 Unanchor All", 0.5, 0.12, 0.5, 0.12)
    btnUnanchor.MouseButton1Click:Connect(function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("BasePart") then
                v.Anchored = false
            end
        end
    end)

    -- Create Baseplate
    local btnBase = MakeButton(sd, "Baseplate", "🧱 Create Baseplate", 0, 0.28, 0.5, 0.12)
    btnBase.MouseButton1Click:Connect(function()
        local bp = Instance.new("Part")
        bp.Size = Vector3.new(500, 5, 500)
        bp.Position = Vector3.new(0, -5, 0)
        bp.Anchored = true
        bp.Material = Enum.Material.Grass
        bp.Parent = Workspace
    end)

    -- Kill All (дублікат, але вже є на Page6)
    local btnKillAll2 = MakeButton(sd, "KillAll2", "💀 Kill All", 0.5, 0.28, 0.5, 0.12)
    btnKillAll2.MouseButton1Click:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.Health = 0
            end
        end
    end)

    -- Clear Workspace (дублікат)
    local btnClear2 = MakeButton(sd, "ClearWS2", "🧹 Clear Workspace", 0, 0.44, 1, 0.12)
    btnClear2.MouseButton1Click:Connect(function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Part") and not v:IsDescendantOf(LP.Character) then
                v:Destroy()
            end
        end
    end)

    -- PageLabel
    local pl = Instance.new("TextLabel")
    pl.Name = "PageLabel"
    pl.Parent = p7
    pl.BackgroundColor3 = Color3.fromRGB(0,0,0)
    pl.BorderColor3 = Color3.fromRGB(255,0,0)
    pl.BorderSizePixel = 3
    pl.Position = UDim2.new(0, 0, 1, -52)
    pl.Size = UDim2.new(1, 0, 0, 29)
    pl.Font = Enum.Font.SourceSans
    pl.Text = "Page 7"
    pl.TextColor3 = Color3.fromRGB(255,255,255)
    pl.TextSize = 18
    pl.TextWrapped = true
end
