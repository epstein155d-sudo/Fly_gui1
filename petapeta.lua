-- ==========================================
-- Martin Hub | PETAPETA: School of Nightmares
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👻 Martin Hub | PetaPeta Ultimate",
   LoadingTitle = "Завантаження PetaPeta Hub...",
   LoadingSubtitle = "by Martin",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

-- Вкладки
local TabVisuals = Window:CreateTab("👁️ ESP & Візуали", 4483362458)
local TabCombat = Window:CreateTab("🛡️ Захист & Бій", 4483362458)
local TabFarm = Window:CreateTab("🔑 Авто-Збір & Поради", 4483362458)
local TabTeleport = Window:CreateTab("📍 Телепорти", 4483362458)
local TabMovement = Window:CreateTab("⚡ Рух & GUI", 4483362458)

-- Змінні для функцій
local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    Lighting = game:GetService("Lighting")
}
local LocalPlayer = Services.Players.LocalPlayer

local Flags = {
    MonsterESP = false,
    KeysESP = false,
    ShardsESP = false,
    Fullbright = false,
    Godmode = false,
    AutoStun = false,
    AutoShards = false,
    SpeedBoost = 16,
    Noclip = false,
    InfJump = false
}

-- ==========================================
-- 👁️ 1. Вкладка "ESP & Візуали"
-- ==========================================

TabVisuals:CreateToggle({
   Name = "👻 Monster ESP (Підсвічування Пета-Пета)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.MonsterESP = Value
      while Flags.MonsterESP do
         task.wait(1)
         for _, obj in pairs(workspace:GetChildren()) do
            if obj:FindFirstChild("Humanoid") and obj.Name ~= LocalPlayer.Name then
               if not obj:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight")
                  hl.FillColor = Color3.fromRGB(255, 0, 0)
                  hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                  hl.Parent = obj
               end
            end
         end
      end
   end,
})

TabVisuals:CreateToggle({
   Name = "🔑 Keys ESP (Підсвічування ключів)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.KeysESP = Value
      for _, obj in pairs(workspace:GetDescendants()) do
         if obj:IsA("Tool") or obj.Name:lower():find("key") then
            if Value then
               if not obj:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight")
                  hl.FillColor = Color3.fromRGB(255, 215, 0)
                  hl.Parent = obj
               end
            else
               if obj:FindFirstChild("Highlight") then
                  obj.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

TabVisuals:CreateToggle({
   Name = "💎 Cursed Shards ESP (Осколки)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.ShardsESP = Value
      for _, obj in pairs(workspace:GetDescendants()) do
         if obj.Name:lower():find("shard") or obj.Name:lower():find("orb") then
            if Value then
               if not obj:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight")
                  hl.FillColor = Color3.fromRGB(0, 255, 255)
                  hl.Parent = obj
               end
            else
               if obj:FindFirstChild("Highlight") then
                  obj.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

TabVisuals:CreateToggle({
   Name = "💡 Fullbright (Нічне бачення)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.Fullbright = Value
      if Value then
         Services.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
         Services.Lighting.Brightness = 2
         Services.Lighting.FogEnd = 100000
      else
         Services.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
         Services.Lighting.Brightness = 1
      end
   end,
})

-- ==========================================
-- 🛡️ 2. Вкладка "Захист & Бій"
-- ==========================================

TabCombat:CreateToggle({
   Name = "🛡️ Godmode / Invincibility (Непробивність)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.Godmode = Value
      Services.RunService.Stepped:Connect(function()
         if Flags.Godmode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
         end
      end)
   end,
})

TabCombat:CreateToggle({
   Name = "⚡ Auto-Stun Monster (Авто-стан)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoStun = Value
      -- Логіка авто-стану при наближенні монстра
   end,
})

-- ==========================================
-- 🔑 3. Вкладка "Авто-Збір & Поради"
-- ==========================================

TabFarm:CreateButton({
   Name = "🧲 Bring All Keys to Player (Телепорт усіх ключів)",
   Callback = function()
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
         for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj.Name:lower():find("key") then
               if obj:IsA("BasePart") then
                  obj.CFrame = char.HumanoidRootPart.CFrame
               elseif obj:IsA("Model") and obj.PrimaryPart then
                  obj:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame)
               end
            end
         end
      end
   end,
})

TabFarm:CreateToggle({
   Name = "💎 Auto-Collect Shards Aura (Авто-збір осколків)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoShards = Value
      task.spawn(function()
         while Flags.AutoShards do
            task.wait(0.5)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               for _, obj in pairs(workspace:GetDescendants()) do
                  if obj.Name:lower():find("shard") or obj.Name:lower():find("orb") then
                     if obj:IsA("BasePart") and (obj.Position - char.HumanoidRootPart.Position).Magnitude < 40 then
                        obj.CFrame = char.HumanoidRootPart.CFrame
                     end
                  end
               end
            end
         end
      end)
   end,
})

-- ==========================================
-- 📍 4. Вкладка "Телепорти"
-- ==========================================

TabTeleport:CreateButton({
   Name = "🚪 Teleport to Main Gate (До виходу)",
   Callback = function()
      local gate = workspace:FindFirstChild("Gate") or workspace:FindFirstChild("Exit")
      if gate and LocalPlayer.Character then
         LocalPlayer.Character:MoveTo(gate.Position)
      end
   end,
})

TabTeleport:CreateButton({
   Name = "📺 Teleport to Safe Room (У безпечну кімнату)",
   Callback = function()
      local safeRoom = workspace:FindFirstChild("SafeRoom") or workspace:FindFirstChild("TVRoom")
      if safeRoom and LocalPlayer.Character then
         LocalPlayer.Character:MoveTo(safeRoom.Position)
      end
   end,
})

TabTeleport:CreateButton({
   Name = "☁️ Safe Air Zone (Телепорт у повітря)",
   Callback = function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
      end
   end,
})

-- ==========================================
-- ⚡ 5. Вкладка "Рух & GUI"
-- ==========================================

TabMovement:CreateSlider({
   Name = "🏃 Швидкість бігу (Speed Hack)",
   Range = {16, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      Flags.SpeedBoost = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

TabMovement:CreateToggle({
   Name = "👻 Noclip (Прохід крізь стіни)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.Noclip = Value
      Services.RunService.Stepped:Connect(function()
         if Flags.Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = false
               end
            end
         end
      end)
   end,
})

TabMovement:CreateToggle({
   Name = "🦘 Infinite Jump (Нескінченний стрибок)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.InfJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if Flags.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid:ChangeState("Jumping")
   end
end)

Rayfield:Notify({
   Title = "PetaPeta Ultimate Hub",
   Content = "Скрипт успішно завантажено! Удачі на Hard/Super Hard!",
   Duration = 5,
   Image = 4483362458,
})
