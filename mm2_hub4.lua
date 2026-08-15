--[[
    MM2 HUB v3.0 (MOBILE COMPACT)
    Пересувне маленьке меню для Galaxy A16
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInput = game:GetService("VirtualInputManager")

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

-- ===== СТВОРЕННЯ GUI =====
local GUI = Instance.new("ScreenGui")
GUI.Name = "MM2Hub"
GUI.Parent = CoreGui
GUI.ResetOnSpawn = false

-- Кнопка-квадратик (завжди видна)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.88, 0, 0.85, 0)
toggleBtn.Image = "rbxassetid://6031094979"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
toggleBtn.Parent = GUI

-- ГОЛОВНЕ МЕНЮ (МАЛЕНЬКЕ, ПЕРЕСУВНЕ)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 360)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = GUI

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔥 MM2 HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Кнопка закриття
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 1
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

-- Вкладки (маленькі)
local tabs = {"AIM", "VIS", "MOVE", "FARM", "MISC", "SET"}
local tabBtns = {}
local currentTab = "AIM"

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 25)
tabContainer.Position = UDim2.new(0, 0, 0, 30)
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

-- Контент
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -6, 1, -60)
contentFrame.Position = UDim2.new(0, 3, 0, 58)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- ===== ДОПОМІЖНІ ФУНКЦІЇ (КОМПАКТНІ) =====
local function AddToggle(parent, label, y, key, default)
    local state = default or false
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 18, 0, 18)
    btn.Position = UDim2.new(0, 0, 0, 2)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    btn.Text = ""
    btn.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -22, 1, 0)
    lbl.Position = UDim2.new(0, 22, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 11
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
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = label .. ": " .. tostring(val)
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.4, 0, 0, 5)
    bar.Position = UDim2.new(0, 0, 0, 18)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    bar.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((val-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    fill.Parent = bar

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.2, 0, 0, 14)
    valLbl.Position = UDim2.new(0.5, 0, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(val)
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.TextSize = 10
    valLbl.Font = Enum.Font.Gotham
    valLbl.Parent = frame

    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(0.4, 0, 0, 18)
    dragBtn.Position = UDim2.new(0, 0, 0, 14)
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
    btn.Size = UDim2.new(0.35, 0, 0, 22)
    btn.Position = UDim2.new(0.02, 0, 0, y)
    btn.Text = label
    btn.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ===== ВКЛАДКИ =====
local aimPage = Instance.new("Frame")
aimPage.Size = UDim2.new(1, 0, 1, 0)
aimPage.BackgroundTransparency = 1
aimPage.Visible = true
aimPage.Parent = contentFrame
AddToggle(aimPage, "Aimbot", 2, "Aimbot", false)
AddToggle(aimPage, "AutoShoot", 24, "AutoShoot", false)
AddSlider(aimPage, "FOV", 48, "AimbotFOV", 50, 400, 150)

local visPage = Instance.new("Frame")
visPage.Size = UDim2.new(1, 0, 1, 0)
visPage.BackgroundTransparency = 1
visPage.Visible = false
visPage.Parent = contentFrame
AddToggle(visPage, "ESP", 2, "ESP", false)
AddToggle(visPage, "Invisible", 24, "Invisible", false)
AddButton(visPage, "Color", 48, function()
    Settings.ESPColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
end)

local movePage = Instance.new("Frame")
movePage.Size = UDim2.new(1, 0, 1, 0)
movePage.BackgroundTransparency = 1
movePage.Visible = false
movePage.Parent = contentFrame
AddToggle(movePage, "SpeedGlitch", 2, "SpeedGlitch", false)
AddToggle(movePage, "BunnyHop", 24, "BunnyHop", false)
AddButton(movePage, "Fling", 48, function() Settings.Fling = not Settings.Fling end)

local farmPage = Instance.new("Frame")
farmPage.Size = UDim2.new(1, 0, 1, 0)
farmPage.BackgroundTransparency = 1
farmPage.Visible = false
farmPage.Parent = contentFrame
AddToggle(farmPage, "AutoFarm", 2, "AutoFarm", false)
AddToggle(farmPage, "AntiAFK", 24, "AntiAFK", false)

local miscPage = Instance.new("Frame")
miscPage.Size = UDim2.new(1, 0, 1, 0)
miscPage.BackgroundTransparency = 1
miscPage.Visible = false
miscPage.Parent = contentFrame
AddToggle(miscPage, "ChatSpam", 2, "ChatSpam", false)
AddButton(miscPage, "Crash", 28, function()
    for i = 1, 3000 do
        local p = Instance.new("Part")
        p.Size = Vector3.new(30,30,30)
        p.Position = Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
        p.Parent = workspace
    end
end)
AddButton(miscPage, "Hop", 52, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

local setPage = Instance.new("Frame")
setPage.Size = UDim2.new(1, 0, 1, 0)
setPage.BackgroundTransparency = 1
setPage.Visible = false
setPage.Parent = contentFrame
AddButton(setPage, "Save", 6, function()
    print("Saved")
end)
AddButton(setPage, "Load", 30, function()
    print("Loaded")
end)
AddButton(setPage, "Reset", 54, function()
    for k in pairs(Settings) do Settings[k] = false end
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

-- ===== ОСНОВНИЙ ЦИКЛ =====
RunService.Heartbeat:Connect(function()
    -- Aimbot + AutoShoot
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

    -- ESP
    if Settings.ESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local bill = Instance.new("BillboardGui")
                bill.Adornee = head
                bill.Size = UDim2.new(0, 80, 0, 30)
                bill.AlwaysOnTop = true
                bill.Parent = head
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Settings.ESPColor
                frame.BackgroundTransparency = 0.4
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
        LP.Character.Humanoid.WalkSpeed = 80
    end

    -- Bunny Hop
    if Settings.BunnyHop and LP.Character then
        if LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
            LP.Character.Humanoid.Jump = true
        end
    end

    -- AutoFarm
    if Settings.AutoFarm then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("coin") then
                if LP.Character then
                    LP.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
    end

    -- AntiAFK
    if Settings.AntiAFK then
        VirtualInput:SendKeyEvent(true, "w", false, nil)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, "w", false, nil)
    end

    -- Fling
    if Settings.Fling then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 4000, 0)
            end
        end
    end

    -- Chat Spam
    if Settings.ChatSpam then
        local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if chat then
            chat:FindFirstChild("SayMessageRequest"):FireServer("PIK PIK HUB", "All")
            task.wait(2)
        end
    end
end)

print("🔥 MM2 HUB v3.0 завантажено! Натисни на квадратик.")
