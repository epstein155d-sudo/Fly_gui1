-- Завантаження бібліотеки Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Створення головного вікна Hub
local Window = Rayfield:CreateWindow({
   Name = "The Long Road Hub | tld.lua",
   LoadingTitle = "Завантаження TLD Hub...",
   LoadingSubtitle = "by Martin",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "TLDConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- Допоміжні змінні
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Налаштування параметрів
local WalkSpeedValue = 16
local JumpPowerValue = 50
local NoclipEnabled = false
local VehicleSpeedValue = 50
local VehicleSpeedEnabled = false

-- ========================================================
-- ВКЛАДКА 1: АВТОМОБІЛЬ
-- ========================================================
local CarTab = Window:CreateTab("🚗 Автомобіль", 4483362458)

local CarSpeedSlider = CarTab:CreateSlider({
   Name = "Швидкість авто",
   Range = {10, 300},
   Increment = 5,
   Suffix = "Шв.",
   CurrentValue = 50,
   Flag = "CarSpeed",
   Callback = function(Value)
      VehicleSpeedValue = Value
   end,
})

local CarSpeedToggle = CarTab:CreateToggle({
   Name = "Увімкнути прискорення авто",
   CurrentValue = false,
   Flag = "CarSpeedToggle",
   Callback = function(Value)
      VehicleSpeedEnabled = Value
   end,
})

CarTab:CreateButton({
   Name = "Полагодити/Заправити авто (Базовий чит)",
   Callback = function()
      -- Знаходимо машину, у якій сидить гравець
      local character = LocalPlayer.Character
      if character and character:FindFirstChild("Humanoid") then
         local seat = character.Humanoid.SeatPart
         if seat and seat:IsA("VehicleSeat") then
            local car = seat.Parent
            -- Скидаємо пошкодження або заповнюємо атрибути, якщо вони є у моделі
            if car:FindFirstChild("Health") then
               car.Health.Value = 100
            end
            Rayfield:Notify({
               Title = "Успіх!",
               Content = "Спроба ремонту/заправки виконана.",
               Duration = 3,
               Image = 4483362458,
            })
         else
            Rayfield:Notify({
               Title = "Помилка",
               Content = "Ви повинні сидіти в кріслі водія!",
               Duration = 3,
               Image = 4483362458,
            })
         end
      end
   end,
})

-- ========================================================
-- ВКЛАДКА 2: ПЕРСОНАЖ
-- ========================================================
local PlayerTab = Window:CreateTab("👤 Персонаж", 4483362458)

local SpeedSlider = PlayerTab:CreateSlider({
   Name = "Швидкість бігу",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Шв.",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      WalkSpeedValue = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpSlider = PlayerTab:CreateSlider({
   Name = "Висота стрибка",
   Range = {50, 300},
   Increment = 5,
   Suffix = "Сила",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      JumpPowerValue = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.UseJumpPower = true
         LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

local NoclipToggle = PlayerTab:CreateToggle({
   Name = "Проходження крізь стіни (Noclip)",
   CurrentValue = false,
   Flag = "Noclip",
   Callback = function(Value)
      NoclipEnabled = Value
   end,
})

-- ========================================================
-- ВКЛАДКА 3: ВІЗУАЛ (ESP)
-- ========================================================
local VisualsTab = Window:CreateTab("👁️ Візуал (ESP)", 4483362458)

VisualsTab:CreateButton({
   Name = "Підсвітити інших гравців (ESP)",
   Callback = function()
      for _, player in pairs(Players:GetPlayers()) do
         if player ~= LocalPlayer and player.Character and not player.Character:FindFirstChild("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
         end
      end
      Rayfield:Notify({
         Title = "ESP",
         Content = "Гравців підсвічено!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ========================================================
-- ОСНОВНІ ЦИКЛИ (MAIN LOOPS)
-- ========================================================

-- Цикл для Noclip та швидкості авто
RunService.Stepped:Connect(function()
   -- Noclip
   if NoclipEnabled and LocalPlayer.Character then
      for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
         if part:IsA("BasePart") then
            part.CanCollide = false
         end
      end
   end

   -- Прискорення машини
   if VehicleSpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      local seat = LocalPlayer.Character.Humanoid.SeatPart
      if seat and seat:IsA("VehicleSeat") then
         seat.AssemblyLinearVelocity = seat.CFrame.LookVector * VehicleSpeedValue
      end
   end
end)

-- Автоматичне застосування швидкості при респавні
LocalPlayer.CharacterAdded:Connect(function(char)
   char:WaitForChild("Humanoid")
   char.Humanoid.WalkSpeed = WalkSpeedValue
   char.Humanoid.UseJumpPower = true
   char.Humanoid.JumpPower = JumpPowerValue
end)

Rayfield:Notify({
   Title = "TLD Hub",
   Content = "Скрипт успішно завантажено!",
   Duration = 5,
   Image = 4483362458,
})
