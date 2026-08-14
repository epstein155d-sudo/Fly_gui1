local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Видаляємо старе меню, якщо ти перезапускаєш скрипт
if CoreGui:FindFirstChild("MartinCoolkidGUI") then
    CoreGui.MartinCoolkidGUI:Destroy()
end

-- Створюємо головний екран
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinCoolkidGUI"
ScreenGui.Parent = CoreGui

-- Головне вікно (Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темно-сірий колір
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Червона рамка
MainFrame.Active = true
MainFrame.Draggable = true -- Дозволяє перетягувати меню мишкою або пальцем!
MainFrame.Parent = ScreenGui

-- Заголовок меню
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.Code
Title.Text = "⚡ MARTIN'S COOLKID GUI ⚡"
Title.Parent = MainFrame

-- Кнопка 1: Швидкий біг (Тільки для тебе)
local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.8, 0, 0, 40)
SpeedButton.Position = UDim2.new(0.1, 0, 0.25, 0)
SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedButton.TextColor3 = Color3.fromRGB(0, 255, 100)
SpeedButton.TextSize = 18
SpeedButton.Font = Enum.Font.SourceSansBold
SpeedButton.Text = "Увімкнути Супер Швидкість"
SpeedButton.Parent = MainFrame

SpeedButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

-- Кнопка 2: Високий стрибок (Тільки для тебе)
local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0.8, 0, 0, 40)
JumpButton.Position = UDim2.new(0.1, 0, 0.45, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpButton.TextColor3 = Color3.fromRGB(0, 150, 255)
JumpButton.TextSize = 18
JumpButton.Font = Enum.Font.SourceSansBold
JumpButton.Text = "Увімкнути Мега Стрибок"
JumpButton.Parent = MainFrame

JumpButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = 150
    end
end)

-- Кнопка 3: Закрити меню
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.8, 0, 0, 40)
CloseButton.Position = UDim2.new(0.1, 0, 0.75, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Закрити GUI"
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
--[[
    =========================================
    ⚡ MARTIN'S COOLKID GUI - LOCAL VISUALS ⚡
    =========================================
    Розробник: Мартин
    Версія: 1.0 (GitHub Release)
    Опис: Локальне візуальне меню для розваг
    =========================================
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Видалення старої версії, щоб не було дублікатів
if CoreGui:FindFirstChild("MartinCoolkidHUB") then
    CoreGui.MartinCoolkidHUB:Destroy()
end

-- ==========================================
-- СТВОРЕННЯ ГОЛОВНИХ ЕЛЕМЕНТІВ ІНТЕРФЕЙСУ
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinCoolkidHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local BottomFix = Instance.new("Frame")
BottomFix.Size = UDim2.new(1, 0, 0, 10)
BottomFix.Position = UDim2.new(0, 0, 1, -10)
BottomFix.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BottomFix.BorderSizePixel = 0
BottomFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MARTIN'S COOLKID GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- ==========================================
-- СИСТЕМА ВКЛАДОК (TABS)
-- ==========================================

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 130, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local UIListLayout_Tabs = Instance.new("UIListLayout")
UIListLayout_Tabs.Parent = TabContainer
UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Tabs.Padding = UDim.new(0, 5)

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -130, 1, -40)
ContentContainer.Position = UDim2.new(0, 130, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Функція для створення нових вкладок
local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 14
    TabButton.BorderSizePixel = 0
    TabButton.Parent = TabContainer

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, -20, 1, -20)
    TabPage.Position = UDim2.new(0, 10, 0, 10)
    TabPage.BackgroundTransparency = 1
    TabPage.ScrollBarThickness = 4
    TabPage.Visible = false
    TabPage.Parent = ContentContainer

    local UIListLayout_Page = Instance.new("UIListLayout")
    UIListLayout_Page.Parent = TabPage
    UIListLayout_Page.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Page.Padding = UDim.new(0, 10)

    -- Анімація кнопок вкладок
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentContainer:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        for _, btn in pairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        TabPage.Visible = true
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return TabPage
end

-- ==========================================
-- СТВОРЕННЯ ФУНКЦІЙ (BUTTONS & TOGGLES)
-- ==========================================

local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Button

    -- Ефект при наведенні
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
end

-- Ініціалізація вкладок
local Tab1 = CreateTab("ГРАВЕЦЬ")
local Tab2 = CreateTab("ВІЗУАЛ (СВІТ)")
local Tab3 = CreateTab("ФАН ЕФЕКТИ")

-- Показуємо першу вкладку за замовчуванням
Tab1.Visible = true

-- ==========================================
-- ФУНКЦІЇ: ГРАВЕЦЬ (ТІЛЬКИ ДЛЯ ТЕБЕ)
-- ==========================================

CreateButton(Tab1, "Швидкість x2", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 32
    end
end)

CreateButton(Tab1, "Супер Стрибок", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

CreateButton(Tab1, "Повернути Стандарт (Скинути)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- ==========================================
-- ФУНКЦІЇ: ВІЗУАЛ (АТМОСФЕРА)
-- ==========================================

CreateButton(Tab2, "Страшний Режим (Стиль PETAPETA)", function()
    -- Робить гру локально страшною, темною і з туманом
    Lighting.Ambient = Color3.fromRGB(10, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(10, 0, 0)
    Lighting.FogEnd = 150
    Lighting.FogColor = Color3.fromRGB(20, 0, 0)
    Lighting.ClockTime = 0
end)

CreateButton(Tab2, "Шторм (Стиль Twisted)", function()
    -- Локальний ефект жахливої погоди
    Lighting.Ambient = Color3.fromRGB(50, 60, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(40, 50, 60)
    Lighting.FogEnd = 300
    Lighting.FogColor = Color3.fromRGB(100, 110, 120)
    Lighting.ClockTime = 18
    Lighting.Brightness = 0.5
end)

CreateButton(Tab2, "Ясний День (Скинути Візуал)", function()
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.FogEnd = 100000
    Lighting.ClockTime = 12
    Lighting.Brightness = 1
end)

CreateButton(Tab2, "Увімкнути Локальний X-Ray", function()
    -- Прості матеріали для стін
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
            v.Transparency = 0.7
            v.Material = Enum.Material.ForceField
        end
    end
end)

-- ==========================================
-- ФУНКЦІЇ: ФАН ЕФЕКТИ
-- ==========================================

CreateButton(Tab3, "Почати крутитись (Spin)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local spin = Instance.new("BodyAngularVelocity")
        spin.Name = "CoolkidSpin"
        spin.Parent = char.HumanoidRootPart
        spin.MaxTorque = Vector3.new(0, math.huge, 0)
        spin.AngularVelocity = Vector3.new(0, 20, 0)
    end
end)

CreateButton(Tab3, "Зупинити крутіння", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if char.HumanoidRootPart:FindFirstChild("CoolkidSpin") then
            char.HumanoidRootPart.CoolkidSpin:Destroy()
        end
    end
end)

-- Кнопка закриття меню
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Кінець скрипта. Завантажуй на GitHub!
-- ==========================================
-- ⚡ MARTIN'S COOLKID GUI - ЧАСТИНА 2 ⚡
-- ==========================================

-- Додаємо нові вкладки в наш графічний інтерфейс
local Tab4 = CreateTab("ПОГОДА")
local Tab5 = CreateTab("ЕФЕКТИ АВАТАРА")
local Tab6 = CreateTab("ЗВУКИ")
local Tab7 = CreateTab("НАЛАШТУВАННЯ")

-- ==========================================
-- ФУНКЦІЇ: ВІЗУАЛЬНА ПОГОДА ТА АТМОСФЕРА
-- ==========================================

CreateButton(Tab4, "Червоне Апокаліптичне Небо", function()
    Lighting.Ambient = Color3.fromRGB(150, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 0, 0)
    Lighting.ClockTime = 0
    Lighting.FogEnd = 400
    Lighting.FogColor = Color3.fromRGB(100, 0, 0)
end)

CreateButton(Tab4, "Локальний Торнадо-Шторм", function()
    -- Створення ефекту сильного шторму та туману
    Lighting.ClockTime = 19
    Lighting.Brightness = 0.2
    Lighting.FogEnd = 150
    Lighting.FogColor = Color3.fromRGB(50, 50, 60)

    -- Створення візуального вихору навколо персонажа
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local attachment = Instance.new("Attachment", char.HumanoidRootPart)
        attachment.Name = "TornadoAttachment"

        local particles = Instance.new("ParticleEmitter")
        particles.Name = "TornadoParticles"
        particles.Texture = "rbxassetid://243660364" -- Текстура диму/пилу
        particles.Rate = 100
        particles.Lifetime = NumberRange.new(1, 2)
        particles.Speed = NumberRange.new(15, 30)
        particles.VelocitySpread = 180
        particles.RotSpeed = NumberRange.new(200, 500)
        particles.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 10)})
        particles.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1)})
        particles.Parent = attachment
    end
end)

CreateButton(Tab4, "Прибрати Ефекти Погоди", function()
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.FogEnd = 100000
    Lighting.ClockTime = 12

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local att = char.HumanoidRootPart:FindFirstChild("TornadoAttachment")
        if att then att:Destroy() end
    end
end)

-- ==========================================
-- ФУНКЦІЇ: ЕФЕКТИ ДЛЯ АВАТАРА (RGB І НЕОН)
-- ==========================================

local rgbLooping = false
CreateButton(Tab5, "Увімкнути RGB Переливання Персонажа", function()
    if rgbLooping then return end
    rgbLooping = true

    task.spawn(function()
        while rgbLooping do
            local char = LocalPlayer.Character
            if char then
                local hue = (tick() % 5) / 5
                local color = Color3.fromHSV(hue, 1, 1)

                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Color = color
                        part.Material = Enum.Material.Neon
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end)

CreateButton(Tab5, "Вимкнути RGB Переливання", function()
    rgbLooping = false
    task.wait(0.1)
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
            end
        end
    end
end)

CreateButton(Tab5, "Режим Привида (Локальна Прозорість)", function()
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.5
            end
        end
    end
end)

CreateButton(Tab5, "Відновити Вигляд Персонажа", function()
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0
            end
        end
    end
end)

-- ==========================================
-- ФУНКЦІЇ: ЛОКАЛЬНІ ЗВУКИ (SOUNDBOARD)
-- ==========================================

local function PlayLocalSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = 1
    sound.Parent = CoreGui
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

CreateButton(Tab6, "Звук: Ретро Вибух", function()
    PlayLocalSound("138081509")
end)

CreateButton(Tab6, "Звук: Ретро Лазер", function()
    PlayLocalSound("130138918")
end)

CreateButton(Tab6, "Звук: Перемога / Квест", function()
    PlayLocalSound("5153271739")
end)

-- ==========================================
-- НАЛАШТУВАННЯ ТЕМ ТА УТИЛІТИ
-- ==========================================

CreateButton(Tab7, "Тема: Червоний Coolkid (Класика)", function()
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
    TopBar.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
    Title.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

CreateButton(Tab7, "Тема: Кіберпанк (Синьо-Фіолетова)", function()
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
    Title.TextColor3 = Color3.fromRGB(0, 255, 200)
end)

CreateButton(Tab7, "Тема: Хакер (Матриця)", function()
    MainFrame.BackgroundColor3 = Color3.fromRGB(5, 20, 5)
    TopBar.BackgroundColor3 = Color3.fromRGB(10, 35, 10)
    Title.TextColor3 = Color3.fromRGB(0, 255, 50)
end)

-- Інформаційне поле з версією
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -10, 0, 30)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Martin Coolkid GUI v2.0 | Total Lines: ~500+"
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLabel.Font = Enum.Font.Code
InfoLabel.TextSize = 12
InfoLabel.Parent = Tab7

print("Martin's Coolkid GUI Part 2 успішно завантажено!")
-- ==========================================
-- ⚡ MARTIN'S COOLKID GUI - ЧАСТИНА 3 ⚡
-- ==========================================

local UserInputService = game:GetService("UserInputService")

-- Додаємо нові вкладки
local Tab8 = CreateTab("ПОЛІТ ТА ФІЗИКА")
local Tab9 = CreateTab("МЕТЕО ТА HUD")
local Tab10 = CreateTab("ЕКРАН ТА ШЕЙДЕРИ")
local Tab11 = CreateTab("ТРАНСПОРТ")

-- ==========================================
-- ФУНКЦІЇ: ПОЛІТ ТА КЕРУВАННЯ ФІЗИКОЮ
-- ==========================================

local flying = false
local flySpeed = 50
local bodyVel, bodyGyro

CreateButton(Tab8, "Увімкнути Політ (Fly)", function()
    if flying then return end
    flying = true
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    bodyVel = Instance.new("BodyVelocity")
    bodyVel.Name = "CoolkidFlyVel"
    bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVel.Velocity = Vector3.zero
    bodyVel.Parent = char.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "CoolkidFlyGyro"
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.CFrame = char.HumanoidRootPart.CFrame
    bodyGyro.Parent = char.HumanoidRootPart

    task.spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end

            bodyVel.Velocity = moveDir * flySpeed
            bodyGyro.CFrame = cam.CFrame
        end
    end)
end)

CreateButton(Tab8, "Вимкнути Політ", function()
    flying = false
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if char.HumanoidRootPart:FindFirstChild("CoolkidFlyVel") then
            char.HumanoidRootPart.CoolkidFlyVel:Destroy()
        end
        if char.HumanoidRootPart:FindFirstChild("CoolkidFlyGyro") then
            char.HumanoidRootPart.CoolkidFlyGyro:Destroy()
        end
    end
end)

local noclip = false
CreateButton(Tab8, "Проходження крізь стіни (Noclip)", function()
    noclip = not noclip
    if noclip then
        task.spawn(function()
            while noclip do
                RunService.Stepped:Wait()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
end)

CreateButton(Tab8, "Місячна Гравітація (Локально)", function()
    workspace.Gravity = 30
end)

CreateButton(Tab8, "Нормальна Гравітація", function()
    workspace.Gravity = 196.2
end)

-- ==========================================
-- ФУНКЦІЇ: МЕТЕО-СТАНЦІЯ ТА HUD ДАНІ
-- ==========================================

local HudFrame = nil

CreateButton(Tab9, "Показати Метео & Специфікацію HUD", function()
    if ScreenGui:FindFirstChild("CoolkidHUD") then return end

    HudFrame = Instance.new("Frame")
    HudFrame.Name = "CoolkidHUD"
    HudFrame.Size = UDim2.new(0, 220, 0, 130)
    HudFrame.Position = UDim2.new(0, 20, 0, 20)
    HudFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    HudFrame.BackgroundTransparency = 0.2
    HudFrame.BorderSizePixel = 1
    HudFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
    HudFrame.Parent = ScreenGui

    local HudCorner = Instance.new("UICorner")
    HudCorner.CornerRadius = UDim.new(0, 8)
    HudCorner.Parent = HudFrame

    local HudText = Instance.new("TextLabel")
    HudText.Size = UDim2.new(1, -10, 1, -10)
    HudText.Position = UDim2.new(0, 5, 0, 5)
    HudText.BackgroundTransparency = 1
    HudText.TextColor3 = Color3.fromRGB(0, 255, 200)
    HudText.Font = Enum.Font.Code
    HudText.TextSize = 12
    HudText.TextXAlignment = Enum.TextXAlignment.Left
    HudText.TextYAlignment = Enum.TextYAlignment.Top
    HudText.Parent = HudFrame

    task.spawn(function()
        while HudFrame and HudFrame.Parent do
            local speed = 0
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                speed = math.floor(LocalPlayer.Character.Humanoid.WalkSpeed)
            end
            local grav = math.floor(workspace.Gravity)
            local fps = math.floor(1 / RunService.RenderStepped:Wait())

            HudText.Text = string.format(
                "📊 METEO & STATS HUD\n--------------------\n⚡ FPS: %d\n🏃 Швидкість: %d m/s\n🌍 Гравітація: %d\n🌪️ Вітер: %d km/h\n☁️ Туман: %d m",
                fps, speed, grav, math.random(15, 45), math.floor(Lighting.FogEnd)
            )
        end
    end)
end)

CreateButton(Tab9, "Сховати HUD", function()
    if ScreenGui:FindFirstChild("CoolkidHUD") then
        ScreenGui.CoolkidHUD:Destroy()
    end
end)

-- ==========================================
-- ФУНКЦІЇ: ЕКРАННІ ЕФЕКТИ ТА ШЕЙДЕРИ
-- ==========================================

CreateButton(Tab10, "Нуар / Чорно-Білий Екран", function()
    local cc = Lighting:FindFirstChild("CoolkidCC") or Instance.new("ColorCorrectionEffect")
    cc.Name = "CoolkidCC"
    cc.Saturation = -1
    cc.Contrast = 0.2
    cc.Parent = Lighting
end)

CreateButton(Tab10, "Ретро Відеокасета (VHS / Vintage)", function()
    local cc = Lighting:FindFirstChild("CoolkidCC") or Instance.new("ColorCorrectionEffect")
    cc.Name = "CoolkidCC"
    cc.Saturation = 0.5
    cc.TintColor = Color3.fromRGB(255, 220, 180)
    cc.Contrast = 0.3
    cc.Parent = Lighting
end)

CreateButton(Tab10, "Кінематографічне Розмиття (Blur)", function()
    local blur = Lighting:FindFirstChild("CoolkidBlur") or Instance.new("BlurEffect")
    blur.Name = "CoolkidBlur"
    blur.Size = 12
    blur.Parent = Lighting
end)

CreateButton(Tab10, "Скинути Всі Ефекти Екрану", function()
    if Lighting:FindFirstChild("CoolkidCC") then Lighting.CoolkidCC:Destroy() end
    if Lighting:FindFirstChild("CoolkidBlur") then Lighting.CoolkidBlur:Destroy() end
end)

-- ==========================================
-- ФУНКЦІЇ: ТРАНСПОРТ ТА СПЕЦЕФЕКТИ
-- ==========================================

CreateButton(Tab11, "Локальний Неон Під Днище Авто", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        local car = seat.Parent
        if car then
            local light = Instance.new("PointLight")
            light.Name = "CoolkidUnderglow"
            light.Color = Color3.fromRGB(0, 255, 255)
            light.Range = 25
            light.Brightness = 5
            light.Parent = seat
        end
    end
end)

CreateButton(Tab11, "Прискорити Поточне Крісло/Машину", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
        local seat = char.Humanoid.SeatPart
        if seat:IsA("VehicleSeat") then
            seat.MaxSpeed = 200
            seat.Torque = 10
        end
    end
end)

print("Martin's Coolkid GUI Part 3 успішно додано!")
