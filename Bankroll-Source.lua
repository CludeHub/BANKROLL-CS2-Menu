-- Bankroll UI Module (tab-aware, preserves original design)
local Bankroll = {}
Bankroll.__index = Bankroll

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Helper to create UIGradient
local function createGradient(parent, color1, color2, rotation)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color1), ColorSequenceKeypoint.new(1, color2)})
    grad.Rotation = rotation or 0
    grad.Parent = parent
    return grad
end

-- Helper to create UIStroke
local function createUIStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(53,53,53)
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- Helper to create UICorner
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0,4)
    corner.Parent = parent
    return corner
end

-- Create a window
function Bankroll:AddWindow(title)
    local self = setmetatable({}, Bankroll)
    
    -- ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Bankroll"
    self.ScreenGui.Enabled = true
    self.ScreenGui.DisplayOrder = 0
    self.ScreenGui.IgnoreGuiInset = false
    self.ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    self.Frame = Instance.new("Frame")
    self.Frame.Name = "Frame"
    self.Frame.Position = UDim2.new(0,0,0,0)
    self.Frame.Size = UDim2.new(0.56,0,0.939,0)
    self.Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
    self.Frame.BackgroundTransparency = 0
    self.Frame.BorderSizePixel = 0
    self.Frame.ClipsDescendants = false
    self.Frame.Visible = true
    self.Frame.Active = true
    self.Frame.Draggable = true
    self.Frame.ZIndex = 1
    self.Frame.LayoutOrder = 0
    self.Frame.AutomaticSize = Enum.AutomaticSize.None
    self.Frame.Parent = self.ScreenGui

    createGradient(self.Frame, Color3.fromRGB(15,15,15), Color3.fromRGB(9,9,9), 90)
    createUIStroke(self.Frame, Color3.fromRGB(44,44,44), 1)
    self.UIScale = Instance.new("UIScale")
    self.UIScale.Scale = 0.9
    self.UIScale.Parent = self.Frame

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Position = UDim2.new(0,0,0,0)
    Header.Size = UDim2.new(1,0,0.05,0)
    Header.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Header.BackgroundTransparency = 0
    Header.BorderSizePixel = 0
    Header.ClipsDescendants = false
    Header.ZIndex = 1
    Header.Parent = self.Frame
    createGradient(Header, Color3.fromRGB(18,18,18), Color3.fromRGB(30,30,30), 90)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Position = UDim2.new(0.3,0,0,0)
    TitleLabel.Size = UDim2.new(0.3,0,0.8,0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "Bankroll Mafia"
    TitleLabel.TextColor3 = Color3.fromRGB(255,191,255)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSansSemibold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    TitleLabel.Parent = Header

    -- Bottom Frame (Tabs)
    self.Bottom = Instance.new("Frame")
    self.Bottom.Name = "Bottom"
    self.Bottom.Position = UDim2.new(0,0,0.909,0)
    self.Bottom.Size = UDim2.new(1,0,0.091,0)
    self.Bottom.BackgroundTransparency = 0
    self.Bottom.BackgroundColor3 = Color3.fromRGB(255,255,255)
    self.Bottom.Parent = self.Frame

    -- Tab scroll
    self.TabScroll = Instance.new("ScrollingFrame")
    self.TabScroll.Name = "TabScroll"
    self.TabScroll.Size = UDim2.new(1,0,1,0)
    self.TabScroll.Position = UDim2.new(0,0,0,0)
    self.TabScroll.BackgroundTransparency = 1
    self.TabScroll.ScrollBarThickness = 0
    self.TabScroll.CanvasSize = UDim2.new(0,0,0,0)
    self.TabScroll.Parent = self.Bottom

    -- UIListLayout for tabs
    self.TabList = Instance.new("UIListLayout")
    self.TabList.FillDirection = Enum.FillDirection.Horizontal
    self.TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    self.TabList.VerticalAlignment = Enum.VerticalAlignment.Top
    self.TabList.Padding = UDim.new(0,4)
    self.TabList.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabList.Parent = self.TabScroll

    self.TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.TabScroll.CanvasSize = UDim2.new(0, self.TabList.AbsoluteContentSize.X, 0, 0)
    end)

    self.Tabs = {}
    return self
end

-- Add tab
function Bankroll:AddTab(tabName)
    local tab = {}
    
    tab.Frame = Instance.new("Frame")
    tab.Frame.Name = "TabButton"
    tab.Frame.Size = UDim2.new(0.17,0,0.8,0)
    tab.Frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
    tab.Frame.Parent = self.TabScroll
    createGradient(tab.Frame, Color3.fromRGB(16,16,16), Color3.fromRGB(28,28,28), -90)
    createUIStroke(tab.Frame, Color3.fromRGB(53,53,53), 1)
    createUICorner(tab.Frame)

    -- TextLabel
    tab.TextLabel = Instance.new("TextLabel")
    tab.TextLabel.Size = UDim2.new(0.92,0,0.787,0)
    tab.TextLabel.BackgroundTransparency = 1
    tab.TextLabel.Text = tabName or "Tab"
    tab.TextLabel.TextColor3 = Color3.fromRGB(127,127,127)
    tab.TextLabel.TextScaled = true
    tab.TextLabel.Font = Enum.Font.SourceSansSemibold
    tab.TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    tab.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    tab.TextLabel.Parent = tab.Frame

    -- Invisible button
    tab.Button = Instance.new("TextButton")
    tab.Button.Size = UDim2.new(1,0,1,0)
    tab.Button.BackgroundTransparency = 1
    tab.Button.Text = ""
    tab.Button.Parent = tab.Frame

    -- Sections container inside window
    tab.SectionsContainer = Instance.new("Frame")
    tab.SectionsContainer.Name = tabName.."_Sections"
    tab.SectionsContainer.Size = UDim2.new(1,0,0.82,0)
    tab.SectionsContainer.Position = UDim2.new(0,0,0,0)
    tab.SectionsContainer.BackgroundTransparency = 1
    tab.SectionsContainer.Parent = self.Frame
    tab.SectionsContainer.Visible = false

    -- Show this tab when clicked
    tab.Button.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.SectionsContainer.Visible = false
        end
        tab.SectionsContainer.Visible = true
    end)

    -- Method to add section
    function tab:AddSection(sectionName, position)
        position = position or "left"
        local section = Instance.new("Frame")
        section.Name = sectionName
        section.Position = UDim2.new(0,0,0,0)
        section.Size = UDim2.new(0.49,0,1,0)
        section.BackgroundColor3 = Color3.fromRGB(25,25,25)
        section.BackgroundTransparency = 0
        section.BorderSizePixel = 1
        section.ClipsDescendants = false
        section.Visible = true
        section.AutomaticSize = Enum.AutomaticSize.Y
        section.Parent = tab.SectionsContainer
        createUICorner(section)
        createUIStroke(section, Color3.fromRGB(44,44,44), 1)
        createGradient(section, Color3.fromRGB(25,25,25), Color3.fromRGB(12,12,12), 90)

        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Size = UDim2.new(1,0,0.99,0)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Text = sectionName or "Section"
        SectionTitle.TextColor3 = Color3.fromRGB(123,123,123)
        SectionTitle.TextScaled = true
        SectionTitle.Font = Enum.Font.SourceSansSemibold
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Center
        SectionTitle.TextYAlignment = Enum.TextYAlignment.Center
        SectionTitle.Parent = section

        return section
    end

    table.insert(self.Tabs, tab)
    return tab
end

return Bankroll
