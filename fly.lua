local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(36, 0, 0)
stroke.Thickness = 2
stroke.Parent = mainFrame

local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.Parent = mainFrame
topbar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topbar.BorderSizePixel = 0
topbar.Size = UDim2.new(1, 0, 0, 30)

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topbar

local topStroke = Instance.new("UIStroke")
topStroke.Color = Color3.fromRGB(36, 0, 0)
topStroke.Thickness = 1
topStroke.Parent = topbar

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = topbar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 40, 0, 0)
title.Size = UDim2.new(1, -50, 1, 0)
title.Font = Enum.Font.Michroma
title.Text = "FLY"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Parent = topbar
closeBtn.BackgroundTransparency = 1
closeBtn.Position = UDim2.new(1, -15, 0, 0)
closeBtn.Size = UDim2.new(0, 15, 0, 15)
closeBtn.Font = Enum.Font.SourceSans
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextSize = 12

local content = Instance.new("Frame")
content.Name = "Content"
content.Parent = mainFrame
content.BackgroundTransparency = 1
content.Position = UDim2.new(0, 10, 0, 35)
content.Size = UDim2.new(1, -20, 1, -45)

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = content

local flyToggle = Instance.new("TextButton")
flyToggle.Name = "FlyToggle"
flyToggle.Parent = content
flyToggle.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
flyToggle.BorderSizePixel = 0
flyToggle.Size = UDim2.new(0, 150, 0, 30)
flyToggle.Font = Enum.Font.Michroma
flyToggle.Text = "FLY: OFF"
flyToggle.TextColor3 = Color3.fromRGB(166, 0, 0)
flyToggle.TextSize = 12

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = flyToggle

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(34, 34, 34)
toggleStroke.Thickness = 1
toggleStroke.Parent = flyToggle

local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedFrame"
speedFrame.Parent = content
speedFrame.BackgroundTransparency = 1
speedFrame.Size = UDim2.new(0, 150, 0, 40)

local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = speedFrame
speedLabel.BackgroundTransparency = 1
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.Size = UDim2.new(1, 0, 0.5, 0)
speedLabel.Font = Enum.Font.Michroma
speedLabel.Text = "SPEED"
speedLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
speedLabel.TextSize = 12
speedLabel.TextXAlignment = Enum.TextXAlignment.Center

local speedInput = Instance.new("TextBox")
speedInput.Parent = speedFrame
speedInput.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
speedInput.BorderSizePixel = 0
speedInput.Position = UDim2.new(0, 0, 0.5, 0)
speedInput.Size = UDim2.new(1, 0, 0.5, 0)
speedInput.Font = Enum.Font.SourceSans
speedInput.PlaceholderText = "50"
speedInput.Text = "50"
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 12

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = speedInput

local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput()
    local speed = math.clamp(tonumber(speedInput.Text) or 50, 1, 500)
    speedInput.Text = tostring(speed)
end

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

topbar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

topbar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    stopFly()
    screenGui:Destroy()
end)

local bodyVelocity = nil
local bodyAngularVelocity = nil
local flying = false
local speed = 50
local keys = {w = false, s = false, a = false, d = false, space = false, leftshift = false}
local connection = nil

local function startFly()
    if flying then return end
    flying = true
    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
    bodyAngularVelocity.Parent = rootPart

    flyToggle.Text = "FLY: ON"
    flyToggle.TextColor3 = Color3.fromRGB(0, 255, 0)

    local tween = TweenService:Create(flyToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 0)})
    tween:Play()

    connection = RunService.Heartbeat:Connect(function(dt)
        if not flying or not rootPart.Parent then
            connection:Disconnect()
            return
        end
        speed = math.clamp(tonumber(speedInput.Text) or 50, 1, 500)
        local cam = workspace.CurrentCamera
        local moveVector = Vector3.new(0, 0, 0)
        if keys.w then moveVector = moveVector + cam.CFrame.LookVector end
        if keys.s then moveVector = moveVector - cam.CFrame.LookVector end
        if keys.a then moveVector = moveVector - cam.CFrame.RightVector end
        if keys.d then moveVector = moveVector + cam.CFrame.RightVector end
        if keys.space then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if keys.leftshift then moveVector = moveVector - Vector3.new(0, 1, 0) end
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * speed
        end
        local targetCFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + cam.CFrame.LookVector)
        local tweenInfo = TweenInfo.new(dt * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        bodyVelocity.Velocity = Vector3.new(moveVector.X, moveVector.Y, moveVector.Z)
    end)
end

local function stopFly()
    if not flying then return end
    flying = false
    humanoid.PlatformStand = false
    if bodyVelocity then
        local stopTween = TweenService:Create(bodyVelocity, TweenInfo.new(0.3), {Velocity = Vector3.new(0, 0, 0)})
        stopTween:Play()
        stopTween.Completed:Connect(function()
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end)
    end
    if bodyAngularVelocity then
        bodyAngularVelocity:Destroy()
        bodyAngularVelocity = nil
    end
    if connection then
        connection:Disconnect()
        connection = nil
    end
    flyToggle.Text = "FLY: OFF"
    flyToggle.TextColor3 = Color3.fromRGB(166, 0, 0)
    local tween = TweenService:Create(flyToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(17, 17, 17)})
    tween:Play()
end

flyToggle.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

speedInput.FocusLost:Connect(updateInput)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local key = input.KeyCode
    if key == Enum.KeyCode.W then keys.w = true
    elseif key == Enum.KeyCode.S then keys.s = true
    elseif key == Enum.KeyCode.A then keys.a = true
    elseif key == Enum.KeyCode.D then keys.d = true
    elseif key == Enum.KeyCode.Space then keys.space = true
    elseif key == Enum.KeyCode.LeftShift then keys.leftshift = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    local key = input.KeyCode
    if key == Enum.KeyCode.W then keys.w = false
    elseif key == Enum.KeyCode.S then keys.s = false
    elseif key == Enum.KeyCode.A then keys.a = false
    elseif key == Enum.KeyCode.D then keys.d = false
    elseif key == Enum.KeyCode.Space then keys.space = false
    elseif key == Enum.KeyCode.LeftShift then keys.leftshift = false
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if flying then
        wait(1)
        startFly()
    end
end)
