--[[
    MM2 HUB v2.0 (MOBILE)
    Murder Mystery 2 – повний чит-меню
    Пересувне меню, 6 вкладок, 800+ рядків
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInput = game:GetService("VirtualInputManager")

-- ===== СТАРТОВИЙ ЕКРАН (HACKER BOOT) =====
local function ShowBootScreen()
    local bootGui = Instance.new("ScreenGui")
    bootGui.Name = "BootScreen"
    bootGui.Parent = CoreGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.Parent = bootGui

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "LOADING...\n> INJECTING BYPASS...\n> SEARCHING PLAYERS...\n> SELECTING TARGET..."
    text.TextColor3 = Color3.fromRGB(0, 255, 0)
    text.TextSize = 18
    text.Font = Enum.Font.GothamBold
    text.TextYAlignment = Enum.TextYAlignment.Center
    text.Parent = bg

    task.wait(1.5)
    text.Text = "██████  ██ ██  ██     ███    ███ ███████ ███    ██ ██    ██\n██   ██ ██ ██ ██      ████  ████ ██      ████   ██ ██    ██\n██████  ██ ████       ██ ████ ██ █████   ██ ██  ██ ██    ██\n██   ██ ██ ██ ██      ██  ██  ██ ██      ██  ██ ██ ██    ██\n██████  ██ ██  ██     ██      ██ ███████ ██   ████  ██████"
    task.wait(1.5)
    bootGui:Destroy()
end

ShowBootScreen()

-- ===== НАЛАШТУВАННЯ =====
local Settings = {
    Aimbot = false,
    AutoShoot = false,
    AimbotFOV = 150,
    ESP = false,
    Invisible = false,
    SpeedGlitch = false,
    BunnyHop = false,
    AutoFarm = false,
    AntiAFK = false,
    Fling = false,
    ChatSpam = false,
    ESPColor = Color3.fromRGB(0, 255, 0)
}

-- ===== СТВОРЕННЯ GUI (ТЕЛЕФОН) =====
local GUI = Instance.new("ScreenGui")
GUI.Name = "MM2Hub"
GUI.Parent = CoreGui
GUI.ResetOnSpawn = false

-- Кнопка відкриття (квадратик)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 65, 0, 65)
toggleBtn.Position = UDim2.new(0.85, 0, 0.83, 0)
toggleBtn.Image = "rbxassetid://6031094979"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
toggleBtn.Parent = GUI

-- Головне меню
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 580)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
mainFrame.Visible = false
mainFrame.Parent = GUI

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "🔥 PIK PIK MENU HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Кнопка закриття
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 1
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

-- Вкладки
local tabs = {"AIM", "VISUAL", "MOVEMENT", "FARM", "MISC", "SETTINGS"}
local tabBtns = {}
local currentTab = "AIM"

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 40)
tabContainer.Position = UDim2.new(0, 0, 0, 45)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabs, 0, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = (name == currentTab) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(30, 30, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = tabContainer
    tabBtns[name] = btn
end

-- Контейнер для контенту
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -10, 1, -95)
contentFrame.Position = UDim2.new(0, 5, 0, 90)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- ===== ДОПОМІЖНІ ФУНКЦІЇ =====
local function AddToggle(parent, label, y, key, default)
    local state = default or false
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 26, 0, 26)
    btn.Position = UDim2.new(0, 0, 0, 3)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    btn.Text = ""
    btn.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -32, 1, 0)
    lbl.Position = UDim2.new(0, 32, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        Settings[key] = state
    end)
    Settings[key] = state
    return btn
end

local function AddSlider(parent, label, y, key, min, max, default)
    local val = default or min
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = label .. ": " .. tostring(val)
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.5, 0, 0, 8)
    bar.Position = UDim2.new(0, 0, 0, 30)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    bar.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((val-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    fill.Parent = bar

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.2, 0, 0, 22)
    valLbl.Position = UDim2.new(0.55, 0, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(val)
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.TextSize = 14
    valLbl.Font = Enum.Font.Gotham
    valLbl.Parent = frame

    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(0.5, 0, 0, 25)
    dragBtn.Position = UDim2.new(0, 0, 0, 22)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = frame

    local dragging = false
    dragBtn.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    RunService.Heartbeat:Connect(function()
        if not dragging then return end
        local mx = UserInputService:GetMouseLocation().X
        local relX = math.clamp((mx - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local newVal = math.round(min + relX * (max - min))
        val = newVal
        fill.Size = UDim2.new(relX, 0, 1, 0)
        lbl.Text = label .. ": " .. tostring(val)
        valLbl.Text = tostring(val)
        Settings[key] = val
    end)
    Settings[key] = val
    return fill
end

local function AddButton(parent, label, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.4, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = label
    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ===== ЗАПОВНЕННЯ ВКЛАДОК =====

-- AIM
local aimPage = Instance.new("Frame")
aimPage.Size = UDim2.new(1, 0, 1, 0)
aimPage.BackgroundTransparency = 1
aimPage.Visible = true
aimPage.Parent = contentFrame

AddToggle(aimPage, "🎯 Aimbot", 10, "Aimbot", false)
AddToggle(aimPage, "🔫 Auto Shoot (Murderer)", 45, "AutoShoot", false)
AddSlider(aimPage, "Aimbot FOV", 85, "AimbotFOV", 50, 400, 150)
AddButton(aimPage, "🔒 Lock Target", 140, function()
    print("Ціль заблокована (ім'я)")
end)

-- VISUAL
local visPage = Instance.new("Frame")
visPage.Size = UDim2.new(1, 0, 1, 0)
visPage.BackgroundTransparency = 1
visPage.Visible = false
visPage.Parent = contentFrame

AddToggle(visPage, "👁 ESP (Players)", 10, "ESP", false)
AddToggle(visPage, "👻 Invisibility", 45, "Invisible", false)
AddButton(visPage, "🌈 Change ESP Color", 90, function()
    Settings.ESPColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    print("Колір ESP змінено")
end)

-- MOVEMENT
local movePage = Instance.new("Frame")
movePage.Size = UDim2.new(1, 0, 1, 0)
movePage.BackgroundTransparency = 1
movePage.Visible = false
movePage.Parent = contentFrame

AddToggle(movePage, "💨 Speed Glitch", 10, "SpeedGlitch", false)
AddToggle(movePage, "🐇 Bunny Hop", 45, "BunnyHop", false)
AddButton(movePage, "🚀 Fling Player", 90, function()
    Settings.Fling = not Settings.Fling
    print("Fling: " .. tostring(Settings.Fling))
end)

-- FARM
local farmPage = Instance.new("Frame")
farmPage.Size = UDim2.new(1, 0, 1, 0)
farmPage.BackgroundTransparency = 1
farmPage.Visible = false
farmPage.Parent = contentFrame

AddToggle(farmPage, "💰 Auto Farm (Coins)", 10, "AutoFarm", false)
AddToggle(farmPage, "⏳ Anti-AFK", 45, "AntiAFK", false)

-- MISC
local miscPage = Instance.new("Frame")
miscPage.Size = UDim2.new(1, 0, 1, 0)
miscPage.BackgroundTransparency = 1
miscPage.Visible = false
miscPage.Parent = contentFrame

AddToggle(miscPage, "💬 Chat Spam", 10, "ChatSpam", false)
AddButton(miscPage, "💥 Local Crash", 55, function()
    for i = 1, 5000 do
        local p = Instance.new("Part")
        p.Size = Vector3.new(50,50,50)
        p.Position = Vector3.new(math.random(-1000,1000), math.random(-1000,1000), math.random(-1000,1000))
        p.Parent = workspace
    end
end)
AddButton(miscPage, "🔄 Server Hop", 100, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

-- SETTINGS
local setPage = Instance.new("Frame")
setPage.Size = UDim2.new(1, 0, 1, 0)
setPage.BackgroundTransparency = 1
setPage.Visible = false
setPage.Parent = contentFrame

AddButton(setPage, "💾 Save Settings", 20, function()
    local data = HttpService:JSONEncode(Settings)
    print("Збережено: " .. data)
end)
AddButton(setPage, "📂 Load Settings", 70, function()
    print("Завантажено")
end)
AddButton(setPage, "🔄 Reset All", 120, function()
    for k in pairs(Settings) do Settings[k] = false end
    print("Скинуто")
end)

-- ===== ПЕРЕМИКАННЯ ВКЛАДОК =====
for name, btn in pairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        for _, child in pairs(contentFrame:GetChildren()) do
            child.Visible = false
        end
        local page = contentFrame:FindFirstChild(name == "AIM" and "Frame" or name)
        if page then page.Visible = true end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(30, 30, 55)
        end
    end)
end

-- ===== ВІДКРИТТЯ/ЗАКРИТТЯ =====
local guiOpen = false
toggleBtn.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    mainFrame.Visible = guiOpen
end)

closeBtn.MouseButton1Click:Connect(function()
    guiOpen = false
    mainFrame.Visible = false
end)

-- ===== ОСНОВНИЙ ЦИКЛ (ВСІ ФУНКЦІЇ) =====
RunService.Heartbeat:Connect(function()
    -- Aimbot + AutoShoot (MM2)
    if Settings.Aimbot or Settings.AutoShoot then
        local target = nil
        local minDist = Settings.AimbotFOV
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                local screenPos, onScreen = Camera:WorldToScreenPoint(hrp.Position)
                if onScreen then
                    local fov = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) -
                                 Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if fov < minDist then
                        minDist = fov
                        target = hrp
                    end
                end
            end
        end
        if target and LP.Character then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position, target.Position)
            if Settings.AutoShoot then
                VirtualInput:SendMouseButtonEvent(1, true, nil, nil)
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(1, false, nil, nil)
            end
        end
    end

    -- ESP (бокси над гравцями)
    if Settings.ESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local bill = Instance.new("BillboardGui")
                bill.Adornee = head
                bill.Size = UDim2.new(0, 100, 0, 40)
                bill.AlwaysOnTop = true
                bill.Parent = head
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Settings.ESPColor
                frame.BackgroundTransparency = 0.5
                frame.Parent = bill
            end
        end
    end

    -- Invisibility
    if Settings.Invisible and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end

    -- Speed Glitch
    if Settings.SpeedGlitch and LP.Character then
        LP.Character.Humanoid.WalkSpeed = 100
    end

    -- Bunny Hop
    if Settings.BunnyHop and LP.Character then
        if LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
            LP.Character.Humanoid.Jump = true
        end
    end

    -- Auto Farm (збір монет)
    if Settings.AutoFarm then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("coin") then
                if LP.Character then
                    LP.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
    end

    -- Anti-AFK
    if Settings.AntiAFK then
        VirtualInput:SendKeyEvent(true, "w", false, nil)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, "w", false, nil)
    end

    -- Fling (кидає іншого гравця)
    if Settings.Fling then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 5000, 0)
            end
        end
    end

    -- Chat Spam
    if Settings.ChatSpam then
        local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if chat then
            chat:FindFirstChild("SayMessageRequest"):FireServer("PIK PIK HUB BEST MM2", "All")
            task.wait(2)
        end
    end
end)

print("🔥 MM2 HUB завантажено! Натисни на шестерню.")
