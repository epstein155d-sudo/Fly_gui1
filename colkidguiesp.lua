--[[
    COOLKID GUI + ESP v3.0 (Delta/Synapse/KRNL)
    Только локальный рендер через CoreGui
    Другие игроки НЕ видят
    Нажми INSERT для открытия/закрытия меню
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

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
    AntiAFK = false
}

-- ===== GUI СОЗДАНИЕ =====
local function MakeGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CoolKidGUI"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 100, 200)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "🔥 COOLKID MENU v3.0"
    title.TextColor3 = Color3.fromRGB(255, 100, 200)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui.Enabled = not screenGui.Enabled
    end)

    -- Контейнер для вкладок
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 30)
    tabContainer.Position = UDim2.new(0, 0, 0, 30)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    local tabs = {"Main", "Combat", "Movement", "Visuals", "Misc"}
    local tabButtons = {}
    local currentTab = "Main"

    -- Контент
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -10, 1, -70)
    contentFrame.Position = UDim2.new(0, 5, 0, 65)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Создание табов
    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 80, 1, 0)
        btn.Position = UDim2.new(0, (i-1)*82, 0, 0)
        btn.BackgroundColor3 = (name == currentTab) and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(40, 40, 60)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = tabContainer
        tabButtons[name] = btn
    end

    -- ===== ФУНКЦИИ СОЗДАНИЯ КОНТРОЛОВ =====
    local function ClearContent()
        for _, child in pairs(contentFrame:GetChildren()) do
            child:Destroy()
        end
    end

    local function AddLabel(text, y, color, size)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 20)
        lbl.Position = UDim2.new(0, 0, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
        lbl.TextScaled = false
        lbl.TextSize = size or 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = contentFrame
        return lbl
    end

    local function AddToggle(label, y, key, default)
        local state = default or false
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 25)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = contentFrame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 20, 0, 20)
        btn.Position = UDim2.new(0, 0, 0, 2)
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        btn.Text = ""
        btn.Parent = frame

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -25, 1, 0)
        lbl.Position = UDim2.new(0, 25, 0, 0)
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

    local function AddSlider(label, y, key, min, max, default)
        local val = default or min
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 40)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = contentFrame

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.6, 0, 0, 20)
        lbl.BackgroundTransparency = 1
        lbl.Text = label .. ": " .. tostring(val)
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        lbl.TextSize = 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0.6, 0, 0, 6)
        bar.Position = UDim2.new(0, 0, 0, 25)
        bar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        bar.Parent = frame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((val-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
        fill.Parent = bar

        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(0.2, 0, 0, 20)
        valLbl.Position = UDim2.new(0.65, 0, 0, 0)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(val)
        valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        valLbl.TextSize = 14
        valLbl.Font = Enum.Font.Gotham
        valLbl.Parent = frame

        -- Слайдер через кнопку (упрощённо)
        local sliderBtn = Instance.new("TextButton")
        sliderBtn.Size = UDim2.new(0.6, 0, 0, 20)
        sliderBtn.Position = UDim2.new(0, 0, 0, 18)
        sliderBtn.BackgroundTransparency = 1
        sliderBtn.Text = ""
        sliderBtn.Parent = frame

        local dragging = false
        sliderBtn.MouseButton1Down:Connect(function()
            dragging = true
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
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

    local function AddButton(label, y, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.4, 0, 0, 25)
        btn.Position = UDim2.new(0, 0, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
        btn.Text = label
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.Parent = contentFrame
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- ===== ЗАГРУЗКА ВКЛАДОК =====
    local function LoadTab(name)
        ClearContent()
        if name == "Main" then
            AddLabel("Добро пожаловать, " .. LP.Name, 5, Color3.fromRGB(255, 100, 200), 18)
            AddLabel("Статус: Активен", 30, Color3.fromRGB(0, 255, 100), 14)
            AddButton("Teleport to Center", 60, function()
                if LP.Character then
                    LP.Character.HumanoidRootPart.Position = Vector3.new(0, 10, 0)
                end
            end)
            AddButton("Kill All Mobs", 95, function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        v.Humanoid.Health = 0
                    end
                end
            end)
            AddToggle("Anti-AFK", 135, "AntiAFK", false)
        elseif name == "Combat" then
            AddToggle("Aimbot", 5, "Aimbot", false)
            AddSlider("Aimbot FOV", 45, "AimbotFOV", 50, 400, 150)
            AddToggle("Silent Aim", 90, "SilentAim", false)
            AddButton("Trigger Bot", 130, function()
                print("TriggerBot активирован (имитация)")
            end)
        elseif name == "Movement" then
            AddToggle("Fly", 5, "Fly", false)
            AddToggle("NoClip", 45, "NoClip", false)
            AddToggle("Infinite Jump", 85, "InfiniteJump", false)
            AddSlider("WalkSpeed", 125, "WalkSpeed", 10, 100, 16)
            AddSlider("JumpPower", 170, "JumpPower", 20, 200, 50)
        elseif name == "Visuals" then
            AddToggle("ESP (Players)", 5, "ESP", false)
            AddToggle("Show Names", 45, "ShowNames", true)
            AddToggle("Show Health", 85, "ShowHealth", true)
            AddToggle("Show Distance", 125, "ShowDistance", true)
            AddSlider("ESP Color R", 165, "ESPColorR", 0, 255, 0)
            AddSlider("ESP Color G", 210, "ESPColorG", 0, 255, 255)
            AddSlider("ESP Color B", 255, "ESPColorB", 0, 255, 0)
        elseif name == "Misc" then
            AddToggle("Anti-AFK", 5, "AntiAFK", false)
            AddToggle("Auto Farm", 45, "AutoFarm", false)
            AddButton("Rejoin Server", 85, function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
            end)
            AddButton("Clear Chat", 120, function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("BillboardGui") then v:Destroy() end
                end
            end)
            AddButton("Crash Server (joke)", 155, function()
                for i = 1, 5000 do Instance.new("Part", workspace) end
            end)
        end
    end

    -- Переключение табов
    for name, btn in pairs(tabButtons) do
        btn.MouseButton1Click:Connect(function()
            currentTab = name
            for n, b in pairs(tabButtons) do
                b.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(40, 40, 60)
            end
            LoadTab(name)
        end)
    end

    LoadTab("Main")

    -- Горячая клавиша INSERT
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            screenGui.Enabled = not screenGui.Enabled
        end
    end)

    return screenGui, mainFrame
end

local GUI, MainFrame = MakeGUI()

-- ===== ESP (рисуем через BillboardGui) =====
local ESPObjects = {}

local function CreateESP(player)
    if player == LP then return end
    if ESPObjects[player] then return end
    local character = player.Character
    if not character or not character:FindFirstChild("Head") then return end
    local head = character.Head

    local bill = Instance.new("BillboardGui")
    bill.Adornee = head
    bill.Size = UDim2.new(0, 200, 0, 60)
    bill.StudsOffset = Vector3.new(0, 2.5, 0)
    bill.MaxDistance = 500
    bill.AlwaysOnTop = true
    bill.Parent = head

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Settings.ESPColor
    frame.Parent = bill

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Settings.ESPColor
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = frame

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0.6, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.4, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = ""
    infoLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = frame

    ESPObjects[player] = {
        Bill = bill,
        Frame = frame,
        NameLabel = nameLabel,
        InfoLabel = infoLabel,
        Humanoid = character:FindFirstChild("Humanoid")
    }
end

local function UpdateESP()
    for player, data in pairs(ESPObjects) do
        if not player or not player.Character or not data.Humanoid or data.Humanoid.Health <= 0 then
            if data.Bill then data.Bill:Destroy() end
            ESPObjects[player] = nil
            continue
        end
        local humanoid = data.Humanoid
        local health = math.floor(humanoid.Health)
        local maxHealth = humanoid.MaxHealth
        local hpPercent = health / maxHealth
        local hpColor = Color3.fromRGB(255 * (1 - hpPercent), 255 * hpPercent, 0)

        data.Frame.BorderColor3 = Settings.ESPColor
        data.NameLabel.TextColor3 = Settings.ESPColor
        data.NameLabel.Text = Settings.ShowNames and player.Name or ""

        local dist = (Camera.CFrame.Position - data.Bill.Adornee.Position).Magnitude
        local info = ""
        if Settings.ShowHealth then info = info .. "❤️ " .. health .. "/" .. maxHealth end
        if Settings.ShowDistance then
            if info ~= "" then info = info .. "  " end
            info = info .. "📏 " .. math.round(dist) .. " ст."
        end
        data.InfoLabel.Text = info
        data.InfoLabel.TextColor3 = hpColor
        data.Bill.Enabled = Settings.ESP
    end
end

-- Добавление/удаление игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.3)
        CreateESP(player)
    end)
end)
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] and ESPObjects[player].Bill then
        ESPObjects[player].Bill:Destroy()
    end
    ESPObjects[player] = nil
end)

for _, player in pairs(Players:GetPlayers()) do
    task.wait(0.1)
    CreateESP(player)
end

-- ===== ОСНОВНОЙ ЦИКЛ =====
RunService.Heartbeat:Connect(function()
    -- Fly
    if Settings.Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local move = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector * Vector3.new(1, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector * Vector3.new(1, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then
            hrp.Velocity = move.Unit * 50
        else
            hrp.Velocity = Vector3.new(0, 0, 0)
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
        local hum = LP.Character.Humanoid
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum:GetState() == Enum.HumanoidStateType.Landed then
            hum.Jump = true
        end
    end

    -- WalkSpeed / JumpPower
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        LP.Character.Humanoid.JumpPower = Settings.JumpPower
    end

    -- Aimbot (базовый)
    if Settings.Aimbot and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local target = nil
        local minDist = Settings.AimbotFOV
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
        task.wait(0.1)
        vim:SendKeyEvent(false, "w", false, nil)
    end

    -- ESP Обновление
    UpdateESP()
end)

print("✅ COOLKID GUI + ESP загружен! Нажми INSERT для открытия.")
