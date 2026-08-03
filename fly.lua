-- Fly GUI 1 (Mobile Compatible & Dragable)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGui1"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Open/Close Small Toggle Button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenBtn"
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.Text = "FLY"
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 18
OpenBtn.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = OpenBtn

local UIStrokeBtn = Instance.new("UIStroke")
UIStrokeBtn.Color = Color3.fromRGB(0, 255, 150)
UIStrokeBtn.Thickness = 2
UIStrokeBtn.Parent = OpenBtn

-- Main Frame (Menu)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 12)
UICornerFrame.Parent = MainFrame

local UIStrokeFrame = Instance.new("UIStroke")
UIStrokeFrame.Color = Color3.fromRGB(0, 255, 150)
UIStrokeFrame.Thickness = 1.5
UIStrokeFrame.Parent = MainFrame

-- Title Header
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "fly gui 1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Speed Controls (+ / -)
local speed = 50
local flying = false

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.6, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0.2, 0, 0.25, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. speed
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 16
SpeedLabel.Parent = MainFrame

local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 30, 0, 30)
MinusBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinusBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
MinusBtn.Text = "-"
MinusBtn.Font = Enum.Font.SourceSansBold
MinusBtn.TextSize = 22
MinusBtn.Parent = MainFrame
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 6)

local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 30, 0, 30)
PlusBtn.Position = UDim2.new(0.8, -30, 0.25, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PlusBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
PlusBtn.Text = "+"
PlusBtn.Font = Enum.Font.SourceSansBold
PlusBtn.TextSize = 22
PlusBtn.Parent = MainFrame
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 6)

-- Toggle Fly Button inside Menu
local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
FlyToggleBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
FlyToggleBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
FlyToggleBtn.Text = "Start Fly"
FlyToggleBtn.Font = Enum.Font.SourceSansBold
FlyToggleBtn.TextSize = 18
FlyToggleBtn.Parent = MainFrame
Instance.new("UICorner", FlyToggleBtn).CornerRadius = UDim.new(0, 8)

-- Function: Make Buttons/Frames Dragable (Touch & Mouse)
local function makeDragable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDragable(OpenBtn)
makeDragable(MainFrame)

-- Button Logic
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

PlusBtn.MouseButton1Click:Connect(function()
    speed = speed + 10
    SpeedLabel.Text = "Speed: " .. speed
end)

MinusBtn.MouseButton1Click:Connect(function()
    if speed > 10 then
        speed = speed - 10
        SpeedLabel.Text = "Speed: " .. speed
    end
end)

-- Flying Mechanics
local bodyVel, bodyGyro
FlyToggleBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")

    if flying then
        FlyToggleBtn.Text = "Stop Fly"
        FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = hrp.CFrame
        bodyGyro.Parent = hrp

        bodyVel = Instance.new("BodyVelocity")
        bodyVel.velocity = Vector3.new(0, 0.1, 0)
        bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.Parent = hrp

        humanoid.PlatformStand = true

        task.spawn(function()
            while flying and hrp and bodyVel and bodyGyro do
                local camera = workspace.CurrentCamera
                bodyGyro.cframe = camera.CFrame
                bodyVel.velocity = camera.CFrame.LookVector * speed
                RunService.RenderStepped:Wait()
            end
        end)
    else
        FlyToggleBtn.Text = "Start Fly"
        FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        FlyToggleBtn.TextColor3 = Color3.fromRGB(10, 10, 10)

        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
        humanoid.PlatformStand = false
    end
end)
