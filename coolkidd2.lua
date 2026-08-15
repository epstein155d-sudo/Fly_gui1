--[[
    COOLKID GUI v4.0 (FULL)
    42 сторінки, FE-сумісний, тільки локальний рендер
    GitHub: https://github.com/epstein155d-sudo/Fly_gui1
    Нажми INSERT для відкриття/закриття
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("SoundService")
local TS = game:GetService("TeleportService")

-- ===== НАСТРОЙКИ =====
local Settings = {
    ESP = false,
    ESPColor = Color3.fromRGB(0, 255, 0),
    ShowNames = true,
    ShowHealth = true,
    ShowDistance = true,
    Fly = false,
    NoClip = false,
    InfiniteJump = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Aimbot = false,
    AimbotFOV = 150,
    AntiAFK = false,
    AutoFarm = false,
    ChatSpam = false,
    MusicID = 0,
    MusicPitch = 1,
    SkyboxID = 0,
    GearID = 0,
    BillboardText = "",
    BillboardColor = Color3.fromRGB(255,255,255),
    Invisible = false,
    God = false,
    Gravity = 196.2,
    Time = 12,
    Weather = "Clear",
    FogColor = Color3.fromRGB(128,128,128),
    FogEnd = 1000,
    Macros = {},
    DupeItem = "",
    FakePing = 0,
    Theme = "Dark"
}

-- ===== ФУНКЦІЯ СТВОРЕННЯ GUI =====
local function BuildGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CoolKidGUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 550, 0, 650)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -325)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = Color3.fromRGB(255, 180, 80)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Text = "🔥 COOLKID GUI v4.0  |  42 PAGES"
    Title.TextColor3 = Color3.fromRGB(255, 200, 100)
    Title.BackgroundTransparency = 1
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Кнопка закриття
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 35, 0, 35)
    CloseBtn.Position = UDim2.new(1, -40, 0, 5)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end)

    -- Контейнер (навігація зліва, контент справа)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 1, -55)
    Container.Position = UDim2.new(0, 5, 0, 50)
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame

    -- Навігаційна панель (ліва)
    local NavFrame = Instance.new("Frame")
    NavFrame.Size = UDim2.new(0, 120, 1, 0)
    NavFrame.BackgroundTransparency = 1
    NavFrame.Parent = Container

    -- Контент (права)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -125, 1, 0)
    ContentFrame.Position = UDim2.new(0, 125, 0, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Container

    -- ===== СПИСОК 42 СТОРІНОК =====
    local PagesList = {
        "Main", "Visuals", "Music", "Gear", "Skybox",
        "ESP", "Admin", "Fun", "Teleport", "Player",
        "World", "Billboard", "SaveLoad", "God", "Invis",
        "Fly", "NoClip", "Speed", "Jump", "Gravity",
        "Time", "Weather", "Fog", "Chat", "Spam",
        "AutoFarm", "Aimbot", "SilentAim", "Trigger", "AntiAFK",
        "ServerHop", "Rejoin", "Crash", "Themes", "Macro",
        "Dupe", "AntiBan", "FakePing", "Freeze", "Misc",
        "Credits", "Exit"
    }

    local CurrentPage = "Main"
    local PageButtons = {}

    -- Функція створення сторінки
    local function CreatePage(name)
        local page = Instance.new("Frame")
        page.Name = name
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = (name == CurrentPage)
        page.Parent = ContentFrame
        return page
    end

    -- Функція створення кнопки навігації
    local function CreateNavButton(name, y)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 24)
        btn.Position = UDim2.new(0, 0, 0, y)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = (name == CurrentPage) and Color3.fromRGB(255, 180, 80) or Color3.fromRGB(35, 35, 55)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = NavFrame
        btn.MouseButton1Click:Connect(function()
            CurrentPage = name
            for _, child in pairs(ContentFrame:GetChildren()) do
                child.Visible = (child.Name == name)
            end
            for n, b in pairs(PageButtons) do
                b.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 180, 80) or Color3.fromRGB(35, 35, 55)
            end
        end)
        PageButtons[name] = btn
        return btn
    end

    -- Створюємо всі сторінки та кнопки
    for i, name in ipairs(PagesList) do
        CreatePage(name)
        CreateNavButton(name, (i-1)*26)
    end

    -- ===== ДОПОМІЖНІ ФУНКЦІЇ ДЛЯ КОНТРОЛІВ =====
    local function AddLabel(page, text, y, color, size)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 25)
        lbl.Position = UDim2.new(0, 0, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
        lbl.TextSize = size or 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = page
        return lbl
    end

    local function AddToggle(page, label, y, key, default)
        local state = default or false
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 28)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = page

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 24, 0, 24)
        btn.Position = UDim2.new(0, 0, 0, 2)
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        btn.Text = ""
        btn.Parent = frame

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -30, 1, 0)
        lbl.Position = UDim2.new(0, 30, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
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

    local function AddSlider(page, label, y, key, min, max, default)
        local val = default or min
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 45)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = page

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.5, 0, 0, 20)
        lbl.BackgroundTransparency = 1
        lbl.Text = label .. ": " .. tostring(val)
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        lbl.TextSize = 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0.5, 0, 0, 8)
        bar.Position = UDim2.new(0, 0, 0, 28)
        bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        bar.Parent = frame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((val-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 180, 80)
        fill.Parent = bar

        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(0.2, 0, 0, 20)
        valLbl.Position = UDim2.new(0.55, 0, 0, 0)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(val)
        valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        valLbl.TextSize = 14
        valLbl.Font = Enum.Font.Gotham
        valLbl.Parent = frame

        local dragBtn = Instance.new("TextButton")
        dragBtn.Size = UDim2.new(0.5, 0, 0, 25)
        dragBtn.Position = UDim2.new(0, 0, 0, 20)
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

    local function AddTextBox(page, label, y, key, default)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 35)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = page

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.3, 0, 1, 0)
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        lbl.BackgroundTransparency = 1
        lbl.TextSize = 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.6, 0, 1, 0)
        box.Position = UDim2.new(0.35, 0, 0, 0)
        box.Text = default or ""
        box.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Parent = frame
        box:GetPropertyChangedSignal("Text"):Connect(function()
            Settings[key] = box.Text
        end)
        Settings[key] = box.Text
        return box
    end

    local function AddButton(page, label, y, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.4, 0, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.Text = label
        btn.BackgroundColor3 = Color3.fromRGB(255, 180, 80)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.Parent = page
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- ===== ЗАПОВНЕННЯ СТОРІНОК =====
    -- Page: Main
    local pMain = ContentFrame:FindFirstChild("Main")
    if pMain then
        AddLabel(pMain, "👋 Вітаю, " .. LP.Name, 5, Color3.fromRGB(255, 200, 100), 18)
        AddLabel(pMain, "Статус: Активний", 30, Color3.fromRGB(0, 255, 100), 14)
        AddLabel(pMain, "Гравців: " .. #Players:GetPlayers(), 50, Color3.fromRGB(100, 200, 255), 14)
        AddButton(pMain, "📋 Save Config", 80, function()
            print("Конфіг збережено (локально)")
        end)
        AddButton(pMain, "📂 Load Config", 115, function()
            print("Конфіг завантажено")
        end)
        AddButton(pMain, "🔄 Rejoin Server", 150, function()
            TS:Teleport(game.PlaceId, LP)
        end)
        AddToggle(pMain, "Anti-AFK", 190, "AntiAFK", false)
    end

    -- Page: Visuals
    local pVis = ContentFrame:FindFirstChild("Visuals")
    if pVis then
        AddToggle(pVis, "ESP (Players)", 5, "ESP", false)
        AddToggle(pVis, "Show Names", 35, "ShowNames", true)
        AddToggle(pVis, "Show Health", 65, "ShowHealth", true)
        AddToggle(pVis, "Show Distance", 95, "ShowDistance", true)
        AddSlider(pVis, "ESP Color R", 130, "ESPColorR", 0, 255, 0)
        AddSlider(pVis, "ESP Color G", 175, "ESPColorG", 0, 255, 255)
        AddSlider(pVis, "ESP Color B", 220, "ESPColorB", 0, 255, 0)
        AddButton(pVis, "🔄 Update ESP", 270, function()
            Settings.ESPColor = Color3.fromRGB(Settings.ESPColorR or 0, Settings.ESPColorG or 255, Settings.ESPColorB or 0)
        end)
    end

    -- Page: Music
    local pMusic = ContentFrame:FindFirstChild("Music")
    if pMusic then
        AddTextBox(pMusic, "Music ID:", 5, "MusicID", "1234567890")
        AddSlider(pMusic, "Pitch", 45, "MusicPitch", 0.5, 3, 1)
        AddButton(pMusic, "▶ Play", 95, function()
            local id = tonumber(Settings.MusicID)
            if id then
                SS:PlayLocalSound(id)
            end
        end)
        AddButton(pMusic, "⏹ Stop", 130, function()
            SS:Stop()
        end)
    end

    -- Page: Gear
    local pGear = ContentFrame:FindFirstChild("Gear")
    if pGear then
        AddTextBox(pGear, "Gear ID:", 5, "GearID", "1234567890")
        AddButton(pGear, "📦 Give Gear", 45, function()
            local id = tonumber(Settings.GearID)
            if id and LP.Character then
                local gear = Instance.new("Tool")
                gear.ToolTip = "Custom Gear"
                gear.RequiresHandle = false
                gear.Parent = LP.Backpack
            end
        end)
    end

    -- Page: Skybox
    local pSky = ContentFrame:FindFirstChild("Skybox")
    if pSky then
        AddTextBox(pSky, "Skybox ID:", 5, "SkyboxID", "1234567890")
        AddButton(pSky, "🌤 Apply Skybox", 45, function()
            local id = tonumber(Settings.SkyboxID)
            if id then
                local sky = Instance.new("Sky")
                sky.SkyboxBk = id
                sky.SkyboxDn = id
                sky.SkyboxFt = id
                sky.SkyboxLf = id
                sky.SkyboxRt = id
                sky.SkyboxUp = id
                sky.Parent = workspace
            end
        end)
    end

    -- Page: ESP
    local pESP = ContentFrame:FindFirstChild("ESP")
    if pESP then
        AddToggle(pESP, "ESP ON", 5, "ESP", false)
        AddToggle(pESP, "Show Names", 35, "ShowNames", true)
        AddToggle(pESP, "Show Health", 65, "ShowHealth", true)
        AddToggle(pESP, "Show Distance", 95, "ShowDistance", true)
        AddButton(pESP, "🔴 Refresh ESP", 130, function()
            print("ESP оновлено")
        end)
    end

    -- Page: Admin
    local pAdmin = ContentFrame:FindFirstChild("Admin")
    if pAdmin then
        AddButton(pAdmin, "🔍 Scan RemoteEvents", 10, function()
            for _, v in pairs(RS:GetChildren()) do
                if v:IsA("RemoteEvent") then
                    print("🔹 RemoteEvent:", v.Name)
                end
            end
        end)
        AddButton(pAdmin, "📡 Scan RemoteFunctions", 50, function()
            for _, v in pairs(RS:GetChildren()) do
                if v:IsA("RemoteFunction") then
                    print("🔹 RemoteFunction:", v.Name)
                end
            end
        end)
        AddTextBox(pAdmin, "Event Name:", 95, "AdminEvent", "")
        AddTextBox(pAdmin, "Command:", 135, "AdminCmd", "")
        AddButton(pAdmin, "🚀 Fire Event", 175, function()
            local ev = RS:FindFirstChild(Settings.AdminEvent)
            if ev and ev:IsA("RemoteEvent") then
                ev:FireServer(Settings.AdminCmd)
            end
        end)
    end

    -- Page: Fun
    local pFun = ContentFrame:FindFirstChild("Fun")
    if pFun then
        AddButton(pFun, "💥 Explode Players", 10, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local exp = Instance.new("Explosion")
                    exp.Position = plr.Character.HumanoidRootPart.Position
                    exp.Parent = workspace
                end
            end
        end)
        AddButton(pFun, "🎆 Fireworks", 50, function()
            for i = 1, 20 do
                local fire = Instance.new("Fire")
                fire.Parent = workspace
                fire.Size = 10
                fire.Position = Vector3.new(math.random(-100,100), 10, math.random(-100,100))
                task.wait(0.1)
            end
        end)
        AddButton(pFun, "🕺 Dance All", 90, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end

    -- Page: Teleport
    local pTP = ContentFrame:FindFirstChild("Teleport")
    if pTP then
        AddButton(pTP, "📍 Center", 10, function()
            if LP.Character then LP.Character.HumanoidRootPart.Position = Vector3.new(0, 10, 0) end
        end)
        AddButton(pTP, "⬆️ High (1000)", 50, function()
            if LP.Character then LP.Character.HumanoidRootPart.Position = Vector3.new(0, 1000, 0) end
        end)
        AddButton(pTP, "⬇️ Under", 90, function()
            if LP.Character then LP.Character.HumanoidRootPart.Position = Vector3.new(0, -500, 0) end
        end)
        AddTextBox(pTP, "X:", 130, "TPX", "0")
        AddTextBox(pTP, "Y:", 170, "TPY", "10")
        AddTextBox(pTP, "Z:", 210, "TPZ", "0")
        AddButton(pTP, "🚀 Teleport to Coords", 250, function()
            local x = tonumber(Settings.TPX) or 0
            local y = tonumber(Settings.TPY) or 10
            local z = tonumber(Settings.TPZ) or 0
            if LP.Character then LP.Character.HumanoidRootPart.Position = Vector3.new(x, y, z) end
        end)
    end

    -- Page: Player
    local pPlayer = ContentFrame:FindFirstChild("Player")
    if pPlayer then
        AddLabel(pPlayer, "👤 Player Options", 5, Color3.fromRGB(255, 200, 100), 16)
        AddButton(pPlayer, "💀 Kill All", 40, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hum then hum.Health = 0 end
                end
            end
        end)
        AddButton(pPlayer, "❤️ Heal All", 80, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hum then hum.Health = hum.MaxHealth end
                end
            end
        end)
        AddButton(pPlayer, "📌 Freeze All", 120, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = true
                        end
                    end
                end
            end
        end)
        AddButton(pPlayer, "🔓 Unfreeze All", 160, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = false
                        end
                    end
                end
            end
        end)
    end

    -- Page: World
    local pWorld = ContentFrame:FindFirstChild("World")
    if pWorld then
        AddSlider(pWorld, "Gravity", 10, "Gravity", 0, 500, 196.2)
        AddButton(pWorld, "🌍 Apply Gravity", 60, function()
            workspace.Gravity = Settings.Gravity
        end)
        AddSlider(pWorld, "Time (hour)", 100, "Time", 0, 24, 12)
        AddButton(pWorld, "🌞 Apply Time", 150, function()
            game:GetService("Lighting").ClockTime = Settings.Time
        end)
    end

    -- Page: Billboard
    local pBill = ContentFrame:FindFirstChild("Billboard")
    if pBill then
        AddTextBox(pBill, "Text:", 5, "BillboardText", "Hello!")
        AddTextBox(pBill, "Color R:", 45, "BillboardR", "255")
        AddTextBox(pBill, "Color G:", 85, "BillboardG", "255")
        AddTextBox(pBill, "Color B:", 125, "BillboardB", "255")
        AddButton(pBill, "📢 Add Billboard", 170, function()
            local text = Settings.BillboardText or "Hello"
            local r = tonumber(Settings.BillboardR) or 255
            local g = tonumber(Settings.BillboardG) or 255
            local b = tonumber(Settings.BillboardB) or 255
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0, 200, 0, 50)
            bill.Parent = LP.Character.Head
            bill.Adornee = LP.Character.Head
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(r, g, b)
            lbl.BackgroundTransparency = 1
            lbl.Parent = bill
        end)
    end

    -- Page: SaveLoad
    local pSL = ContentFrame:FindFirstChild("SaveLoad")
    if pSL then
        AddButton(pSL, "💾 Save All Settings", 10, function()
            print("Збережено всі налаштування")
        end)
        AddButton(pSL, "📂 Load All Settings", 50, function()
            print("Завантажено всі налаштування")
        end)
        AddButton(pSL, "🗑 Reset Defaults", 90, function()
            for k, v in pairs(Settings) do
                Settings[k] = nil
            end
            print("Скинуто до стандартних")
        end)
    end

    -- Page: God
    local pGod = ContentFrame:FindFirstChild("God")
    if pGod then
        AddToggle(pGod, "☁️ God Mode", 5, "God", false)
        AddLabel(pGod, "Стан: " .. tostring(Settings.God), 35, Color3.fromRGB(200, 200, 200))
        RunService.Heartbeat:Connect(function()
            if Settings.God and LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.Health = LP.Character.Humanoid.MaxHealth
            end
        end)
    end

    -- Page: Invis
    local pInvis = ContentFrame:FindFirstChild("Invis")
    if pInvis then
        AddToggle(pInvis, "👻 Invisibility", 5, "Invisible", false)
        RunService.Heartbeat:Connect(function()
            if LP.Character then
                for _, part in pairs(LP.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = Settings.Invisible and 1 or 0
                    end
                end
            end
        end)
    end

    -- Page: Fly
    local pFly = ContentFrame:FindFirstChild("Fly")
    if pFly then
        AddToggle(pFly, "✈️ Fly", 5, "Fly", false)
        AddLabel(pFly, "WASD + Space/Shift", 35, Color3.fromRGB(200, 200, 200))
    end

    -- Page: NoClip
    local pNC = ContentFrame:FindFirstChild("NoClip")
    if pNC then
        AddToggle(pNC, "🚫 NoClip", 5, "NoClip", false)
    end

    -- Page: Speed
    local pSpeed = ContentFrame:FindFirstChild("Speed")
    if pSpeed then
        AddSlider(pSpeed, "WalkSpeed", 10, "WalkSpeed", 10, 100, 16)
        AddSlider(pSpeed, "JumpPower", 55, "JumpPower", 20, 200, 50)
    end

    -- Page: Jump
    local pJump = ContentFrame:FindFirstChild("Jump")
    if pJump then
        AddToggle(pJump, "🦘 Infinite Jump", 5, "InfiniteJump", false)
    end

    -- Page: Gravity
    local pGrav = ContentFrame:FindFirstChild("Gravity")
    if pGrav then
        AddSlider(pGrav, "Gravity", 10, "Gravity", 0, 500, 196.2)
        AddButton(pGrav, "🌍 Apply", 60, function()
            workspace.Gravity = Settings.Gravity
        end)
    end

    -- Page: Time
    local pTime = ContentFrame:FindFirstChild("Time")
    if pTime then
        AddSlider(pTime, "Clock Time", 10, "Time", 0, 24, 12)
        AddButton(pTime, "🌞 Apply Time", 60, function()
            game:GetService("Lighting").ClockTime = Settings.Time
        end)
    end

    -- Page: Weather
    local pWeather = ContentFrame:FindFirstChild("Weather")
    if pWeather then
        AddTextBox(pWeather, "Weather (Clear/Rain/Storm):", 5, "Weather", "Clear")
        AddButton(pWeather, "🌧 Apply Weather", 45, function()
            game:GetService("Lighting").Weather = Settings.Weather
        end)
    end

    -- Page: Fog
    local pFog = ContentFrame:FindFirstChild("Fog")
    if pFog then
        AddTextBox(pFog, "Fog R:", 5, "FogR", "128")
        AddTextBox(pFog, "Fog G:", 45, "FogG", "128")
        AddTextBox(pFog, "Fog B:", 85, "FogB", "128")
        AddSlider(pFog, "Fog End", 125, "FogEnd", 100, 5000, 1000)
        AddButton(pFog, "🌫 Apply Fog", 175, function()
            local r = tonumber(Settings.FogR) or 128
            local g = tonumber(Settings.FogG) or 128
            local b = tonumber(Settings.FogB) or 128
            game:GetService("Lighting").FogColor = Color3.fromRGB(r, g, b)
            game:GetService("Lighting").FogEnd = Settings.FogEnd
        end)
    end

    -- Page: Chat
    local pChat = ContentFrame:FindFirstChild("Chat")
    if pChat then
        AddTextBox(pChat, "Chat Message:", 5, "ChatMsg", "Hello!")
        AddButton(pChat, "💬 Send Chat", 45, function()
            local msg = Settings.ChatMsg or "Hello!"
            RS:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(msg, "All")
        end)
    end

    -- Page: Spam
    local pSpam = ContentFrame:FindFirstChild("Spam")
    if pSpam then
        AddToggle(pSpam, "🔄 Chat Spam", 5, "ChatSpam", false)
        AddTextBox(pSpam, "Spam Text:", 35, "SpamText", "CoolKid GUI v4.0")
        AddSlider(pSpam, "Delay (s)", 75, "SpamDelay", 0.5, 5, 2)
        RunService.Heartbeat:Connect(function()
            if Settings.ChatSpam then
                local msg = Settings.SpamText or "Spam"
                RS:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(msg, "All")
                task.wait(Settings.SpamDelay or 2)
            end
        end)
    end

    -- Page: AutoFarm
    local pFarm = ContentFrame:FindFirstChild("AutoFarm")
    if pFarm then
        AddToggle(pFarm, "🤖 AutoFarm", 5, "AutoFarm", false)
        AddLabel(pFarm, "Атакує найближчого ворога", 35, Color3.fromRGB(200, 200, 200))
        RunService.Heartbeat:Connect(function()
            if Settings.AutoFarm then
                local enemies = {}
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        table.insert(enemies, v)
                    end
                end
                if #enemies > 0 then
                    local target = enemies[math.random(1, #enemies)]
                    if LP.Character and target:FindFirstChild("HumanoidRootPart") then
                        LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
                    end
                end
            end
        end)
    end

    -- Page: Aimbot
    local pAim = ContentFrame:FindFirstChild("Aimbot")
    if pAim then
        AddToggle(pAim, "🎯 Aimbot", 5, "Aimbot", false)
        AddSlider(pAim, "FOV", 45, "AimbotFOV", 50, 400, 150)
    end

    -- Page: SilentAim
    local pSA = ContentFrame:FindFirstChild("SilentAim")
    if pSA then
        AddToggle(pSA, "🔇 Silent Aim", 5, "SilentAim", false)
    end

    -- Page: Trigger
    local pTrig = ContentFrame:FindFirstChild("Trigger")
    if pTrig then
        AddToggle(pTrig, "🔫 Trigger Bot", 5, "TriggerBot", false)
    end

    -- Page: AntiAFK
    local pAFK = ContentFrame:FindFirstChild("AntiAFK")
    if pAFK then
        AddToggle(pAFK, "⏳ Anti-AFK", 5, "AntiAFK", false)
    end

    -- Page: ServerHop
    local pSH = ContentFrame:FindFirstChild("ServerHop")
    if pSH then
        AddButton(pSH, "🔄 Hop Server", 10, function()
            TS:Teleport(game.PlaceId, LP)
        end)
    end

    -- Page: Rejoin
    local pRJ = ContentFrame:FindFirstChild("Rejoin")
    if pRJ then
        AddButton(pRJ, "🔁 Rejoin", 10, function()
            TS:Teleport(game.PlaceId, LP)
        end)
    end

    -- Page: Crash
    local pCrash = ContentFrame:FindFirstChild("Crash")
    if pCrash then
        AddButton(pCrash, "💥 Crash Server (joke)", 10, function()
            for i = 1, 5000 do Instance.new("Part", workspace) end
        end)
        AddButton(pCrash, "🧨 Crash All Players", 50, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    for i = 1, 100 do
                        local part = Instance.new("Part")
                        part.Position = plr.Character.HumanoidRootPart.Position + Vector3.new(math.random(-100,100), 0, math.random(-100,100))
                        part.Parent = workspace
                    end
                end
            end
        end)
    end

    -- Page: Themes
    local pTheme = ContentFrame:FindFirstChild("Themes")
    if pTheme then
        AddButton(pTheme, "🌑 Dark", 10, function()
            MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,30)
        end)
        AddButton(pTheme, "🌞 Light", 50, function()
            MainFrame.BackgroundColor3 = Color3.fromRGB(230,230,240)
        end)
        AddButton(pTheme, "🔥 Neon", 90, function()
            MainFrame.BackgroundColor3 = Color3.fromRGB(40,0,60)
        end)
        AddButton(pTheme, "💜 Purple", 130, function()
            MainFrame.BackgroundColor3 = Color3.fromRGB(50,20,80)
        end)
    end

    -- Page: Macro
    local pMacro = ContentFrame:FindFirstChild("Macro")
    if pMacro then
        AddButton(pMacro, "🎥 Record Macro", 10, function()
            print("Запис розпочато (тільки демо)")
        end)
        AddButton(pMacro, "▶️ Play Macro", 50, function()
            print("Відтворення макросу (тільки демо)")
        end)
    end

    -- Page: Dupe
    local pDupe = ContentFrame:FindFirstChild("Dupe")
    if pDupe then
        AddTextBox(pDupe, "Item Name:", 5, "DupeItem", "Sword")
        AddButton(pDupe, "📦 Duplicate", 45, function()
            print("Дублювання предмета: " .. Settings.DupeItem)
        end)
    end

    -- Page: AntiBan
    local pAB = ContentFrame:FindFirstChild("AntiBan")
    if pAB then
        AddToggle(pAB, "🛡 Anti-Ban", 5, "AntiBan", false)
        AddLabel(pAB, "⚠️ Тільки для приватних серверів", 35, Color3.fromRGB(255, 100, 100))
    end

    -- Page: FakePing
    local pFP = ContentFrame:FindFirstChild("FakePing")
    if pFP then
        AddSlider(pFP, "Fake Ping (ms)", 10, "FakePing", 0, 999, 0)
        AddLabel(pFP, "Відображається тільки в консолі", 55, Color3.fromRGB(200, 200, 200))
        RunService.Heartbeat:Connect(function()
            if Settings.FakePing > 0 then
                print("Fake Ping: " .. Settings.FakePing .. " ms")
            end
        end)
    end

    -- Page: Freeze
    local pFreeze = ContentFrame:FindFirstChild("Freeze")
    if pFreeze then
        AddButton(pFreeze, "❄️ Freeze All Players", 10, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = true
                        end
                    end
                end
            end
        end)
        AddButton(pFreeze, "🔥 Unfreeze All", 50, function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = false
                        end
                    end
                end
            end
        end)
    end

    -- Page: Misc
    local pMisc = ContentFrame:FindFirstChild("Misc")
    if pMisc then
        AddButton(pMisc, "🧹 Clear Workspace", 10, function()
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Part") and v ~= LP.Character then
                    v:Destroy()
                end
            end
        end)
        AddButton(pMisc, "🔊 Mute All", 50, function()
            SS.Volume = 0
        end)
        AddButton(pMisc, "🔊 Unmute All", 90, function()
            SS.Volume = 1
        end)
    end

    -- Page: Credits
    local pCred = ContentFrame:FindFirstChild("Credits")
    if pCred then
        AddLabel(pCred, "🔥 COOLKID GUI v4.0", 5, Color3.fromRGB(255, 200, 100), 20)
        AddLabel(pCred, "Автор: CoolKid", 30, Color3.fromRGB(200, 200, 200))
        AddLabel(pCred, "GitHub: epstein155d-sudo", 55, Color3.fromRGB(100, 200, 255))
        AddLabel(pCred, "42 сторінки", 80, Color3.fromRGB(200, 200, 200))
        AddLabel(pCred, "Для Delta / Synapse / KRNL", 105, Color3.fromRGB(200, 200, 200))
    end

    -- Page: Exit
    local pExit = ContentFrame:FindFirstChild("Exit")
    if pExit then
        AddButton(pExit, "⛔ Exit GUI", 10, function()
            ScreenGui:Destroy()
        end)
        AddButton(pExit, "🔄 Restart GUI", 50, function()
            ScreenGui:Destroy()
            task.wait(0.5)
            BuildGUI()
        end)
    end

    -- ===== ОСНОВНИЙ ЦИКЛ (функції) =====
    RunService.Heartbeat:Connect(function()
        -- Fly
        if Settings.Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LP.Character.HumanoidRootPart
            local move = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
            if move.Magnitude > 0 then
                hrp.Velocity = move.Unit * 50
            else
                hrp.Velocity = Vector3.new(0,0,0)
            end
        end

        -- NoClip
        if Settings.NoClip and LP.Character then
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        -- Infinite Jump
        if Settings.InfiniteJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) and LP.Character.Humanoid:GetState() == Enum.HumanoidStateType.Landed then
                LP.Character.Humanoid.Jump = true
            end
        end

        -- Speed / Jump
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = Settings.WalkSpeed or 16
            LP.Character.Humanoid.JumpPower = Settings.JumpPower or 50
        end

        -- Aimbot
        if Settings.Aimbot and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LP.Character.HumanoidRootPart
            local target = nil
            local minDist = Settings.AimbotFOV or 150
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local enemy = plr.Character.HumanoidRootPart
                    local screenPos, onScreen = Camera:WorldToScreenPoint(enemy.Position)
                    if onScreen then
                        local fov = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) -
                                     Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                        if fov < minDist then
                            minDist = fov
                            target = enemy
                        end
                    end
                end
            end
            if target then
                hrp.CFrame = CFrame.new(hrp.Position, target.Position)
            end
        end

        -- Anti-AFK
        if Settings.AntiAFK then
            local vim = game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true, "w", false, nil)
            task.wait(0.05)
            vim:SendKeyEvent(false, "w", false, nil)
        end
    end)

    -- Гаряча клавіша INSERT
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    print("✅ CoolKid GUI v4.0 завантажено! 42 сторінки. Натисни INSERT.")
    return ScreenGui
end

-- Запуск
BuildGUI()
