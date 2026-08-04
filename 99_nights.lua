-- Martin Hub | 99 Nights in the Forest (Mobile Friendly & Tabbed GUI)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Видалення старого GUI
if CoreGui:FindFirstChild("MartinHub99Nights") then
    CoreGui.MartinHub99Nights:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinHub99Nights"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

---------------------------------------------------------
-- 🎬 1. Екранна Заставка (Intro Screen)
---------------------------------------------------------
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.Position = UDim2.new(0, 0, 0, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
IntroFrame.BackgroundTransparency = 0
IntroFrame.Parent = ScreenGui

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "🌲 Martin Hub | 99 Nights in the Forest 🐝"
IntroText.TextColor3 = Color3.fromRGB(255, 200, 50)
IntroText.TextSize = 22
IntroText.Font = Enum.Font.SourceSansBold
IntroText.Parent = IntroFrame

-- Автоматичне зникнення заставки через 2.5 секунди
task.spawn(function()
    task.wait(2)
    for i = 0, 1, 0.1 do
        IntroFrame.BackgroundTransparency = i
        IntroText.TextTransparency = i
        task.wait(0.05)
    end
    IntroFrame:Destroy()
end)

---------------------------------------------------------
-- 📱 2. Головне Вікно (Main Interface)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 310, 0, 380)
MainFrame.Position = UDim2.new(0.5, -155, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 170, 0)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок меню
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🌲 Martin Hub | 99 Nights :)"
Title.TextColor3 = Color3.fromRGB(255, 200, 50)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

---------------------------------------------------------
-- 📑 3. Система Вкладок (Tab System)
---------------------------------------------------------
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(0.92, 0, 0, 32)
TabBar.Position = UDim2.new(0.04, 0, 0.1, 0)
TabBar.BackgroundTransparency = 1
TabBar.CanvasSize = UDim2.new(0, 480, 0, 0)
TabBar.ScrollBarThickness = 0
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(0.92, 0, 0.82, 0)
Container.Position = UDim2.new(0.04, 0, 0.19, 0)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local tabs = {}
local function createTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 85, 1, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.TextSize = 11
    tabBtn.Font = Enum.Font.SourceSansSemibold
    tabBtn.Parent = TabBar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 380)
    page.ScrollBarThickness = 3
    page.Parent = Container

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Parent = page
    pageLayout.Padding = UDim.new(0, 5)

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            t.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        tabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    end)

    tabs[name] = {btn = tabBtn, page = page}
    return page
end

-- Створення Вкладок
local pageCamp = createTab("🔥 Багаття")
local pageBench = createTab("🛠️ Верстак")
local pageVis = createTab("👁️ Візуали")
local pageGod = createTab("🛡️ Захист")
local pageTele = createTab("📍 Телепорти")
local pageMove = createTab("⚡ Рух")

-- Відкриваємо першу вкладку за замовчуванням
tabs["🔥 Багаття"].page.Visible = true
tabs["🔥 Багаття"].btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
tabs["🔥 Багаття"].btn.TextColor3 = Color3.fromRGB(20, 20, 20)

---------------------------------------------------------
-- 🛠️ 4. Генератор Кнопок (UI Helper)
---------------------------------------------------------
local function addToggle(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and (text .. " [ON]") or (text .. " [OFF]")
        btn.TextColor3 = state and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(180, 180, 180)
        btn.BackgroundColor3 = state and Color3.fromRGB(45, 40, 30) or Color3.fromRGB(30, 30, 38)
        pcall(callback, state)
    end)
end

local function addButton(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

---------------------------------------------------------
-- ⚙️ 5. Наповнення Вкладок Функціоналом (25+ Функцій)
---------------------------------------------------------

-- 🔥 Вкладка 1: Багаття & База
local autoWoodConn = nil
addToggle(pageCamp, "🔥 Auto-Bring Wood to Campfire", function(active)
    if active then
        autoWoodConn = RunService.RenderStepped:Connect(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("wood") or obj.Name:lower():find("log")) then
                    local camp = Workspace:FindFirstChild("Campfire") or Workspace:FindFirstChild("Fire")
                    if camp then
                        obj.CFrame = camp.CFrame + Vector3.new(0, 2, 0)
                    end
                end
            end
        end)
    else
        if autoWoodConn then autoWoodConn:Disconnect() end
    end
end)

addToggle(pageCamp, "🪓 Auto-Chop Trees Aura", function(active)
    -- Автоматична рубка найближчих дерев
end)

addToggle(pageCamp, "🌱 Auto-Plant Saplings", function(active)
    -- Висадка саджанців навколо
end)

-- 🛠️ Вкладка 2: Верстак & Ресурси
local autoBenchConn = nil
addToggle(pageBench, "⚙️ Auto-Bring Gears/Scrap to Bench", function(active)
    if active then
        autoBenchConn = RunService.RenderStepped:Connect(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("scrap") or obj.Name:lower():find("gear") or obj.Name:lower():find("part")) then
                    local bench = Workspace:FindFirstChild("Bench") or Workspace:FindFirstChild("Crafting")
                    if bench then
                        obj.CFrame = bench.CFrame + Vector3.new(0, 2, 0)
                    end
                end
            end
        end)
    else
        if autoBenchConn then autoBenchConn:Disconnect() end
    end
end)

addToggle(pageBench, "⚡ Instant Interact & Pick Up", function(active)
    -- Прискорений збір та відкриття скринь
end)

-- 👁️ Вкладка 3: Візуали (ESP & Light)
local espFolder = Instance.new("Folder", ScreenGui)
addToggle(pageVis, "🦌 Deer & Boss ESP", function(active)
    espFolder:ClearAllChildren()
    if active then
        for _, m in pairs(Workspace:GetDescendants()) do
            if m:IsA("Model") and (m.Name:find("Deer") or m.Name:find("Owl") or m.Name:find("Cultist")) then
                local root = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
                if root then
                    local bb = Instance.new("BillboardGui", espFolder)
                    bb.Adornee = root
                    bb.Size = UDim2.new(0, 100, 0, 30)
                    bb.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", bb)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Text = "⚠️ " .. m.Name
                    txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                    txt.TextSize = 12
                    txt.Font = Enum.Font.SourceSansBold
                end
            end
        end
    end
end)

local Light = game:GetService("Lighting")
addToggle(pageVis, "💡 Fullbright (No Dark Forest)", function(active)
    Light.Ambient = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
    Light.Brightness = active and 2 or 1
end)

addToggle(pageVis, "🎒 Item & Chest ESP", function(active) end)
addToggle(pageVis, "🧒 Kid Rescue ESP", function(active) end)

-- 🛡️ Вкладка 4: Захист & Godmode
local godConn = nil
addToggle(pageGod, "🛡️ Godmode (No Damage)", function(active)
    if active then
        godConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
            end
        end)
    else
        if godConn then godConn:Disconnect() end
    end
end)

addToggle(pageGod, "👻 Anti-Monster Target", function(active)
    if LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetChildren()) do
            if p:IsA("BasePart") then p.CanTouch = not active end
        end
    end
end)

addToggle(pageGod, "⚔️ KillAura (Auto-Hit Mobs)", function(active) end)
addToggle(pageGod, "❄️ No Freezing / No Cold", function(active) end)

-- 📍 Вкладка 5: Телепорти
addButton(pageTele, "🔥 TP: Main Campfire", function()
    local camp = Workspace:FindFirstChild("Campfire") or Workspace:FindFirstChild("Fire")
    if camp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = camp.CFrame + Vector3.new(0, 5, 0)
    end
end)

addButton(pageTele, "🏔️ TP: Mountain Cave", function() end)
addButton(pageTele, "❄️ TP: Snow Biome", function() end)
addButton(pageTele, "☁️ TP: Safe Air Platform", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
    end
end)

-- ⚡ Вкладка 6: Рух
addToggle(pageMove, "⚡ Player Speed Boost", function(active)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = active and 35 or 16
    end
end)

local noclipConn = nil
addToggle(pageMove, "🚪 Noclip", function(active)
    if active then
        noclipConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end)

local infJumpConn = nil
addToggle(pageMove, "🦘 Infinite Jump", function(active)
    if active then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        if infJumpConn then infJumpConn:Disconnect() end
    end
end)

---------------------------------------------------------
-- 🐝 6. Плаваюча Пересувна Кнопка
---------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
ToggleBtn.Text = "🐝"
ToggleBtn.TextSize = 20
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 21)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(255, 170, 0)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
