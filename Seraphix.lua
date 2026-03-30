-- Seraphix v2.0 | Custom UI (no library)

local rng = math.random
local function RandStr(n)
    local s, c = "", "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for _ = 1, n do s = s .. c:sub(rng(1,#c), rng(1,#c)) end
    return s
end

local _ESP_ID = RandStr(10)
local _GUI_ID = RandStr(10)
local _FPS_ID = RandStr(10)

local CoreGui   = game:GetService("CoreGui")
local RS        = game:GetService("RunService")
local UIS       = game:GetService("UserInputService")
local Players   = game:GetService("Players")
local TweenSvc  = game:GetService("TweenService")
local LP        = Players.LocalPlayer
local Cam       = workspace.CurrentCamera

-- State
local TeamCheckEnabled = false
local WallCheckEnabled = false
local ESPEnabled       = false
local AimEnabled       = false
local AimSmooth        = 0.15
local AimFOV           = 200
local FlySpeed         = 50
local BaseplateEnabled = false
local baseplateInstance = nil
local aimConn, flyConn, flyBV, flyBG, ncConn, ijConn = nil,nil,nil,nil,nil,nil

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = _ESP_ID
ESPFolder.Parent = CoreGui

-- =============================================
-- CUSTOM UI
-- =============================================
local GUI = Instance.new("ScreenGui")
GUI.Name = _GUI_ID
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.DisplayOrder = 999
pcall(function() GUI.Parent = CoreGui end)
if not GUI.Parent then GUI.Parent = LP:WaitForChild("PlayerGui") end

-- Main window
local Main = Instance.new("Frame", GUI)
Main.Name = RandStr(6)
Main.Size = UDim2.new(0, 420, 0, 480)
Main.Position = UDim2.new(0.5, -210, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = Color3.fromRGB(50, 50, 50)
mainStroke.Thickness = 1

-- Title bar
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)
-- cover bottom corners of title bar
local TitleFix = Instance.new("Frame", TitleBar)
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleFix.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Seraphix"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubLabel = Instance.new("TextLabel", TitleBar)
SubLabel.Size = UDim2.new(0, 80, 1, 0)
SubLabel.Position = UDim2.new(1, -90, 0, 0)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "by Zxnox"
SubLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SubLabel.TextSize = 11
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Close button
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 20)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- Tab bar
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 42)
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)

-- Content area
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -84)
Content.Position = UDim2.new(0, 10, 0, 78)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true

-- Tab system
local tabs = {}
local activeTab = nil

local function MakeTab(name)
    local page = Instance.new("ScrollingFrame", Content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(80,80,80)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0, 72, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(140, 140, 140)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local tab = {btn = btn, page = page, items = 0}
    tabs[name] = tab

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            t.btn.TextColor3 = Color3.fromRGB(140, 140, 140)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeTab = tab
    end)

    return tab
end

local function AddSection(tab, text)
    tab.items += 1
    local lbl = Instance.new("TextLabel", tab.page)
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. text
    lbl.TextColor3 = Color3.fromRGB(100, 100, 100)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = tab.items
end

local function AddLabel(tab, text)
    tab.items += 1
    local row = Instance.new("Frame", tab.page)
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    row.BorderSizePixel = 0
    row.LayoutOrder = tab.items
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function AddToggle(tab, name, default, cb)
    tab.items += 1
    local state = default or false
    local row = Instance.new("Frame", tab.page)
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    row.BorderSizePixel = 0
    row.LayoutOrder = tab.items
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0, 36, 0, 18)
    track.Position = UDim2.new(1, -46, 0.5, -9)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", track)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function setVisual(v)
        TweenSvc:Create(track, TweenInfo.new(0.15), {
            BackgroundColor3 = v and Color3.fromRGB(80,200,80) or Color3.fromRGB(50,50,50)
        }):Play()
        TweenSvc:Create(knob, TweenInfo.new(0.15), {
            Position = v and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7),
            BackgroundColor3 = v and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180)
        }):Play()
    end

    setVisual(state)
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        state = not state
        setVisual(state)
        cb(state)
    end)
    return btn
end

local function AddSlider(tab, name, min, max, default, suffix, cb)
    tab.items += 1
    local val = default
    local row = Instance.new("Frame", tab.page)
    row.Size = UDim2.new(1, 0, 0, 50)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    row.BorderSizePixel = 0
    row.LayoutOrder = tab.items
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -60, 0, 22)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.new(0, 55, 0, 22)
    valLbl.Position = UDim2.new(1, -65, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(val) .. (suffix or "")
    valLbl.TextColor3 = Color3.fromRGB(120, 120, 120)
    valLbl.TextSize = 12
    valLbl.Font = Enum.Font.Gotham
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(1, -24, 0, 6)
    track.Position = UDim2.new(0, 12, 0, 34)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((val - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            val = math.floor(min + (max - min) * rel)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            valLbl.Text = tostring(val) .. (suffix or "")
            cb(val)
        end
    end)
end

local function AddInput(tab, name, placeholder, cb)
    tab.items += 1
    local row = Instance.new("Frame", tab.page)
    row.Size = UDim2.new(1, 0, 0, 52)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    row.BorderSizePixel = 0
    row.LayoutOrder = tab.items
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -12, 0, 20)
    lbl.Position = UDim2.new(0, 12, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(1, -24, 0, 22)
    box.Position = UDim2.new(0, 12, 0, 24)
    box.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    box.BorderSizePixel = 0
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(220, 220, 220)
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    box.FocusLost:Connect(function() cb(box.Text) end)
end

-- =============================================
-- HELPERS & FEATURES
-- =============================================

local function IsSameTeam(p)
    return TeamCheckEnabled and LP.Team ~= nil and p.Team ~= nil and p.Team == LP.Team
end

local function HasWall(targetPos)
    if not WallCheckEnabled then return false end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LP.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ray = workspace:Raycast(Cam.CFrame.Position, targetPos - Cam.CFrame.Position, params)
    if ray then
        return Players:GetPlayerFromCharacter(ray.Instance and ray.Instance.Parent) == nil
    end
    return false
end

local function HPColor(pct)
    if pct > 0.6 then
        local t = (pct - 0.6) / 0.4
        return Color3.fromRGB(math.floor(255*(1-t)), 255, 0)
    else
        local t = pct / 0.6
        return Color3.fromRGB(255, math.floor(255*t), 0)
    end
end

-- ESP
local function CreateESP(player)
    if player == LP then return end
    if IsSameTeam(player) then return end
    local function AddESP(char)
        local existing = ESPFolder:FindFirstChild(player.Name)
        if existing then existing:Destroy() end
        local cont = Instance.new("Folder", ESPFolder)
        cont.Name = player.Name
        local hl = Instance.new("Highlight", cont)
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(0, 0, 0)
        hl.FillTransparency = 0.45
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0
        local hlT = 0
        RS.RenderStepped:Connect(function(dt)
            if not hl or not hl.Parent then return end
            hlT = (hlT + dt * 0.6) % 1
            local v = math.abs(math.sin(hlT * math.pi))
            hl.FillColor = Color3.fromRGB(math.floor(v*255), math.floor(v*255), math.floor(v*255))
        end)
        local bb = Instance.new("BillboardGui", cont)
        bb.Adornee = char:WaitForChild("Head", 5)
        bb.Size = UDim2.new(0, 120, 0, 50)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        local nl = Instance.new("TextLabel", bb)
        nl.Size = UDim2.new(1, 0, 0, 16)
        nl.BackgroundTransparency = 1
        nl.Text = player.Name
        nl.TextColor3 = Color3.fromRGB(255, 255, 255)
        nl.TextSize = 13
        nl.Font = Enum.Font.GothamBold
        nl.TextStrokeTransparency = 0.2
        local nlT = 0.5
        RS.RenderStepped:Connect(function(dt)
            if not nl or not nl.Parent then return end
            nlT = (nlT + dt * 0.5) % 1
            local v = math.abs(math.sin(nlT * math.pi))
            nl.TextColor3 = Color3.fromRGB(math.floor(v*255), math.floor(v*255), math.floor(v*255))
        end)
        local hpBG = Instance.new("Frame", bb)
        hpBG.Size = UDim2.new(1, 0, 0, 9)
        hpBG.Position = UDim2.new(0, 0, 0, 20)
        hpBG.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        hpBG.BorderSizePixel = 0
        Instance.new("UICorner", hpBG).CornerRadius = UDim.new(0, 4)
        local hpFill = Instance.new("Frame", hpBG)
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 4)
        local hum = char:WaitForChild("Humanoid", 5)
        if hum then
            local function upd()
                local pct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                TweenSvc:Create(hpFill, TweenInfo.new(0.2), {
                    Size = UDim2.new(pct, 0, 1, 0),
                    BackgroundColor3 = HPColor(pct)
                }):Play()
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
    ESPFolder:ClearAllChildren()
    if e then
        for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
        Players.PlayerAdded:Connect(function(p) if ESPEnabled then CreateESP(p) end end)
    end
end

-- Aimbot
local function GetBestTarget()
    local best, bestDist = nil, AimFOV
    local center = UIS:GetMouseLocation()
    for _, p in pairs(Players:GetPlayers()) do
        if p == LP then continue end
        if IsSameTeam(p) then continue end
        local char = p.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local head = char:FindFirstChild("Head")
        if not head then continue end
        if HasWall(head.Position) then continue end
        local sp, onScreen = Cam:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
        if dist < bestDist then best = p bestDist = dist end
    end
    return best
end

local function PredictPos(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hrp or not head then return head and head.Position end
    local vel = hrp.Velocity
    local dist = (Cam.CFrame.Position - head.Position).Magnitude
    return head.Position + vel * (dist / 500)
end

local function ToggleAim(e)
    AimEnabled = e
    if aimConn then aimConn:Disconnect() aimConn = nil end
    if not e then return end
    aimConn = RS.RenderStepped:Connect(function()
        if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
        local t = GetBestTarget()
        if not t or not t.Character then return end
        local predicted = PredictPos(t.Character)
        if not predicted then return end
        local sp, onScreen = Cam:WorldToViewportPoint(predicted)
        if not onScreen then return end
        local delta = Vector2.new(sp.X, sp.Y) - UIS:GetMouseLocation()
        mousemoverel(delta.X * AimSmooth, delta.Y * AimSmooth)
    end)
end

-- Fly
local function ToggleFly(e)
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    if e then
        flyBV = Instance.new("BodyVelocity", hrp)
        flyBV.Velocity = Vector3.new(0,0,0)
        flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
        flyBG = Instance.new("BodyGyro", hrp)
        flyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        flyBG.P = 9e4
        flyConn = RS.RenderStepped:Connect(function()
            if not hrp then return end
            local md = Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then md += Cam.CFrame.LookVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.S) then md -= Cam.CFrame.LookVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.A) then md -= Cam.CFrame.RightVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.D) then md += Cam.CFrame.RightVector * FlySpeed end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then md += Vector3.new(0, FlySpeed, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then md -= Vector3.new(0, FlySpeed, 0) end
            flyBV.Velocity = md
            flyBG.CFrame = Cam.CFrame
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end
end

-- Baseplate
local function GetMapSurfaceY()
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {char}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(hrp.Position, Vector3.new(0, -500, 0), params)
        if result then return result.Position.Y end
    end
    return 0
end

local function ToggleBaseplate(e)
    BaseplateEnabled = e
    if e then
        local surfaceY = GetMapSurfaceY()
        baseplateInstance = Instance.new("Part")
        baseplateInstance.Name = RandStr(8)
        baseplateInstance.Anchored = true
        baseplateInstance.CanCollide = true
        baseplateInstance.Transparency = 0
        baseplateInstance.Size = Vector3.new(10000, 1, 10000)
        baseplateInstance.Position = Vector3.new(0, surfaceY - 4.8, 0)
        baseplateInstance.Material = Enum.Material.Grass
        baseplateInstance.Color = Color3.fromRGB(106, 127, 63)
        baseplateInstance.Parent = workspace
    else
        if baseplateInstance then baseplateInstance:Destroy() baseplateInstance = nil end
    end
end

-- Noclip
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

-- Infinite Jump (undetected)
local function ToggleInfJump(e)
    if ijConn then ijConn:Disconnect() ijConn = nil end
    if not e then return end
    local function hookChar(char)
        if not char then return end
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        local hum = char:WaitForChild("Humanoid", 5)
        if not hrp or not hum then return end
        ijConn = UIS.JumpRequest:Connect(function()
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Freefall
            or state == Enum.HumanoidStateType.Jumping
            or state == Enum.HumanoidStateType.Running then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            end
        end)
    end
    hookChar(LP.Character)
    LP.CharacterAdded:Connect(hookChar)
end

-- =============================================
-- BUILD TABS
-- =============================================

local VisualsTab  = MakeTab("Visuals")
local CombatTab   = MakeTab("Combat")
local MovementTab = MakeTab("Movement")
local SafeTab     = MakeTab("Safe")
local MiscTab     = MakeTab("Misc")

-- activate first tab
do
    local first = tabs["Visuals"]
    first.page.Visible = true
    first.btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    first.btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Visuals
AddSection(VisualsTab, "ESP")
AddToggle(VisualsTab, "ESP", false, ToggleESP)
AddToggle(VisualsTab, "Team Check", false, function(v)
    TeamCheckEnabled = v
    if ESPEnabled then ToggleESP(true) end
end)

-- Combat
AddSection(CombatTab, "Aim Assist")
AddToggle(CombatTab, "Aim Assist  [Hold RMB]", false, ToggleAim)
AddToggle(CombatTab, "Wall Check", false, function(v) WallCheckEnabled = v end)
AddSlider(CombatTab, "Aim Smoothness", 1, 100, 15, "%", function(v) AimSmooth = v / 100 end)
AddSlider(CombatTab, "Aim FOV", 50, 500, 200, "px", function(v) AimFOV = v end)

-- Movement
AddSection(MovementTab, "Movement")
AddToggle(MovementTab, "Fly  [WASD + Space/Shift]", false, ToggleFly)
AddSlider(MovementTab, "Fly Speed", 10, 200, 50, "", function(v) FlySpeed = v end)
AddToggle(MovementTab, "Noclip", false, ToggleNoclip)
AddToggle(MovementTab, "Infinite Jump", false, ToggleInfJump)
AddSlider(MovementTab, "WalkSpeed", 16, 200, 16, "", function(v)
    local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = v end
end)
AddSlider(MovementTab, "Jump Power", 50, 300, 50, "", function(v)
    local hum = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if hum then hum.JumpPower = v end
end)

-- Safe
AddSection(SafeTab, "Position Info")
local posLbl = AddLabel(SafeTab, "Y Position: --")
RS.RenderStepped:Connect(function()
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local y = math.floor(char.HumanoidRootPart.Position.Y * 10) / 10
        posLbl.Text = "Y Position: " .. tostring(y)
    end
end)
AddSection(SafeTab, "Anti-Fling")
AddToggle(SafeTab, "Void Baseplate", false, ToggleBaseplate)
AddInput(SafeTab, "Set Baseplate Y", "Enter Y value...", function(val)
    local y = tonumber(val)
    if y and baseplateInstance then
        baseplateInstance.Position = Vector3.new(0, y - 0.5, 0)
    end
end)
AddLabel(SafeTab, "Stand on floor, note Y, toggle baseplate, adjust Y.")

-- Misc
AddSection(MiscTab, "Info")
AddLabel(MiscTab, "Seraphix v2.0  |  by Zxnox")

-- =============================================
-- FPS COUNTER
-- =============================================
local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = _FPS_ID
fpsGui.ResetOnSpawn = false
fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() fpsGui.Parent = CoreGui end)
if not fpsGui.Parent then fpsGui.Parent = LP:WaitForChild("PlayerGui") end

local fpsBG = Instance.new("Frame", fpsGui)
fpsBG.Size = UDim2.new(0, 110, 0, 44)
fpsBG.Position = UDim2.new(0, 12, 0, 12)
fpsBG.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
fpsBG.BorderSizePixel = 0
Instance.new("UICorner", fpsBG).CornerRadius = UDim.new(0, 8)
local fpsBorder = Instance.new("UIStroke", fpsBG)
fpsBorder.Color = Color3.fromRGB(255, 255, 255)
fpsBorder.Thickness = 1
fpsBorder.Transparency = 0.85
local fpsDot = Instance.new("Frame", fpsBG)
fpsDot.Size = UDim2.new(0, 7, 0, 7)
fpsDot.Position = UDim2.new(0, 12, 0.5, -3)
fpsDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fpsDot.BorderSizePixel = 0
Instance.new("UICorner", fpsDot).CornerRadius = UDim.new(1, 0)
local fpsLabel = Instance.new("TextLabel", fpsBG)
fpsLabel.Size = UDim2.new(1, -30, 1, 0)
fpsLabel.Position = UDim2.new(0, 26, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 15
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

local fc, el = 0, 0
RS.RenderStepped:Connect(function(dt)
    fc += 1; el += dt
    if el >= 0.5 then
        local fps = math.floor(fc / el)
        fpsLabel.Text = "FPS: " .. fps
        fc, el = 0, 0
        fpsDot.BackgroundColor3 = fps >= 55 and Color3.fromRGB(100,255,100) or fps >= 30 and Color3.fromRGB(255,200,50) or Color3.fromRGB(255,80,80)
    end
end)

-- =============================================
-- CAR SPEED MODIFIER
-- =============================================
local CarSpeedEnabled = false
local CarSpeedMult = 2
local carConn = nil

local function GetSeat()
    local char = LP.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    -- check if seated in a VehicleSeat
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart and hum.SeatPart:IsA("VehicleSeat") then
        return hum.SeatPart
    end
    return nil
end

local function ToggleCarSpeed(e)
    CarSpeedEnabled = e
    if carConn then carConn:Disconnect() carConn = nil end
    if not e then
        local seat = GetSeat()
        if seat then seat.MaxSpeed = 100 end
        return
    end
    carConn = RS.Heartbeat:Connect(function()
        local seat = GetSeat()
        if not seat then return end
        local root = seat.AssemblyRootPart or seat
        if not root or not root:IsA("BasePart") then return end
        seat.MaxSpeed = 1e6 -- uncap it entirely
        if seat.ThrottleFloat ~= 0 then
            local dir = (seat.CFrame.LookVector * seat.ThrottleFloat)
            local speed = seat.ThrottleFloat > 0 and (CarSpeedMult * 100) or 50
            root.AssemblyLinearVelocity = dir * speed
        end
    end)
end

-- add to Movement tab
AddSection(MovementTab, "Vehicle")
AddToggle(MovementTab, "Car Speed Boost", false, ToggleCarSpeed)
AddSlider(MovementTab, "Speed Multiplier", 1, 50, 5, "x", function(v)
    CarSpeedMult = v
end)
