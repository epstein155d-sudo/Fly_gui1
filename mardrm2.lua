-- ==========================================
-- Martin Hub | Murder Mystery 2 (Ultra Precision)
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔪 Martin Hub | Murder Mystery 2 🎯",
   LoadingTitle = "Завантаження MM2 Precision Hub...",
   LoadingSubtitle = "by Martin",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Сервіси
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Змінні для збереження ролей
local Roles = { Murderer = nil, Sheriff = nil }
local Flags = {
    MurderESP = false,
    SheriffESP = false,
    GunESP = false,
    Fullbright = false,
    AutoCoin = false,
    Speed = 16,
    Noclip = false
}

-- Пошук ролей
local function UpdateRoles()
    Roles.Murderer = nil
    Roles.Sheriff = nil
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local backpack = plr:FindFirstChild("Backpack")
            if (char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))) then
                Roles.Murderer = plr
            elseif (char:FindFirstChild("Revolver") or (backpack and backpack:FindFirstChild("Revolver")) or char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))) then
                Roles.Sheriff = plr
            end
        end
    end
end

-- ==========================================
-- Створення Floating GUI (Кнопка Стрільби)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinMM2ShootGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Enabled = false

local ShootFrame = Instance.new("Frame")
ShootFrame.Size = UDim2.new(0, 160, 0, 50)
ShootFrame.Position = UDim2.new(0.7, 0, 0.5, 0)
ShootFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ShootFrame.BorderSizePixel = 2
ShootFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
ShootFrame.Active = true
ShootFrame.Draggable = true
ShootFrame.Parent = ScreenGui

local ShootBtn = Instance.new("TextButton")
ShootBtn.Size = UDim2.new(0.75, 0, 1, 0)
ShootBtn.Position = UDim2.new(0, 0, 0, 0)
ShootBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShootBtn.Text = "🎯 SHOOT"
ShootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShootBtn.TextSize = 18
ShootBtn.Font = Enum.Font.SourceSansBold
ShootBtn.Parent = ShootFrame

local LockBtn = Instance.new("TextButton")
LockBtn.Size = UDim2.new(0.25, 0, 1, 0)
LockBtn.Position = UDim2.new(0.75, 0, 0, 0)
LockBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LockBtn.Text = "🔓"
LockBtn.TextSize = 18
LockBtn.Parent = ShootFrame

local isLocked = false
LockBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    if isLocked then
        ShootFrame.Draggable = false
        LockBtn.Text = "🔒"
        LockBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        ShootFrame.Draggable = true
        LockBtn.Text = "🔓"
        LockBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- ==========================================
-- 🎯 НАДТОЧНА СИСТЕМА СТРІЛЬБИ (ULTRA AIM)
-- ==========================================
local function ShootAtMurderer()
    UpdateRoles()
    local target = Roles.Murderer
    local myChar = LocalPlayer.Character
    
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local gun = myChar:FindFirstChild("Revolver") or myChar:FindFirstChild("Gun")
        if not gun then
            local backpackGun = LocalPlayer.Backpack:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Gun")
            if backpackGun then
                backpackGun.Parent = myChar
                gun = backpackGun
                task.wait(0.05) -- Мікро-затримка для витягування
            end
        end

        if gun then
            local targetHRP = target.Character.HumanoidRootPart
            local targetVel = targetHRP.Velocity
            
            -- Розрахунок точки перехоплення (Prediction Vector)
            local bulletSpeed = 250 -- Висока швидкість кулі для точного попаданння
            local distance = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
            local timeToHit = distance / bulletSpeed
            
            -- Враховуємо навіть стрибок по осі Y
            local predictedPos = targetHRP.Position + (targetVel * timeToHit) + Vector3.new(0, targetVel.Y * (timeToHit * 0.5), 0)

            -- Повертаємо персонажа точно на Мардера
            myChar.HumanoidRootPart.CFrame = CFrame.new(myChar.HumanoidRootPart.Position, Vector3.new(predictedPos.X, myChar.HumanoidRootPart.Position.Y, predictedPos.Z))

            -- Активація зброї
            gun:Activate()

            -- Пряма відправка координат у віддалені події гри
            pcall(function()
                if gun:FindFirstChild("Shoot") then
                    gun.Shoot:FireServer(predictedPos)
                end
                if gun:FindFirstChild("KnifeServer") then
                    gun.KnifeServer.ShootGun:FireServer(predictedPos)
                end
                local remote = gun:FindFirstChildOfClass("RemoteEvent")
                if remote then
                    remote:FireServer(predictedPos)
                end
            end)

            Rayfield:Notify({Title = "🎯 Постріл!", Content = "Куля точно в цілі!", Duration = 1.5})
        else
            Rayfield:Notify({Title = "⚠️ Помилка", Content = "У тебе немає пістолета!", Duration = 2})
        end
    else
        Rayfield:Notify({Title = "⚠️ Увага", Content = "Вбивцю не знайдено!", Duration = 2})
    end
end

ShootBtn.MouseButton1Click:Connect(function()
    ShootAtMurderer()
end)

-- ==========================================
-- Вкладки Меню
-- ==========================================
local TabVisuals = Window:CreateTab("👁️ Visuals & ESP", 4483362458)
local TabCombat = Window:CreateTab("🛡️ Захист & Бій", 4483362458)
local TabFarm = Window:CreateTab("🪙 Авто-Фарм", 4483362458)
local TabTeleport = Window:CreateTab("📍 Телепорти", 4483362458)
local TabMovement = Window:CreateTab("⚡ Рух", 4483362458)

-- 👁️ Visuals
TabVisuals:CreateToggle({
   Name = "🔴 Murderer ESP (Підсвітка Вбивці)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.MurderESP = Value
      task.spawn(function()
         while Flags.MurderESP do
            UpdateRoles()
            if Roles.Murderer and Roles.Murderer.Character then
               local char = Roles.Murderer.Character
               if not char:FindFirstChild("MurdererHL") then
                  local hl = Instance.new("Highlight")
                  hl.Name = "MurdererHL"
                  hl.FillColor = Color3.fromRGB(255, 0, 0)
                  hl.Parent = char
               end
            end
            task.wait(1)
         end
         if not Flags.MurderESP and Roles.Murderer and Roles.Murderer.Character and Roles.Murderer.Character:FindFirstChild("MurdererHL") then
            Roles.Murderer.Character.MurdererHL:Destroy()
         end
      end)
   end,
})

TabVisuals:CreateToggle({
   Name = "🔵 Sheriff ESP (Підсвітка Шерифа)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.SheriffESP = Value
      task.spawn(function()
         while Flags.SheriffESP do
            UpdateRoles()
            if Roles.Sheriff and Roles.Sheriff.Character then
               local char = Roles.Sheriff.Character
               if not char:FindFirstChild("SheriffHL") then
                  local hl = Instance.new("Highlight")
                  hl.Name = "SheriffHL"
                  hl.FillColor = Color3.fromRGB(0, 100, 255)
                  hl.Parent = char
               end
            end
            task.wait(1)
         end
      end)
   end,
})

TabVisuals:CreateToggle({
   Name = "💡 Fullbright (Яскравість)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.Fullbright = Value
      Lighting.Ambient = Value and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(127, 127, 127)
   end,
})

-- 🛡️ Combat
TabCombat:CreateToggle({
   Name = "🎯 Shoot Murderer (Викликати Кнопку на екран)",
   CurrentValue = false,
   Callback = function(Value)
      ScreenGui.Enabled = Value
   end,
})

-- 🪙 Farm
TabFarm:CreateToggle({
   Name = "🪙 Smart Coin Farm (Авто-збір монеток)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoCoin = Value
      task.spawn(function()
         while Flags.AutoCoin do
            task.wait(0.2)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local coinContainer = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("CoinServer")
                if coinContainer then
                    for _, coin in pairs(coinContainer:GetChildren()) do
                        if Flags.AutoCoin and coin:IsA("BasePart") then
                            char.HumanoidRootPart.CFrame = coin.CFrame
                            task.wait(0.15)
                        end
                    end
                end
            end
         end
      end)
   end,
})

-- 📍 Teleports
TabTeleport:CreateButton({
   Name = "🔫 Teleport to Dropped Gun",
   Callback = function()
      local gunDrop = Workspace:FindFirstChild("GunDrop") or Workspace:FindFirstChild("NormalGunDrop")
      if gunDrop and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character.HumanoidRootPart.CFrame = gunDrop.CFrame + Vector3.new(0, 3, 0)
      else
         Rayfield:Notify({Title = "MM2 Hub", Content = "Пістолет ще не випав!", Duration = 2})
      end
   end,
})

-- ⚡ Movement
TabMovement:CreateSlider({
   Name = "🏃 Швидкість бігу",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      Flags.Speed = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

TabMovement:CreateToggle({
   Name = "👻 Noclip (Крізь стіни)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.Noclip = Value
      RunService.Stepped:Connect(function()
         if Flags.Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = false end
            end
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "🎯 Martin Hub Precision",
   Content = "Скрипт готовий! Тепер куля гасить Вбивцю в стрибку!",
   Duration = 4,
   Image = 4483362458,
})
