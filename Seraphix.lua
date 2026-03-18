-- Seraphix UI Library
local UILibrary = {}
UILibrary.__index = UILibrary

function UILibrary:CreateWindow()
    local window = {}
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Seraphix"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 520, 0, 460)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -230)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

    local border = Instance.new("UIStroke", mainFrame)
    border.Color = Color3.fromRGB(255, 255, 255)
    border.Thickness = 1.5
    border.Transparency = 0.85

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

    local tc = Instance.new("Frame")
    tc.Size = UDim2.new(1, 0, 0, 14)
    tc.Position = UDim2.new(0, 0, 1, -14)
    tc.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    tc.BorderSizePixel = 0
    tc.Parent = titleBar

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(1, 0, 0, 1)
    accent.Position = UDim2.new(0, 0, 1, -1)
    accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    accent.BackgroundTransparency = 0.7
    accent.BorderSizePixel = 0
    accent.Parent = titleBar

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 15, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.BorderSizePixel = 0
    dot.Parent = titleBar
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -120, 1, 0)
    titleLabel.Position = UDim2.new(0, 30, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Seraphix"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local ver = Instance.new("TextLabel")
    ver.Size = UDim2.new(0, 60, 1, 0)
    ver.Position = UDim2.new(0, 30, 0, 0)
    ver.BackgroundTransparency = 1
    ver.Text = "v1.0"
    ver.TextColor3 = Color3.fromRGB(120, 120, 120)
    ver.TextSize = 11
    ver.Font = Enum.Font.Gotham
    ver.TextXAlignment = Enum.TextXAlignment.Left
    ver.TextYAlignment = Enum.TextYAlignment.Bottom
    ver.Parent = titleBar

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 32, 0, 32)
    minBtn.Position = UDim2.new(1, -80, 0.5, -16)
    minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    minBtn.BorderSizePixel = 0
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    minBtn.TextSize = 20
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = titleBar
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

    minBtn.MouseEnter:Connect(function()
        minBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        minBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    minBtn.MouseLeave:Connect(function()
        minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -42, 0.5, -16)
    closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "x"
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -20, 1, -68)
    container.Position = UDim2.new(0, 10, 0, 58)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.Parent = mainFrame

    local ll = Instance.new("UIListLayout")
    ll.Padding = UDim.new(0, 7)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Parent = container
    ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, ll.AbsoluteContentSize.Y + 10)
    end)

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        mainFrame.Size = minimized and UDim2.new(0, 520, 0, 50) or UDim2.new(0, 520, 0, 460)
        minBtn.Text = minimized and "+" or "-"
    end)

    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = mainFrame.Position
        end
    end)
    titleBar.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)

    window.container = container
    window.screenGui = screenGui
    return setmetatable(window, {__index = UILibrary})
end

function UILibrary:AddSection(config)
    local s = Instance.new("TextLabel")
    s.Size = UDim2.new(1, -10, 0, 24)
    s.BackgroundTransparency = 1
    s.Text = (config.Text or "Section"):upper()
    s.TextColor3 = Color3.fromRGB(160, 160, 160)
    s.TextSize = 11
    s.Font = Enum.Font.GothamBold
    s.TextXAlignment = Enum.TextXAlignment.Left
    s.Parent = self.container

    local l = Instance.new("Frame")
    l.Size = UDim2.new(1, -10, 0, 1)
    l.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    l.BackgroundTransparency = 0.88
    l.BorderSizePixel = 0
    l.Parent = self.container
end

function UILibrary:AddToggle(config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -10, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    f.BorderSizePixel = 0
    f.Parent = self.container
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", f)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.88

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Toggle"
    label.TextColor3 = Color3.fromRGB(180, 180, 180)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = f

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 24)
    btn.Position = UDim2.new(1, -52, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = f
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 18, 0, 18)
    ind.Position = UDim2.new(0, 3, 0.5, -9)
    ind.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    ind.BorderSizePixel = 0
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    local toggled = config.Default or false
    local function update()
        if toggled then
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ind.Position = UDim2.new(1, -21, 0.5, -9)
            ind.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            stroke.Transparency = 0.5
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ind.Position = UDim2.new(0, 3, 0.5, -9)
            ind.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            stroke.Transparency = 0.88
            label.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
    end
    update()
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        update()
        if config.Callback then config.Callback(toggled) end
    end)
end

function UILibrary:AddSlider(config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -10, 0, 58)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    f.BorderSizePixel = 0
    f.Parent = self.container
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", f)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.88

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 24)
    label.Position = UDim2.new(0, 14, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Slider"
    label.TextColor3 = Color3.fromRGB(180, 180, 180)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = f

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0, 60, 0, 24)
    valLabel.Position = UDim2.new(1, -72, 0, 6)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(config.Default or config.Min or 0)
    valLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLabel.TextSize = 14
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.Parent = f

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -28, 0, 5)
    track.Position = UDim2.new(0, 14, 1, -18)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    track.BorderSizePixel = 0
    track.Parent = f
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local min = config.Min or 0
    local max = config.Max or 100
    local value = config.Default or min

    local function updateSlider(val)
        value = math.clamp(val, min, max)
        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        valLabel.Text = tostring(math.floor(value))
        if config.Callback then config.Callback(value) end
    end
    updateSlider(value)

    local dragging = false
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    track.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local p = math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * p)
        end
    end)
end

-- =====================
-- Main Script (Seraphix)
-- =====================

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- Shared checks
local TeamCheckEnabled = false
local WallCheckEnabled = false

local function IsSameTeam(player)
    return TeamCheckEnabled
        and LP.Team ~= nil
        and player.Team ~= nil
        and player.Team == LP.Team
end

local function HasWallBetween(targetPos)
    if not WallCheckEnabled then return false end
    local origin = Cam.CFrame.Position
    local direction = (targetPos - origin)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LP.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ray = workspace:Raycast(origin, direction, params)
    if ray then
        local hit = ray.Instance
        local hitChar = hit and hit.Parent
        local isCharacter = hitChar and Players:GetPlayerFromCharacter(hitChar) ~= nil
        return not isCharacter
    end
    return false
end

-- ESP
local ESPEnabled = false
local ESPFolder = Instance.new("Folder", game:GetService("CoreGui"))
ESPFolder.Name = "SeraphixESP"

local function CreateESP(player)
    if player == LP then return end
    if IsSameTeam(player) then return end
    local function AddESP(char)
        if ESPFolder:FindFirstChild(player.Name) then
            ESPFolder:FindFirstChild(player.Name):Destroy()
        end
        local cont = Instance.new("Folder", ESPFolder)
        cont.Name = player.Name

        local hl = Instance.new("Highlight", cont)
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineColor = Color3.fromRGB(200, 200, 200)
        hl.FillTransparency = 0.6
        hl.OutlineTransparency = 0

        local bb = Instance.new("BillboardGui", cont)
        bb.Adornee = char:WaitForChild("Head", 5)
        bb.Size = UDim2.new(0, 110, 0, 45)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true

        local nl = Instance.new("TextLabel", bb)
        nl.Size = UDim2.new(1, 0, 0, 16)
        nl.BackgroundTransparency = 1
        nl.Text = player.Name
        nl.TextColor3 = Color3.fromRGB(255, 255, 255)
        nl.TextSize = 13
        nl.Font = Enum.Font.GothamBold
        nl.TextStrokeTransparency = 0.3

        local hpBG = Instance.new("Frame", bb)
        hpBG.Size = UDim2.new(1, 0, 0, 9)
        hpBG.Position = UDim2.new(0, 0, 0, 19)
        hpBG.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        hpBG.BorderSizePixel = 0
        Instance.new("UICorner", hpBG).CornerRadius = UDim.new(0, 4)

        local st = Instance.new("UIStroke", hpBG)
        st.Color = Color3.fromRGB(255, 255, 255)
        st.Thickness = 1
        st.Transparency = 0.5

        local hpFill = Instance.new("Frame", hpBG)
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hpFill.BorderSizePixel = 0
        Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 4)

        local hpText = Instance.new("TextLabel", bb)
        hpText.Size = UDim2.new(1, 0, 0, 13)
        hpText.Position = UDim2.new(0, 0, 0, 31)
        hpText.BackgroundTransparency = 1
        hpText.Text = "100/100"
        hpText.TextColor3 = Color3.fromRGB(200, 200, 200)
        hpText.TextSize = 11
        hpText.Font = Enum.Font.GothamBold
        hpText.TextStrokeTransparency = 0.3

        local hum = char:WaitForChild("Humanoid", 5)
        if hum then
            local function upd()
                local pct = hum.Health / hum.MaxHealth
                hpFill.Size = UDim2.new(pct, 0, 1, 0)
                hpText.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                if pct > 0.6 then
                    hpFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                elseif pct > 0.3 then
                    hpFill.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
                else
                    hpFill.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
                end
            end
            upd()
            hum.HealthChanged:Connect(upd)
            hum.Died:Connect(function() cont:Destroy() end)
        end
    end
    if player.Character then AddESP(player.Character) end
    player.CharacterAdded:Connect(AddESP)
end

local function ToggleESP(e)
    ESPEnabled = e
    if e then
        ESPFolder:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
        Players.PlayerAdded:Connect(function(p)
            if ESPEnabled then CreateESP(p) end
        end)
    else
        ESPFolder:ClearAllChildren()
    end
end

-- Aim Assist
local AimSmooth = 0.5
local AimFOV = 200
local aimConn = nil

local function GetClosest()
    local closest, shortest = nil, AimFOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            if IsSameTeam(p) then continue end
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local headPos = p.Character.Head.Position
                if HasWallBetween(headPos) then continue end
                local sp, os = Cam:WorldToViewportPoint(headPos)
                if os then
                    local d = (Vector2.new(sp.X, sp.Y) - UIS:GetMouseLocation()).Magnitude
                    if d < shortest then closest, shortest = p, d end
                end
            end
        end
    end
    return closest
end

local function ToggleAim(e)
    if e then
        aimConn = RS.RenderStepped:Connect(function()
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local t = GetClosest()
                if t and t.Character and t.Character:FindFirstChild("Head") then
                    Cam.CFrame = Cam.CFrame:Lerp(
                        CFrame.new(Cam.CFrame.Position, t.Character.Head.Position),
                        AimSmooth
                    )
                end
            end
        end)
    else
        if aimConn then aimConn:Disconnect() aimConn = nil end
    end
end

-- Fly
local FlySpeed = 50
local flyConn, flyBV, flyBG = nil, nil, nil

local function ToggleFly(e)
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    if e then
        flyBV = Instance.new("BodyVelocity", hrp)
        flyBV.Velocity = Vector3.new(0, 0, 0)
        flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBG = Instance.new("BodyGyro", hrp)
        flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBG.P = 9e4
        flyConn = RS.RenderStepped:Connect(function()
            if not char or not hrp then return end
            local md = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then md = md + Cam.CFrame.LookVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.S) then md = md - Cam.CFrame.LookVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.A) then md = md - Cam.CFrame.RightVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.D) then md = md + Cam.CFrame.RightVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then md = md + Vector3.new(0, FlySpeed, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then md = md - Vector3.new(0, FlySpeed, 0) end
            if flyBV then flyBV.Velocity = md end
            if flyBG then flyBG.CFrame = Cam.CFrame end
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end
end

-- Noclip
local ncConn = nil
local function ToggleNoclip(e)
    if e then
        ncConn = RS.Stepped:Connect(function()
            if LP.Character then
                for _, v in pairs(LP.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    else
        if ncConn then ncConn:Disconnect() ncConn = nil end
        if LP.Character then
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
    end
end

-- Infinite Jump
local ijConn = nil
local function ToggleInfJump(e)
    if e then
        ijConn = UIS.JumpRequest:Connect(function()
            if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        if ijConn then ijConn:Disconnect() ijConn = nil end
    end
end

-- Build UI
local win = UILibrary:CreateWindow()

win:AddSection({Text = "Visuals"})
win:AddToggle({Text = "ESP", Default = false, Callback = ToggleESP})
win:AddToggle({Text = "Team Check (ESP + Aim)", Default = false, Callback = function(v)
    TeamCheckEnabled = v
    if ESPEnabled then ToggleESP(true) end -- refresh ESP with new team filter
end})

win:AddSection({Text = "Combat"})
win:AddToggle({Text = "Aim Assist [Hold RMB]", Default = false, Callback = ToggleAim})
win:AddToggle({Text = "Wall Check (Aim)", Default = false, Callback = function(v)
    WallCheckEnabled = v
end})
win:AddSlider({Text = "Aim Smoothness", Min = 1, Max = 100, Default = 50, Callback = function(v)
    AimSmooth = v / 100
end})
win:AddSlider({Text = "Aim FOV", Min = 50, Max = 500, Default = 200, Callback = function(v)
    AimFOV = v
end})

win:AddSection({Text = "Movement"})
win:AddToggle({Text = "Fly [W/A/S/D + Space/Shift]", Default = false, Callback = ToggleFly})
win:AddSlider({Text = "Fly Speed", Min = 10, Max = 200, Default = 50, Callback = function(v)
    FlySpeed = v
end})
win:AddToggle({Text = "Noclip", Default = false, Callback = ToggleNoclip})
win:AddToggle({Text = "Infinite Jump", Default = false, Callback = ToggleInfJump})
win:AddSlider({Text = "WalkSpeed", Min = 16, Max = 200, Default = 16, Callback = function(v)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = v
    end
end})
win:AddSlider({Text = "Jump Power", Min = 50, Max = 300, Default = 50, Callback = function(v)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.JumpPower = v
    end
end})

-- FPS Counter
local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "SeraphixFPS"
fpsGui.ResetOnSpawn = false
fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
fpsGui.Parent = game:GetService("CoreGui")

local fpsBG = Instance.new("Frame")
fpsBG.Size = UDim2.new(0, 110, 0, 44)
fpsBG.Position = UDim2.new(0, 12, 0, 12)
fpsBG.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
fpsBG.BorderSizePixel = 0
fpsBG.Parent = fpsGui
Instance.new("UICorner", fpsBG).CornerRadius = UDim.new(0, 8)

local fpsBorder = Instance.new("UIStroke", fpsBG)
fpsBorder.Color = Color3.fromRGB(255, 255, 255)
fpsBorder.Thickness = 1
fpsBorder.Transparency = 0.85

local fpsDot = Instance.new("Frame")
fpsDot.Size = UDim2.new(0, 7, 0, 7)
fpsDot.Position = UDim2.new(0, 12, 0.5, -3)
fpsDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fpsDot.BorderSizePixel = 0
fpsDot.Parent = fpsBG
Instance.new("UICorner", fpsDot).CornerRadius = UDim.new(1, 0)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, -30, 1, 0)
fpsLabel.Position = UDim2.new(0, 26, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 15
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = fpsBG

local fc, el = 0, 0
RS.RenderStepped:Connect(function(dt)
    fc = fc + 1
    el = el + dt
    if el >= 0.5 then
        local fps = math.floor(fc / el)
        fpsLabel.Text = "FPS: " .. fps
        fc = 0
        el = 0
        if fps >= 55 then
            fpsDot.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        elseif fps >= 30 then
            fpsDot.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
        else
            fpsDot.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        end
    end
end)
