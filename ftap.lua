-- Fling Things and People | Ultimate Martin Hub (Rayfield UI)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎯 Martin Hub | Fling Things & People 🐝",
   LoadingTitle = "Martin Hub | FTAP Loading...",
   LoadingSubtitle = "by Martin",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "MartinHubFTAP"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = false
   },
   KeySystem = false
})

---------------------------------------------------------
-- 🤾‍♂️ Вкладка 1: Super Fling & Grab Mods
---------------------------------------------------------
local TabFling = Window:CreateTab("🤾‍♂️ Супер Кидок", 4483362458)

local flingPower = 10 -- Дефолтне значення

local SliderPower = TabFling:CreateSlider({
   Name = "🚀 Сила кидка (Throw Power)",
   Range = {1, 100},
   Increment = 1,
   Suffix = "x Power",
   CurrentValue = 10,
   Flag = "FlingPowerSlider",
   Callback = function(Value)
       flingPower = Value
   end,
})

local ToggleSuperThrow = TabFling:CreateToggle({
   Name = "💥 Увімкнути Mega Fling / Throw Multiplier",
   CurrentValue = false,
   Flag = "SuperThrowToggle",
   Callback = function(Value)
       _G.SuperThrow = Value
       task.spawn(function()
           while _G.SuperThrow do
               task.wait(0.1)
               pcall(function()
                   -- Посилення сили імпульсу при випусканні/кидку об'єкта або гравця
                   local char = game.Players.LocalPlayer.Character
                   if char then
                       for _, tool in pairs(char:GetChildren()) do
                           if tool:IsA("Tool") or tool.Name:lower():find("grab") then
                               -- Застосування помножувача сили
                               if tool:FindFirstChild("BodyVelocity") then
                                   tool.BodyVelocity.Velocity = tool.BodyVelocity.Velocity * (flingPower / 2)
                               end
                           end
                       end
                   end
               end)
           end
       end)
   end,
})

local ToggleReach = TabFling:CreateToggle({
   Name = "📏 Нескінченна дистанція хвата (Infinite Grab Reach)",
   CurrentValue = false,
   Flag = "InfiniteReachToggle",
   Callback = function(Value)
       _G.InfReach = Value
       task.spawn(function()
           while _G.InfReach do
               task.wait(0.2)
               pcall(function()
                   local grabber = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                   if grabber and grabber:FindFirstChild("Controls") then
                       grabber.Controls.MaxDistance.Value = 9999
                   end
               end)
           end
       end)
   end,
})

---------------------------------------------------------
-- 🛡️ Вкладка 2: Anti-Grab & Defence
---------------------------------------------------------
local TabDef = Window:CreateTab("🛡️ Захист", 4483362458)

local ToggleAntiGrab = TabDef:CreateToggle({
   Name = "🔰 Anti-Grab (Неможливо схопити тебе)",
   CurrentValue = false,
   Flag = "AntiGrabToggle",
   Callback = function(Value)
       _G.AntiGrab = Value
       task.spawn(function()
           while _G.AntiGrab do
               task.wait(0.1)
               pcall(function()
                   local char = game.Players.LocalPlayer.Character
                   if char and char:FindFirstChild("HumanoidRootPart") then
                       for _, child in pairs(char:GetChildren()) do
                           if child.Name == "GrabWeld" or child.Name:find("Hold") then
                               child:Destroy()
                           end
                       end
                   end
               end)
           end
       end)
   end,
})

local ToggleAntiLava = TabDef:CreateToggle({
   Name = "🔥 Anti-Purple Lava (Авто-втік з лави)",
   CurrentValue = false,
   Flag = "AntiLavaToggle",
   Callback = function(Value)
       _G.AntiLava = Value
       task.spawn(function()
           while _G.AntiLava do
               task.wait(0.2)
               pcall(function()
                   local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                   if root.Position.Y < -50 then -- Якщо падаєш під карту у лаву
                       root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
                   end
               end)
           end
       end)
   end,
})

---------------------------------------------------------
-- 🌀 Вкладка 3: Аури та Хаос
---------------------------------------------------------
local TabChaos = Window:CreateTab("🌀 Хаос", 4483362458)

local ToggleFlingAura = TabChaos:CreateToggle({
   Name = "🌪️ Fling Aura (Відштовхувати всіх поруч)",
   CurrentValue = false,
   Flag = "FlingAuraToggle",
   Callback = function(Value)
       _G.FlingAura = Value
       task.spawn(function()
           while _G.FlingAura do
               task.wait()
               pcall(function()
                   local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                   for _, player in pairs(game.Players:GetPlayers()) do
                       if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                           local pRoot = player.Character.HumanoidRootPart
                           local dist = (root.Position - pRoot.Position).Magnitude
                           if dist < 15 then
                               pRoot.Velocity = Vector3.new(0, flingPower * 10, 0)
                           end
                       end
                   end
               end)
           end
       end)
   end,
})

---------------------------------------------------------
-- ⚡ Вкладка 4: Рух & Телепорти
---------------------------------------------------------
local TabMove = Window:CreateTab("⚡ Рух", 4483362458)

local SliderSpeed = TabMove:CreateSlider({
   Name = "👟 Швидкість бігу (WalkSpeed)",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

local ButtonSafeZone = TabMove:CreateButton({
   Name = "🏖️ TP у Безпечну Зону (Safe Area)",
   Callback = function()
       pcall(function()
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
       end)
   end,
})

Rayfield:Notify({
   Title = "Martin Hub Активовано! 🐝",
   Content = "Fling Things & People скрипт успішно завантажено!",
   Duration = 5,
   Image = 4483362458,
})
