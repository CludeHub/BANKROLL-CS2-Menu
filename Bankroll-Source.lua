--// BANKROLL UI LIBRARY (LEFT + RIGHT SECTIONS)
local Bankroll = {}
Bankroll.Theme = {
    Background = Color3.fromRGB(16,16,16),
    Header = Color3.fromRGB(27,27,27),
    Accent = Color3.fromRGB(161,112,173),
    Text = Color3.fromRGB(238,165,255),
}

local Players = game:GetService("Players")
local LP = Players.LocalPlayer


----------------------------------------------------------------
--  WINDOW
----------------------------------------------------------------
function Bankroll:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LP:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0.45,0,0.88,0)
    Main.Position = UDim2.new(0.28,0,0.02,0)
    Main.BackgroundColor3 = self.Theme.Background
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Parent = ScreenGui

    local Aspect = Instance.new("UIAspectRatioConstraint", Main)
    Aspect.AspectRatio = 1.19

    -- HEADER
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0.045,0)
    Header.BackgroundColor3 = self.Theme.Header
    Header.BorderSizePixel = 0
    Header.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.2,0,1,0)
    Title.Position = UDim2.new(0.36,0,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = titleText or "Bankroll"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextColor3 = self.Theme.Text
    Title.TextScaled = true
    Title.Parent = Header

    local HeaderLine = Instance.new("Frame")
    HeaderLine.Size = UDim2.new(1,0,0.05,0)
    HeaderLine.Position = UDim2.new(0,0,1,0)
    HeaderLine.BackgroundColor3 = self.Theme.Accent
    HeaderLine.BorderSizePixel = 0
    HeaderLine.Parent = Header

    ---------------------------------------------------------------
    -- MAIN CONTAINER (holds Left + Right columns)
    ---------------------------------------------------------------
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(0.95,0,0.82,0)
    Container.Position = UDim2.new(0.025,0,0.06,0)
    Container.Parent = Main

    local Left = Instance.new("ScrollingFrame")
    Left.Name = "Left"
    Left.Size = UDim2.new(0.49,0,1,0)
    Left.BackgroundTransparency = 1
    Left.BorderSizePixel = 0
    Left.CanvasSize = UDim2.new(0,0,0,0)
    Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Left.Parent = Container

    local LeftLayout = Instance.new("UIListLayout", Left)
    LeftLayout.Padding = UDim.new(0,6)
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Right = Instance.new("ScrollingFrame")
    Right.Name = "Right"
    Right.Size = UDim2.new(0.49,0,1,0)
    Right.Position = UDim2.new(0.51,0,0,0)
    Right.BackgroundTransparency = 1
    Right.BorderSizePixel = 0
    Right.CanvasSize = UDim2.new(0,0,0,0)
    Right.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Right.Parent = Container

    local RightLayout = Instance.new("UIListLayout", Right)
    RightLayout.Padding = UDim.new(0,6)
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder

    ---------------------------------------------------------------
    -- BOTTOM TABS
    ---------------------------------------------------------------
    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(1,0,0.10,0)
    TabBar.Position = UDim2.new(0,0,0.90,0)
    TabBar.BackgroundColor3 = self.Theme.Header
    TabBar.BorderSizePixel = 0
    TabBar.Parent = Main

    local TabLine = Instance.new("Frame")
    TabLine.Size = UDim2.new(1,0,0.0227,0)
    TabLine.Position = UDim2.new(0,0,-0.0227,0)
    TabLine.BackgroundColor3 = self.Theme.Accent
    TabLine.BorderSizePixel = 0
    TabLine.Parent = TabBar

    local TabLayout = Instance.new("UIListLayout", TabBar)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0,8)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local window = {
        Left = Left,
        Right = Right,
        NextSide = "Left",
        TabBar = TabBar,
        Tabs = {},
    }

    return setmetatable(window, {__index = Bankroll})
end



----------------------------------------------------------------
--  SECTION (title + container)
----------------------------------------------------------------
function Bankroll:AddSection(title)
    local Parent
    if self.NextSide == "Left" then
        Parent = self.Left
        self.NextSide = "Right"
    else
        Parent = self.Right
        self.NextSide = "Left"
    end

    local Section = Instance.new("Frame")
    Section.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Section.BorderSizePixel = 0
    Section.Size = UDim2.new(1,0,0,60)
    Section.AutomaticSize = Enum.AutomaticSize.Y
    Section.Parent = Parent

    local Layout = Instance.new("UIListLayout", Section)
    Layout.Padding = UDim.new(0,4)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,20)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.Font = Enum.Font.SourceSansBold
    Title.TextColor3 = self.Theme.Text
    Title.TextScaled = true
    Title.Parent = Section

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1,0,0,0)
    Content.BackgroundTransparency = 1
    Content.AutomaticSize = Enum.AutomaticSize.Y
    Content.Parent = Section

    local ContentLayout = Instance.new("UIListLayout", Content)
    ContentLayout.Padding = UDim.new(0,4)

    -------------------------------------------------
    -- RETURN SECTION OBJECT (for adding elements)
    -------------------------------------------------
    local section = {
        Holder = Section,
        Content = Content,
    }

    function section:AddElement(elem)
        elem.Parent = Content
        return elem
    end

    return section
end



----------------------------------------------------------------
--  ADD TAB
----------------------------------------------------------------
function Bankroll:AddTab(tabName, iconId)
    local Tab = Instance.new("Frame")
    Tab.Name = tabName
    Tab.Size = UDim2.new(0.22,0,0.9,0)
    Tab.BackgroundTransparency = 1
    Tab.Parent = self.TabBar

    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0.3,0,0.7,0)
    Icon.Position = UDim2.new(0.05,0,0.15,0)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId or "rbxassetid://3926305904"
    Icon.ImageColor3 = self.Theme.Text
    Icon.Parent = Tab

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(0.6,0,1,0)
    Text.Position = UDim2.new(0.38,0,0,0)
    Text.BackgroundTransparency = 1
    Text.Text = tabName
    Text.Font = Enum.Font.SourceSansBold
    Text.TextColor3 = self.Theme.Text
    Text.TextScaled = true
    Text.Parent = Tab

    self.Tabs[tabName] = {
        Button = Tab,
        Icon = Icon,
        Text = Text,
    }

    return self.Tabs[tabName]
end

return Bankroll
