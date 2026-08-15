-- ===== МЕНЮ ДЛЯ KICK (ВИГНАННЯ) =====
local function CreateKickMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KickMenu"
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 300, 0, 180)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    mainFrame.BorderSizePixel = 3
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Parent = mainFrame
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    title.BorderColor3 = Color3.fromRGB(255, 0, 0)
    title.BorderSizePixel = 3
    title.Font = Enum.Font.SourceSans
    title.Text = "Kick Player"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18

    -- Нік гравця
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = mainFrame
    nameLabel.Size = UDim2.new(0.3, 0, 0, 25)
    nameLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.Text = "Player:"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14

    local nameBox = Instance.new("TextBox")
    nameBox.Parent = mainFrame
    nameBox.Size = UDim2.new(0.55, 0, 0, 25)
    nameBox.Position = UDim2.new(0.4, 0, 0.25, 0)
    nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    nameBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
    nameBox.BorderSizePixel = 2
    nameBox.Font = Enum.Font.SourceSans
    nameBox.Text = "PlayerName"
    nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameBox.TextSize = 14

    -- Причина
    local reasonLabel = Instance.new("TextLabel")
    reasonLabel.Parent = mainFrame
    reasonLabel.Size = UDim2.new(0.3, 0, 0, 25)
    reasonLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    reasonLabel.BackgroundTransparency = 1
    reasonLabel.Font = Enum.Font.SourceSans
    reasonLabel.Text = "Reason:"
    reasonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    reasonLabel.TextSize = 14

    local reasonBox = Instance.new("TextBox")
    reasonBox.Parent = mainFrame
    reasonBox.Size = UDim2.new(0.55, 0, 0, 25)
    reasonBox.Position = UDim2.new(0.4, 0, 0.5, 0)
    reasonBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    reasonBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
    reasonBox.BorderSizePixel = 2
    reasonBox.Font = Enum.Font.SourceSans
    reasonBox.Text = "You have been kicked!"
    reasonBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    reasonBox.TextSize = 14

    -- Кнопка Kick
    local kickBtn = Instance.new("TextButton")
    kickBtn.Parent = mainFrame
    kickBtn.Size = UDim2.new(0.3, 0, 0, 30)
    kickBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
    kickBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    kickBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    kickBtn.BorderSizePixel = 2
    kickBtn.Font = Enum.Font.SourceSans
    kickBtn.Text = "Kick!"
    kickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    kickBtn.TextSize = 16
    kickBtn.MouseButton1Click:Connect(function()
        local targetName = nameBox.Text
        local reason = reasonBox.Text or "You have been kicked!"
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Name:lower() == targetName:lower() then
                plr:Kick(reason)
                print("Kicked " .. plr.Name .. " | Reason: " .. reason)
                screenGui:Destroy()
                return
            end
        end
        print("Player not found: " .. targetName)
    end)

    -- Кнопка Cancel (закрити)
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Parent = mainFrame
    cancelBtn.Size = UDim2.new(0.3, 0, 0, 30)
    cancelBtn.Position = UDim2.new(0.65, 0, 0.75, 0)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    cancelBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    cancelBtn.BorderSizePixel = 2
    cancelBtn.Font = Enum.Font.SourceSans
    cancelBtn.Text = "Cancel"
    cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelBtn.TextSize = 16
    cancelBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

-- ===== КНОПКА ДЛЯ ВІДКРИТТЯ МЕНЮ (додай у своє GUI) =====
local kickMenuBtn = Instance.new("TextButton")
kickMenuBtn.Parent = frame -- або на сторінку
kickMenuBtn.BackgroundColor3 = blak
kickMenuBtn.BorderColor3 = rede
kickMenuBtn.BorderSizePixel = 3
kickMenuBtn.Size = UDim2.new(0.5, 0, 0, 30)
kickMenuBtn.Position = UDim2.new(0.5, 0, 0.9, 0) -- налаштуй позицію
kickMenuBtn.Font = tef
kickMenuBtn.FontSize = "Size14"
kickMenuBtn.Text = "👢 Kick Player"
kickMenuBtn.TextColor3 = whit
kickMenuBtn.TextWrapped = true
kickMenuBtn.MouseButton1Click:Connect(CreateKickMenu)
