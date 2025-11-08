local Bankroll = {}
Bankroll.__index = Bankroll

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------------------
-- CREATE WINDOW
---------------------------------------------------------------------
function Bankroll:AddWindow(windowName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = windowName or "BankrollUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Active = true
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    Frame.Size = UDim2.new(0.44196, 0, 0.87707, 0)
    Frame.Position = UDim2.new(0.27728, 0, 0.01587, 0)
    Frame.Parent = ScreenGui

    local Aspect = Instance.new("UIAspectRatioConstraint")
    Aspect.AspectRatio = 1.19005
    Aspect.Parent = Frame

    -- Header
    local Header = Instance.new("Frame")
    Header.BorderSizePixel = 0
    Header.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    Header.Size = UDim2.new(1, 0, 0.04525, 0)
    Header.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.BorderSizePixel = 0
    Title.BackgroundTransparency = 1
    Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
    Title.TextColor3 = Color3.fromRGB(238,165,255)
    Title.TextScaled = true
    Title.Text = windowName or "Bankroll"
    Title.Size = UDim2.new(0.19011, 0, 0.85, 0)
    Title.Position = UDim2.new(0.36, 0, 0, 0)
    Title.Parent = Header

    local HeaderLine = Instance.new("Frame")
    HeaderLine.BorderSizePixel = 0
    HeaderLine.BackgroundColor3 = Color3.fromRGB(161,112,173)
    HeaderLine.Size = UDim2.new(1,0,0.05,0)
    HeaderLine.Position = UDim2.new(0,0,1,0)
    HeaderLine.Parent = Header

    -- Bottom Tabs Bar
    local Bottom = Instance.new("Frame")
    Bottom.BorderSizePixel = 0
    Bottom.BackgroundColor3 = Color3.fromRGB(27,27,27)
    Bottom.Size = UDim2.new(1,0,0.09955,0)
    Bottom.Position = UDim2.new(0,0,0.90045,0)
    Bottom.Parent = Frame

    local BottomLine = Instance.new("Frame")
    BottomLine.BorderSizePixel = 0
    BottomLine.BackgroundColor3 = Color3.fromRGB(161,111,173)
    BottomLine.Size = UDim2.new(1,0,0.02273,0)
    BottomLine.Position = UDim2.new(0,0,-0.02273,0)
    BottomLine.Parent = Bottom

    local TabHolder = Instance.new("UIListLayout")
    TabHolder.Parent = Bottom
    TabHolder.FillDirection = Enum.FillDirection.Horizontal
    TabHolder.VerticalAlignment = Enum.VerticalAlignment.Center
    TabHolder.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabHolder.Padding = UDim.new(0,12)

    -- Container
    local Container = Instance.new("Frame")
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(0.94677, 0, 0.80995, 0)
    Container.Position = UDim2.new(0.02662, 0, 0.06335, 0)
    Container.Parent = Frame

    local ContainerLayout = Instance.new("UIListLayout")
    ContainerLayout.Wraps = true
    ContainerLayout.FillDirection = Enum.FillDirection.Horizontal
    ContainerLayout.Padding = UDim.new(0,4)
    ContainerLayout.Parent = Container

    ----------------------------------------------------------------
    -- Left / Right Panels
    ----------------------------------------------------------------
    local Left = Instance.new("ScrollingFrame")
    Left.BackgroundTransparency = 1
    Left.Size = UDim2.new(0.49, 0, 1, 0)
    Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Left.ScrollBarThickness = 0
    Left.Name = "Left"
    Left.Parent = Container

    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Padding = UDim.new(0,4)
    LeftLayout.Parent = Left

    local Right = Instance.new("ScrollingFrame")
    Right.BackgroundTransparency = 1
    Right.Size = UDim2.new(0.49, 0, 1, 0)
    Right.Name = "Right"
    Right.Parent = Container

    local RightLayout = Instance.new("UIListLayout")
    RightLayout.Padding = UDim.new(0,4)
    RightLayout.Parent = Right

    --------------------------------------------------------------------
    -- WINDOW OBJECT
    --------------------------------------------------------------------
    local window = {
        ScreenGui = ScreenGui,
        Frame = Frame,
        Bottom = Bottom,
        Container = Container,
        Left = Left,
        Right = Right,
        Tabs = {}
    }

    setmetatable(window, Bankroll)
    return window
end

---------------------------------------------------------------------
-- CREATE TAB
---------------------------------------------------------------------
function Bankroll:AddTab(tabName, icon)
    local Button = Instance.new("TextButton")
    Button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Button.Text = "   " .. tabName
    Button.Size = UDim2.new(0,120,0.7,0)
    Button.TextColor3 = Color3.fromRGB(255,255,255)
    Button.Parent = self.Bottom

    local tab = { Sections = {}, Button = Button }

    Button.MouseButton1Click:Connect(function()
        for _, s in pairs(self.Sections or {}) do
            s.Frame.Visible = false
        end
        for _, section in ipairs(tab.Sections) do
            section.Frame.Visible = true
        end
    end)

    table.insert(self.Tabs, tab)
    return tab
end

---------------------------------------------------------------------
-- CREATE SECTION (LEFT or RIGHT)
---------------------------------------------------------------------
function Bankroll:CreateSection(tab, side, title)
    local Parent = (side == "right" or side == "Right") and self.Right or self.Left

    local Section = Instance.new("Frame")
    Section.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1, -10, 0, 40)
    Section.Parent = Parent

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.Text = title
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Size = UDim2.new(1,0,1,0)
    Label.Parent = Section

    local sec = {
        Frame = Section
    }

    table.insert(tab.Sections, sec)
    return sec
end

---------------------------------------------------------------------

return Bankroll
