local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Cleanup
if CoreGui:FindFirstChild("OneNineOneMenu") then CoreGui.OneNineOneMenu:Destroy() end

-- 1. Main UI Container
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "OneNineOneMenu"

-- 2. Geometric Background Frame
local MainFrame = Instance.new("ImageLabel", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 320)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Image = "rbxassetid://YOUR_IMAGE_ID_HERE" -- Replace with your Decal ID
MainFrame.ScaleType = Enum.ScaleType.Crop
MainFrame.Active = true
MainFrame.Draggable = true

-- Dark overlay for contrast
local Overlay = Instance.new("Frame", MainFrame)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.BorderSizePixel = 0

-- 3. Title (Changed to 191)
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "191"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.ZIndex = 2

-- 4. Functional Logic
local waypoint = nil

local function blink()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = root.CFrame * CFrame.new(0, 0, -5)
    end
end

-- Keybind for Blink (Press Q)
UIS.InputBegan:Connect(function(input, chat)
    if chat then return end
    if input.KeyCode == Enum.KeyCode.Q then
        blink()
    end
end)

-- 5. Button Creator
local function createBtn(text, func)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.85, 0, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.BackgroundTransparency = 0.2
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.ZIndex = 2
    
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", b)
    stroke.Color = Color3.fromRGB(80, 80, 80)
    
    b.MouseButton1Click:Connect(func)
end

local Layout = Instance.new("UIListLayout", MainFrame)
Layout.Padding = UDim.new(0, 7)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder

Instance.new("UIPadding", MainFrame).PaddingTop = UDim.new(0, 55)

-- 6. Execute Buttons
createBtn("SET WAYPOINT", function()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then waypoint = root.Position end
end)

createBtn("TELEPORT", function()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root and waypoint then root.CFrame = CFrame.new(waypoint + Vector3.new(0, 2, 0)) end
end)

createBtn("BLINK (Q)", blink)

createBtn("SPEED (100)", function()
    if Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 100
    end
end)

createBtn("CLOSE", function()
    ScreenGui:Destroy()
end)
