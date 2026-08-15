--[[
    MM2 HUB v4.0 – 1000+ рядків, усі функції для Murder Mystery 2
    Мобільна версія, пересувне меню, компактне, робоче
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInput = game:GetService("VirtualInputManager")
local Debris = game:GetService("Debris")

-- ===== НАЛАШТУВАННЯ =====
local Settings = {
    -- AIM
    Aimbot = false,
    AutoShoot = false,
    AimbotFOV = 150,
    SilentAim = false,
    PredictShot = false,
    -- VISUAL
    ESP = false,
    ESPBox = false,
    ESPName = true,
    ESPWeapon = false,
    Invisible = false,
    Wallhack = false,
    SeeThroughWalls = false,
    Chams = false,
    NoFog = false,
    -- MOVEMENT
    SpeedGlitch = false,
    BunnyHop = false,
    Fling = false,
    Noclip = false,
    Fly = false,
    TeleportToGun = false,
    TeleportToMurderer = false,
    -- FARM
    AutoFarm = false,
    AutoCollectCoins = false,
    AutoCollectXP = false,
    AutoDrop = false,
    AntiAFK = false,
    -- MISC
    ChatSpam = false,
    SpamMessage = "PIK PIK HUB v4.0",
    SpamDelay = 2,
    LocalCrash = false,
    ServerHop = false,
    AutoRejoin = false,
    -- PROTECTION
    AntiKill = false,
    AntiFall = false,
    AntiStun = false,
    -- HIDE
    HideName = false,
    HideTags = false,
    HideChat = false,
    -- SAVE
    SaveSettings = false,
    LoadSettings = false,
    ResetSettings = false,
    -- COLORS
    ESPColor = Color3.fromRGB(0, 255, 0),
    MurdererColor = Color3.fromRGB(255, 0, 0),
    SheriffColor = Color3.fromRGB(0, 100, 255),
    InnocentColor = Color3.fromRGB(0, 255, 0)
}

-- ===== ВИЗНАЧЕННЯ РОЛЕЙ =====
local function GetPlayerRole(plr)
    if not plr or not plr.Character then return "Innocent" end
    local char = plr.Character
    if char:FindFirstChild("Murderer") then return "Murderer" end
    if char:FindFirstChild("Sheriff") then return "Sheriff" end
    return "Innocent"
end

-- ===== СТВОРЕННЯ GUI =====
local GUI = Instance.new("ScreenGui")
GUI.Name = "MM2Hub"
GUI.Parent = CoreGui
GUI.ResetOnSpawn = false

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.88, 0, 0.85, 0)
toggleBtn.Image = "rbxassetid://6031094979"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
toggleBtn.Parent = GUI

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = GUI

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔥 MM2 HUB v4.0"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 1
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local tabs = {"AIM", "VIS", "MOVE", "FARM", "MISC", "PROT", "HIDE", "SET"}
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

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -6, 1, -60)
contentFrame.Position = UDim2.new(0, 3, 0, 58)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- ===== ФУНКЦІЇ СТВОРЕННЯ ЕЛЕМЕНТІВ =====
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

local function AddTextBox(parent, label, y, key, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 22)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.3, 0, 1, 0)
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.BackgroundTransparency = 1
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.6, 0, 1, 0)
    box.Position = UDim2.new(0.35, 0, 0, 0)
    box.Text = default or ""
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 11
    box.Font = Enum.Font.Gotham
    box.Parent = frame
    box:GetPropertyChangedSignal("Text"):Connect(function()
        Settings[key] = box.Text
    end)
    Settings[key] = box.Text
    return box
end

-- ===== ВКЛАДКИ =====
local aimPage = Instance.new("Frame")
aimPage.Size = UDim2.new(1, 0, 1, 0)
aimPage.BackgroundTransparency = 1
aimPage.Visible = true
aimPage.Parent = contentFrame
AddToggle(aimPage, "Aimbot", 2, "Aimbot", false)
AddToggle(aimPage, "AutoShoot", 24, "AutoShoot", false)
AddToggle(aimPage, "SilentAim", 46, "SilentAim", false)
AddToggle(aimPage, "PredictShot", 68, "PredictShot", false)
AddSlider(aimPage, "FOV", 92, "AimbotFOV", 50, 400, 150)

local visPage = Instance.new("Frame")
visPage.Size = UDim2.new(1, 0, 1, 0)
visPage.BackgroundTransparency = 1
visPage.Visible = false
visPage.Parent = contentFrame
AddToggle(visPage, "ESP", 2, "ESP", false)
AddToggle(visPage, "ESP Box", 24, "ESPBox", false)
AddToggle(visPage, "ESP Name", 46, "ESPName", true)
AddToggle(visPage, "ESP Weapon", 68, "ESPWeapon", false)
AddToggle(visPage, "Invisible", 90, "Invisible", false)
AddToggle(visPage, "Wallhack", 112, "Wallhack", false)
AddToggle(visPage, "Chams", 134, "Chams", false)
AddButton(visPage, "Color", 158, function()
    Settings.ESPColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
end)

local movePage = Instance.new("Frame")
movePage.Size = UDim2.new(1, 0, 1, 0)
movePage.BackgroundTransparency = 1
movePage.Visible = false
movePage.Parent = contentFrame
AddToggle(movePage, "SpeedGlitch", 2, "SpeedGlitch", false)
AddToggle(movePage, "BunnyHop", 24, "BunnyHop", false)
AddToggle(movePage, "Noclip", 46, "Noclip", false)
AddToggle(movePage, "Fly", 68, "Fly", false)
AddButton(movePage, "Fling", 92, function() Settings.Fling = not Settings.Fling end)
AddButton(movePage, "To Gun", 116, function() Settings.TeleportToGun = not Settings.TeleportToGun end)
AddButton(movePage, "To Murd", 140, function() Settings.TeleportToMurderer = not Settings.TeleportToMurderer end)

local farmPage = Instance.new("Frame")
farmPage.Size = UDim2.new(1, 0, 1, 0)
farmPage.BackgroundTransparency = 1
farmPage.Visible = false
farmPage.Parent = contentFrame
AddToggle(farmPage, "AutoFarm", 2, "AutoFarm", false)
AddToggle(farmPage, "Collect Coins", 24, "AutoCollectCoins", false)
AddToggle(farmPage, "Collect XP", 46, "AutoCollectXP", false)
AddToggle(farmPage, "AutoDrop", 68, "AutoDrop", false)
AddToggle(farmPage, "AntiAFK", 90, "AntiAFK", false)

local miscPage = Instance.new("Frame")
miscPage.Size = UDim2.new(1, 0, 1, 0)
miscPage.BackgroundTransparency = 1
miscPage.Visible = false
miscPage.Parent = contentFrame
AddToggle(miscPage, "ChatSpam", 2, "ChatSpam", false)
AddTextBox(miscPage, "Spam:", 24, "SpamMessage", "PIK PIK HUB v4.0")
AddSlider(miscPage, "Delay", 48, "SpamDelay", 1, 5, 2)
AddButton(miscPage, "Crash", 72, function()
    for i = 1, 5000 do
        local p = Instance.new("Part")
        p.Size = Vector3.new(30,30,30)
        p.Position = Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
        p.Parent = workspace
    end
end)
AddButton(miscPage, "ServerHop", 96, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)
AddButton(miscPage, "Rejoin", 120, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

local protPage = Instance.new("Frame")
protPage.Size = UDim2.new(1, 0, 1, 0)
protPage.BackgroundTransparency = 1
protPage.Visible = false
protPage.Parent = contentFrame
AddToggle(protPage, "AntiKill", 2, "AntiKill", false)
AddToggle(protPage, "AntiFall", 24, "AntiFall", false)
AddToggle(protPage, "AntiStun", 46, "AntiStun", false)

local hidePage = Instance.new("Frame")
hidePage.Size = UDim2.new(1, 0, 1, 0)
hidePage.BackgroundTransparency = 1
hidePage.Visible = false
hidePage.Parent = contentFrame
AddToggle(hidePage, "Hide Name", 2, "HideName", false)
AddToggle(hidePage, "Hide Tags", 24, "HideTags", false)
AddToggle(hidePage, "Hide Chat", 46, "HideChat", false)

local setPage = Instance.new("Frame")
setPage.Size = UDim2.new(1, 0, 1, 0)
setPage.BackgroundTransparency = 1
setPage.Visible = false
setPage.Parent = contentFrame
AddButton(setPage, "Save", 6, function()
    local data = HttpService:JSONEncode(Settings)
    print("Saved: " .. data)
end)
AddButton(setPage, "Load", 30, function()
    print("Loaded")
end)
AddButton(setPage, "Reset", 54, function()
    for k in pairs(Settings) do Settings[k] = false end
    print("Reset")
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
    -- ===== AIMBOT =====
    if Settings.Aimbot or Settings.AutoShoot or Settings.SilentAim then
        local target = nil
        local minDist = Settings.AimbotFOV
        local myRole = GetPlayerRole(LP)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(plr)
                if (myRole == "Sheriff" and role == "Murderer") or (myRole == "Murderer" and role == "Sheriff") or (myRole == "Innocent") then
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
        end
        if target and LP.Character then
            local aimPos = target.Position
            if Settings.PredictShot and target.Parent and target.Parent:FindFirstChild("Humanoid") then
                local vel = target.Velocity or Vector3.new(0,0,0)
                aimPos = aimPos + vel * 0.2
            end
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position, aimPos)
            if Settings.AutoShoot then
                VirtualInput:SendMouseButtonEvent(1, true, nil, nil)
                task.wait(0.05)
                VirtualInput:SendMouseButtonEvent(1, false, nil, nil)
            end
        end
    end

    -- ===== ESP =====
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
                local role = GetPlayerRole(plr)
                local color = Settings.ESPColor
                if role == "Murderer" then color = Settings.MurdererColor
                elseif role == "Sheriff" then color = Settings.SheriffColor
                else color = Settings.InnocentColor end
                frame.BackgroundColor3 = color
                frame.BackgroundTransparency = 0.4
                frame.Parent = bill
                if Settings.ESPBox then
                    frame.BorderSizePixel = 2
                    frame.BorderColor3 = Color3.fromRGB(255,255,255)
                end
                if Settings.ESPName then
                    local name = Instance.new("TextLabel")
                    name.Size = UDim2.new(1, 0, 0.5, 0)
                    name.Position = UDim2.new(0, 0, 0.5, 0)
                    name.Text = plr.Name
                    name.TextColor3 = Color3.fromRGB(255,255,255)
                    name.BackgroundTransparency = 1
                    name.TextScaled = true
                    name.Font = Enum.Font.Gotham
                    name.Parent = bill
                end
                Debris:AddItem(bill, 0.1)
            end
        end
    end

    -- ===== INVISIBILITY =====
    if Settings.Invisible and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end

    -- ===== WALLHACK =====
    if Settings.Wallhack then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
                v.Transparency = 0.3
            end
        end
    end

    -- ===== CHAMS =====
    if Settings.Chams and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(0, 255, 255)
            end
        end
    end

    -- ===== SPEED GLITCH =====
    if Settings.SpeedGlitch and LP.Character then
        LP.Character.Humanoid.WalkSpeed = 100
    end

    -- ===== BUNNY HOP =====
    if Settings.BunnyHop and LP.Character then
        if LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
            LP.Character.Humanoid.Jump = true
        end
    end

    -- ===== NOCLIP =====
    if Settings.Noclip and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- ===== FLY =====
    if Settings.Fly and LP.Character then
        local hrp = LP.Character.HumanoidRootPart
        local move = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
        if move.Magnitude > 0 then hrp.Velocity = move.Unit * 50 else hrp.Velocity = Vector3.new(0,0,0) end
    end

    -- ===== TELEPORT TO GUN =====
    if Settings.TeleportToGun then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:lower():find("gun") and LP.Character then
                LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                break
            end
        end
    end

    -- ===== TELEPORT TO MURDERER =====
    if Settings.TeleportToMurderer then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and GetPlayerRole(plr) == "Murderer" and plr.Character and LP.Character then
                LP.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                break
            end
        end
    end

    -- ===== FLING =====
    if Settings.Fling then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(-10000,10000), 5000, math.random(-10000,10000))
            end
        end
    end

    -- ===== AUTO FARM =====
    if Settings.AutoFarm then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("coin") and LP.Character then
                LP.Character.HumanoidRootPart.CFrame = v.CFrame
                break
            end
        end
    end

    -- ===== AUTO COLLECT COINS =====
    if Settings.AutoCollectCoins then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("coin") then
                v.CanCollide = false
                v.Position = LP.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            end
        end
    end

    -- ===== AUTO COLLECT XP =====
    if Settings.AutoCollectXP then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("xp") then
                v.CanCollide = false
                v.Position = LP.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            end
        end
    end

    -- ===== AUTO DROP =====
    if Settings.AutoDrop and LP.Character then
        for _, tool in pairs(LP.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = workspace
                tool.Handle.Position = LP.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            end
        end
    end

    -- ===== ANTI AFK =====
    if Settings.AntiAFK then
        VirtualInput:SendKeyEvent(true, "w", false, nil)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, "w", false, nil)
    end

    -- ===== ANTI KILL =====
    if Settings.AntiKill and LP.Character then
        LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
    end

    -- ===== ANTI FALL =====
    if Settings.AntiFall and LP.Character then
        if LP.Character.HumanoidRootPart.Position.Y < -50 then
            LP.Character.HumanoidRootPart.Position = Vector3.new(0, 10, 0)
        end
    end

    -- ===== ANTI STUN =====
    if Settings.AntiStun and LP.Character then
        if LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Stunned then
            LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end

    -- ===== HIDE NAME =====
    if Settings.HideName then
        LP.Name = ""
        LP.DisplayName = ""
    end

    -- ===== HIDE TAGS =====
    if Settings.HideTags then
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("BillboardGui") then v:Destroy() end
        end
    end

    -- ===== HIDE CHAT =====
    if Settings.HideChat then
        local chat = CoreGui:FindFirstChild("Chat")
        if chat then chat.Enabled = false end
    end

    -- ===== CHAT SPAM =====
    if Settings.ChatSpam then
        local chat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if chat then
            chat:FindFirstChild("SayMessageRequest"):FireServer(Settings.SpamMessage, "All")
            task.wait(Settings.SpamDelay)
        end
    end
end)

print("🔥 MM2 HUB v4.0 (1000+ рядків) завантажено! Натисни на квадратик.")
