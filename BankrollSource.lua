local UIBankroll = {}

function UIBankroll:AddWindow(TitleHub)
local Window = {}
local windowSize = UDim2.new(0.5600000023841858,0,0.9390000104904175,0)

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
Bankroll = Instance.new('ScreenGui')
Bankroll.Name = "Bankroll"
Bankroll.Enabled = true
Bankroll.DisplayOrder = 0
Bankroll.IgnoreGuiInset = false
Bankroll.Parent = PlayerGui

Frame = Instance.new('Frame')
Frame.Name = "Frame"
Frame.Position = UDim2.new(0,0,0,0)
Frame.Size = windowSize
Frame.AnchorPoint = Vector2.new(0,0)
Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
Frame.BackgroundTransparency = 0
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = false
Frame.Visible = true
Frame.ZIndex = 1
Frame.AutomaticSize = Enum.AutomaticSize.None
Frame.LayoutOrder = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = Bankroll

Bottom = Instance.new('Frame')
Bottom.Name = "Bottom"
Bottom.Position = UDim2.new(0,0,0.9089999794960022,0)
Bottom.Size = UDim2.new(1,0,0.09000000357627869,0)
Bottom.AnchorPoint = Vector2.new(0,0)
Bottom.BackgroundColor3 = Color3.fromRGB(255,255,255)
Bottom.BackgroundTransparency = 0
Bottom.BorderSizePixel = 0
Bottom.ClipsDescendants = false
Bottom.Visible = true
Bottom.ZIndex = 1
Bottom.AutomaticSize = Enum.AutomaticSize.None
Bottom.LayoutOrder = 0
Bottom.Parent = Frame

local TabScroll = Instance.new('ScrollingFrame')
TabScroll.Name = "TabScroll"
TabScroll.Position = UDim2.new(0, 0, 0.1, 0)
TabScroll.Size = UDim2.new(1, 0, 0.899, 0)
TabScroll.AnchorPoint = Vector2.new(0, 0)
TabScroll.BackgroundColor3 = Color3.fromRGB(162, 162, 162)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 4
TabScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
TabScroll.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
TabScroll.VerticalScrollBarInset = Enum.ScrollBarInset.None
TabScroll.ScrollingDirection = Enum.ScrollingDirection.X
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.Visible = true
TabScroll.ZIndex = 1
TabScroll.LayoutOrder = 0
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.None -- ⚠ disable auto, we handle it manually
TabScroll.Parent = Bottom

local UIListLayout = Instance.new('UIListLayout')
UIListLayout.Name = "UIListLayout"
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = TabScroll

-- ✅ Fixed canvas size bug (always allows scrolling to the last tab)
local function UpdateCanvasSize()
local contentSize = UIListLayout.AbsoluteContentSize
TabScroll.CanvasSize = UDim2.new(0, contentSize.X + 20, 0, TabScroll.AbsoluteSize.Y)
end

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
UpdateCanvasSize()

BottomLine = Instance.new('Frame')
BottomLine.Name = "BottomLine"
BottomLine.Position = UDim2.new(0,0,0,0)
BottomLine.Size = UDim2.new(1,0,0.029999999329447746,0)
BottomLine.AnchorPoint = Vector2.new(0,0)
BottomLine.BackgroundColor3 = Color3.fromRGB(255,255,255)
BottomLine.BackgroundTransparency = 0
BottomLine.BorderSizePixel = 0
BottomLine.ClipsDescendants = false
BottomLine.Visible = true
BottomLine.ZIndex = 3
BottomLine.AutomaticSize = Enum.AutomaticSize.None
BottomLine.LayoutOrder = 0
BottomLine.Parent = Bottom

UIGradient_2 = Instance.new('UIGradient')
UIGradient_2.Name = "UIGradient"
UIGradient_2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,191,255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(65,48,65))})
UIGradient_2.Rotation = 0
UIGradient_2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_2.Offset = Vector2.new(0,0.5)
UIGradient_2.Parent = BottomLine

BottomLin2 = Instance.new('Frame')
BottomLin2.Name = "BottomLin2"
BottomLin2.Position = UDim2.new(0,0,0,0)
BottomLin2.Size = UDim2.new(0.5,0,0.019999999552965164,0)
BottomLin2.AnchorPoint = Vector2.new(0,0)
BottomLin2.BackgroundColor3 = Color3.fromRGB(255,255,255)
BottomLin2.BackgroundTransparency = 0
BottomLin2.BorderSizePixel = 0
BottomLin2.ClipsDescendants = false
BottomLin2.Visible = true
BottomLin2.ZIndex = 4
BottomLin2.AutomaticSize = Enum.AutomaticSize.None
BottomLin2.LayoutOrder = 0
BottomLin2.Parent = Bottom

UIGradient_3 = Instance.new('UIGradient')
UIGradient_3.Name = "UIGradient"
UIGradient_3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(63,47,63)),ColorSequenceKeypoint.new(1, Color3.fromRGB(181,136,181))})
UIGradient_3.Rotation = 0
UIGradient_3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_3.Offset = Vector2.new(0,0.5)
UIGradient_3.Parent = BottomLin2

UIGradient_4 = Instance.new('UIGradient')
UIGradient_4.Name = "UIGradient"
UIGradient_4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,30))})
UIGradient_4.Rotation = 90
UIGradient_4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_4.Offset = Vector2.new(0,0)
UIGradient_4.Parent = Bottom

Container = Instance.new('Frame')
Container.Name = "Container"
Container.Position = UDim2.new(0.014000000432133675,0,0.06700000166893005,0)
Container.Size = UDim2.new(0.9700000286102295,0,0.8240000009536743,0)
Container.AnchorPoint = Vector2.new(0,0)
Container.BackgroundColor3 = Color3.fromRGB(255,255,255)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 1
Container.ClipsDescendants = false
Container.Visible = true
Container.ZIndex = 1
Container.AutomaticSize = Enum.AutomaticSize.None
Container.LayoutOrder = 0
Container.Parent = Frame

UIGradient_10 = Instance.new('UIGradient')
UIGradient_10.Name = "UIGradient"
UIGradient_10.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(15,15,15)),ColorSequenceKeypoint.new(1, Color3.fromRGB(9,9,9))})
UIGradient_10.Rotation = 90
UIGradient_10.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_10.Offset = Vector2.new(0,0)
UIGradient_10.Parent = Frame

UIAspectRatioConstraint_6 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_6.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_6.AspectRatio = 1.159999966621399
UIAspectRatioConstraint_6.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_6.Parent = Frame

UIScale = Instance.new('UIScale')
UIScale.Name = "UIScale"
UIScale.Scale = 0.75
UIScale.Parent = Frame

Header = Instance.new('Frame')
Header.Name = "Header"
Header.Position = UDim2.new(0,0,0,0)
Header.Size = UDim2.new(1,0,0.05000000074505806,0)
Header.AnchorPoint = Vector2.new(0,0)
Header.BackgroundColor3 = Color3.fromRGB(255,255,255)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0
Header.ClipsDescendants = false
Header.Visible = true
Header.ZIndex = 1
Header.AutomaticSize = Enum.AutomaticSize.None
Header.LayoutOrder = 0
Header.Parent = Frame

HeaderLine = Instance.new('Frame')
HeaderLine.Name = "HeaderLine"
HeaderLine.Position = UDim2.new(0,0,1,0)
HeaderLine.Size = UDim2.new(1,0,0.06800000369548798,0)
HeaderLine.AnchorPoint = Vector2.new(0,0)
HeaderLine.BackgroundColor3 = Color3.fromRGB(255,255,255)
HeaderLine.BackgroundTransparency = 0
HeaderLine.BorderSizePixel = 0
HeaderLine.ClipsDescendants = false
HeaderLine.Visible = true
HeaderLine.ZIndex = 3
HeaderLine.AutomaticSize = Enum.AutomaticSize.None
HeaderLine.LayoutOrder = 0
HeaderLine.Parent = Header

UIGradient_11 = Instance.new('UIGradient')
UIGradient_11.Name = "UIGradient"
UIGradient_11.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,191,255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(65,48,65))})
UIGradient_11.Rotation = 0
UIGradient_11.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_11.Offset = Vector2.new(0,0.5)
UIGradient_11.Parent = HeaderLine

HeaderLin2 = Instance.new('Frame')
HeaderLin2.Name = "HeaderLin2"
HeaderLin2.Position = UDim2.new(0,0,1,0)
HeaderLin2.Size = UDim2.new(0.5,0,0.06800000369548798,0)
HeaderLin2.AnchorPoint = Vector2.new(0,0)
HeaderLin2.BackgroundColor3 = Color3.fromRGB(255,255,255)
HeaderLin2.BackgroundTransparency = 0
HeaderLin2.BorderSizePixel = 0
HeaderLin2.ClipsDescendants = false
HeaderLin2.Visible = true
HeaderLin2.ZIndex = 4
HeaderLin2.AutomaticSize = Enum.AutomaticSize.None
HeaderLin2.LayoutOrder = 0
HeaderLin2.Parent = Header

UIGradient_12 = Instance.new('UIGradient')
UIGradient_12.Name = "UIGradient"
UIGradient_12.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(63,47,63)),ColorSequenceKeypoint.new(1, Color3.fromRGB(181,136,181))})
UIGradient_12.Rotation = 0
UIGradient_12.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_12.Offset = Vector2.new(0,0.5)
UIGradient_12.Parent = HeaderLin2

Title = Instance.new('TextLabel')
Title.Name = "Title"
Title.Position = UDim2.new(0.30000001192092896,0,0,0)
Title.Size = UDim2.new(0.30000001192092896,0,0.800000011920929,0)
Title.AnchorPoint = Vector2.new(0,0)
Title.BackgroundColor3 = Color3.fromRGB(162,162,162)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 1
Title.TextColor3 = Color3.fromRGB(255,191,255)
Title.TextScaled = true
Title.Text = TitleHub or "Bankroll Mafia"
Title.TextSize = 8
Title.Font = Enum.Font.SourceSansSemibold
Title.TextTransparency = 0
Title.Visible = true
Title.ZIndex = 1
Title.AutomaticSize = Enum.AutomaticSize.None
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.LayoutOrder = 0
Title.Parent = Header

UIGradient_13 = Instance.new('UIGradient')
UIGradient_13.Name = "UIGradient"
UIGradient_13.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,30))})
UIGradient_13.Rotation = 90
UIGradient_13.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_13.Offset = Vector2.new(0,0)
UIGradient_13.Parent = Header

UIStroke_6 = Instance.new('UIStroke')
UIStroke_6.Name = "UIStroke"
UIStroke_6.Color = Color3.fromRGB(44,44,44)
UIStroke_6.Transparency = 0
UIStroke_6.Thickness = 1
UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke_6.Parent = Frame

Window.TabScroll = TabScroll
Window.Container = Container

local TabsAdded = 0

function Window:AddTab(TabTitle)
TabsAdded = TabsAdded + 1
local Window = self
local Tab = {}

TabButton = Instance.new('Frame')
TabButton.Name = "TabButton"
TabButton.Position = UDim2.new(0,0,0,0)
TabButton.Size = UDim2.new(0.17000000178813934,0,0.800000011920929,0)
TabButton.AnchorPoint = Vector2.new(0,0)
TabButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
TabButton.BackgroundTransparency = 0
TabButton.BorderSizePixel = 0
TabButton.ClipsDescendants = false
TabButton.Visible = true
TabButton.ZIndex = 1
TabButton.AutomaticSize = Enum.AutomaticSize.None
TabButton.LayoutOrder = TabsAdded
TabButton.Parent = TabScroll

local Aspect = Instance.new("UIAspectRatioConstraint")
Aspect.Name = "Aspect99"
Aspect.AspectRatio = 3.25
Aspect.Parent = TabButton

Text = Instance.new('TextLabel')
Text.Name = "Text"
Text.Position = UDim2.new(0,0,0,0)
Text.Size = UDim2.new(0.9179999828338623,0,0.7870000004768372,0)
Text.AnchorPoint = Vector2.new(0,0)
Text.BackgroundColor3 = Color3.fromRGB(162,162,162)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 1
Text.Text = TabTitle
Text.TextColor3 = Color3.fromRGB(127,127,127)
Text.TextScaled = true
Text.TextSize = 8
Text.Font = Enum.Font.SourceSansSemibold
Text.TextTransparency = 0
Text.Visible = true
Text.ZIndex = 1
Text.AutomaticSize = Enum.AutomaticSize.None
Text.TextXAlignment = Enum.TextXAlignment.Center
Text.TextYAlignment = Enum.TextYAlignment.Center
Text.LayoutOrder = 0
Text.Parent = TabButton

SwitchClick = Instance.new('TextButton')
SwitchClick.Name = "SwitchClick"
SwitchClick.Position = UDim2.new(0,0,0,0)
SwitchClick.Size = UDim2.new(1,0,1,0)
SwitchClick.AnchorPoint = Vector2.new(0,0)
SwitchClick.BackgroundColor3 = Color3.fromRGB(255,255,255)
SwitchClick.BackgroundTransparency = 1
SwitchClick.BorderSizePixel = 1
SwitchClick.Text = ""
SwitchClick.TextColor3 = Color3.fromRGB(27,42,53)
SwitchClick.TextScaled = false
SwitchClick.TextSize = 8
SwitchClick.Font = Enum.Font.Legacy
SwitchClick.TextTransparency = 0
SwitchClick.Visible = true
SwitchClick.ZIndex = 1
SwitchClick.AutomaticSize = Enum.AutomaticSize.None
SwitchClick.TextXAlignment = Enum.TextXAlignment.Center
SwitchClick.TextYAlignment = Enum.TextYAlignment.Center
SwitchClick.LayoutOrder = 0
SwitchClick.Parent = TabButton

UIGradient = Instance.new('UIGradient')
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 16))
})
UIGradient.Rotation = 0
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient.Offset = Vector2.new(0,0)
UIGradient.Parent = TabButton

UIStroke = Instance.new('UIStroke')
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.fromRGB(53,53,53)
UIStroke.Transparency = 0
UIStroke.Thickness = 1
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = TabButton

TabHose = Instance.new('Frame')
TabHose.Name = "TabHose"
TabHose.Position = UDim2.new(0,0,0,0)
TabHose.Size = UDim2.new(1,0,1,0)
TabHose.AnchorPoint = Vector2.new(0,0)
TabHose.BackgroundColor3 = Color3.fromRGB(162,162,162)
TabHose.BackgroundTransparency = 1
TabHose.BorderSizePixel = 1
TabHose.ClipsDescendants = false
TabHose.Visible = true
TabHose.ZIndex = 1
TabHose.AutomaticSize = Enum.AutomaticSize.None
TabHose.LayoutOrder = 0
TabHose.Parent = Container

UIListLayout_2 = Instance.new('UIListLayout')
UIListLayout_2.Name = "UIListLayout"
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_2.Padding = UDim.new(0,8)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Parent = TabHose

Right = Instance.new('ScrollingFrame')
Right.Name = "Right"
Right.Position = UDim2.new(0,0,0,0)
Right.Size = UDim2.new(0.48899999260902405,0,1,0)
Right.AnchorPoint = Vector2.new(0,0)
Right.BackgroundColor3 = Color3.fromRGB(162,162,162)
Right.BackgroundTransparency = 1
Right.BorderSizePixel = 0
Right.CanvasSize = UDim2.new(0,0,2,0)
Right.ScrollBarThickness = 0
Right.ScrollBarImageTransparency = 1
Right.Visible = true
Right.ZIndex = 1
Right.AutomaticCanvasSize = Enum.AutomaticSize.Y
Right.LayoutOrder = 2
Right.Parent = TabHose

Left = Instance.new('ScrollingFrame')
Left.Name = "Left"
Left.Position = UDim2.new(0,0,0,0)
Left.Size = UDim2.new(0.48899999260902405,0,1,0)
Left.AnchorPoint = Vector2.new(0,0)
Left.BackgroundColor3 = Color3.fromRGB(162,162,162)
Left.BackgroundTransparency = 1
Left.BorderSizePixel = 0
Left.ScrollBarImageTransparency = 1
Left.CanvasSize = UDim2.new(0,0,0,0)
Left.ScrollBarThickness = 0
Left.Visible = true
Left.ZIndex = 1
Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
Left.LayoutOrder = 1
Left.Parent = TabHose

-- For Right
UIListLayout_3 = Instance.new('UIListLayout')
UIListLayout_3.Name = "UIListLayout"
UIListLayout_3.FillDirection = Enum.FillDirection.Vertical
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_3.Padding = UDim.new(0,3)
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Parent = Right

-- Add this below Right layout
local function UpdateRightCanvas()
Right.CanvasSize = UDim2.new(0, UIListLayout_3.AbsoluteContentSize.X, 0, UIListLayout_3.AbsoluteContentSize.Y)
end
UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateRightCanvas)
UpdateRightCanvas()

-- For Left
UIListLayout_4 = Instance.new('UIListLayout')
UIListLayout_4.Name = "UIListLayout"
UIListLayout_4.FillDirection = Enum.FillDirection.Vertical
UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_4.Padding = UDim.new(0,10)
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Parent = Left

-- Add this below Left layout
local function UpdateLeftCanvas()
Left.CanvasSize = UDim2.new(0, UIListLayout_4.AbsoluteContentSize.X, 0, UIListLayout_4.AbsoluteContentSize.Y)
end
UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateLeftCanvas)
UpdateLeftCanvas()

Tab.Container = TabHose
local ThisButton = TabButton
Tab.Left = Left
Tab.Right = Right

        SwitchClick.MouseButton1Click:Connect(function()
for _, tab in pairs(Window.Container:GetChildren()) do
tab.Visible = (tab == Tab.Container)
end

for _, btn in pairs(Window.TabScroll:GetChildren()) do  
    if btn:FindFirstChild("Text") then  
        btn.Text.TextColor3 = (btn == ThisButton) and Color3.fromRGB(255,255,255) or Color3.fromRGB(127,127,127)  
    end  
end

end)

return Tab
    end

function Tab:AddSection(name, pos)
local Section = {}
pos = pos or "left"

section = Instance.new('Frame')
section.Name = "section"
section.Position = UDim2.new(0,0,0,0)
section.Size = UDim2.new(0.9800000190734863,0,0,0)
section.AnchorPoint = Vector2.new(0,0)
section.BackgroundColor3 = Color3.fromRGB(255,255,255)
section.BackgroundTransparency = 0
section.BorderSizePixel = 1
section.ClipsDescendants = false
section.Visible = true
section.ZIndex = 1
section.AutomaticSize = Enum.AutomaticSize.Y
section.LayoutOrder = 0
section.Parent = (pos=="left"and Tab.Left) or (pos=="right"and Tab.Right) or nil

UICorner_2 = Instance.new('UICorner')
UICorner_2.Name = "UICorner"
UICorner_2.CornerRadius = UDim.new(0,4)
UICorner_2.Parent = section

SectionTitle = Instance.new('TextLabel')
SectionTitle.Name = "SectionTitle"
SectionTitle.Position = UDim2.new(0,0,0,0)
SectionTitle.Size = UDim2.new(1,0,0.9909999966621399,0)
SectionTitle.AnchorPoint = Vector2.new(0,0)
SectionTitle.BackgroundColor3 = Color3.fromRGB(162,162,162)
SectionTitle.BackgroundTransparency = 1
SectionTitle.BorderSizePixel = 1
SectionTitle.Text = name or "Section"
SectionTitle.TextColor3 = Color3.fromRGB(123,123,123)
SectionTitle.TextScaled = true
SectionTitle.TextSize = 8
SectionTitle.Font = Enum.Font.SourceSansSemibold
SectionTitle.TextTransparency = 0
SectionTitle.Visible = true
SectionTitle.ZIndex = 1
SectionTitle.AutomaticSize = Enum.AutomaticSize.None
SectionTitle.TextXAlignment = Enum.TextXAlignment.Center
SectionTitle.TextYAlignment = Enum.TextYAlignment.Center
SectionTitle.LayoutOrder = 1
SectionTitle.Parent = section

UIStroke_5 = Instance.new('UIStroke')
UIStroke_5.Name = "UIStroke"
UIStroke_5.Color = Color3.fromRGB(44,44,44)
UIStroke_5.Transparency = 0
UIStroke_5.Thickness = 1
UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke_5.Parent = section

UIAspectRatioConstraint_2 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_2.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_2.AspectRatio = 14
UIAspectRatioConstraint_2.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_2.Parent = SectionTitle

UIListLayout_5 = Instance.new('UIListLayout')
UIListLayout_5.Name = "UIListLayout"
UIListLayout_5.FillDirection = Enum.FillDirection.Vertical
UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_5.Padding = UDim.new(0,6)
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Parent = section

UIGradient_6 = Instance.new('UIGradient')
UIGradient_6.Name = "UIGradient"
UIGradient_6.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(25,25,25)),ColorSequenceKeypoint.new(1, Color3.fromRGB(12,12,12))})
UIGradient_6.Rotation = 90
UIGradient_6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_6.Offset = Vector2.new(0,0.6000000238418579)
UIGradient_6.Parent = section

function Section:AddToggle(ToggleName, ToggleDefault, ToggleCallback)
local ToggleFu = {}

local Section = self

local Toggle = Instance.new('Frame')
local ToggleClick = Instance.new('TextButton')
local UIGradient_8 = Instance.new('UIGradient')
local toggled = ToggleDefault or false

Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0,0,0,0)
Toggle.Size = UDim2.new(1,0,0.9490000009536743,0)
Toggle.AnchorPoint = Vector2.new(0,0)
Toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
Toggle.BackgroundTransparency = 1
Toggle.BorderSizePixel = 0
Toggle.ClipsDescendants = false
Toggle.Visible = true
Toggle.ZIndex = 1
Toggle.AutomaticSize = Enum.AutomaticSize.None
Toggle.LayoutOrder = #section:GetChildren()
Toggle.Parent = section

ToggleClick.Name = "ToggleClick"
ToggleClick.Position = UDim2.new(0,0,0,0)
ToggleClick.Size = UDim2.new(1,0,1,0)
ToggleClick.AnchorPoint = Vector2.new(0,0)
ToggleClick.BackgroundColor3 = Color3.fromRGB(255,255,255)
ToggleClick.BackgroundTransparency = 1
ToggleClick.BorderSizePixel = 1
ToggleClick.Text = ""
ToggleClick.TextColor3 = Color3.fromRGB(27,42,53)
ToggleClick.TextScaled = false
ToggleClick.TextSize = 8
ToggleClick.Font = Enum.Font.Legacy
ToggleClick.TextTransparency = 0
ToggleClick.Visible = true
ToggleClick.ZIndex = 4
ToggleClick.AutomaticSize = Enum.AutomaticSize.None
ToggleClick.TextXAlignment = Enum.TextXAlignment.Center
ToggleClick.TextYAlignment = Enum.TextYAlignment.Center
ToggleClick.LayoutOrder = 0
ToggleClick.Parent = Toggle

Text_4 = Instance.new('TextLabel')
Text_4.Name = "Text"
Text_4.Position = UDim2.new(0.11900000274181366,0,-0.10000000149011612,0)
Text_4.Size = UDim2.new(0.699999988079071,0,1,0)
Text_4.AnchorPoint = Vector2.new(0,0)
Text_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
Text_4.BackgroundTransparency = 1
Text_4.BorderSizePixel = 1
Text_4.Text = ToggleName or "Toggle"
Text_4.TextColor3 = Color3.fromRGB(127,127,127)
Text_4.TextScaled = true
Text_4.TextSize = 8
Text_4.Font = Enum.Font.SourceSansSemibold
Text_4.TextTransparency = 0
Text_4.Visible = true
Text_4.ZIndex = 1
Text_4.AutomaticSize = Enum.AutomaticSize.None
Text_4.TextXAlignment = Enum.TextXAlignment.Left
Text_4.TextYAlignment = Enum.TextYAlignment.Center
Text_4.LayoutOrder = 0
Text_4.Parent = Toggle

CheckBox = Instance.new('Frame')
CheckBox.Name = "CheckBox"
CheckBox.Position = UDim2.new(0,0,0,0)
CheckBox.Size = UDim2.new(0.08079999685287476,0,0.8980000019073486,0)
CheckBox.AnchorPoint = Vector2.new(0,0)
CheckBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
CheckBox.BackgroundTransparency = 0
CheckBox.BorderSizePixel = 1
CheckBox.ClipsDescendants = false
CheckBox.Visible = true
CheckBox.ZIndex = 1
CheckBox.AutomaticSize = Enum.AutomaticSize.None
CheckBox.LayoutOrder = 0
CheckBox.Parent = Toggle

UICorner_3 = Instance.new('UICorner')
UICorner_3.Name = "UICorner"
UICorner_3.CornerRadius = UDim.new(0,3)
UICorner_3.Parent = CheckBox

UIStroke_4 = Instance.new('UIStroke')
UIStroke_4.Name = "UIStroke"
UIStroke_4.Color = Color3.fromRGB(44,44,44)
UIStroke_4.Transparency = 0
UIStroke_4.Thickness = 1
UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_4.Parent = CheckBox

UIAspectRatioConstraint_4 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_4.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_4.AspectRatio = 12
UIAspectRatioConstraint_4.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_4.Parent = Toggle

UIGradient_8.Name = "UIGradient"
UIGradient_8.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
})
UIGradient_8.Rotation = 90
UIGradient_8.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_8.Offset = Vector2.new(0,0)
UIGradient_8.Parent = CheckBox

ToggleClick.MouseButton1Click:Connect(function()  
toggled = not toggled  
if toggled then  
    UIGradient_8.Color = ColorSequence.new({  
        ColorSequenceKeypoint.new(0, Color3.fromRGB(202,151,202)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(136,101,136))  
    })  
else  
    UIGradient_8.Color = ColorSequence.new({  
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,30)),  
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))  
    })  
end  
if ToggleCallback then  
    ToggleCallback(toggled)  
end

end)

return ToggleFu
end

function Section:AddSlider(SliderName, Min, Max, Default, SliderCallback)
Min = Min or 1
Max = Max or 100
Default = Default or Min

local slider = {}
local Section = self

local Slider = Instance.new('Frame')
local Text_5 = Instance.new('TextLabel')
ValueText_2 = Instance.new('TextLabel')
Fill = Instance.new('Frame')
Trigger = Instance.new('TextButton')
local Move = Instance.new("Frame")
local OutputValue = Instance.new("NumberValue")

Slider.Name = "Slider"
Slider.Position = UDim2.new(0,0,0,0)
Slider.Size = UDim2.new(1,0,0.9800000190734863,0)
Slider.AnchorPoint = Vector2.new(0,0)
Slider.BackgroundColor3 = Color3.fromRGB(255,255,255)
Slider.BackgroundTransparency = 1
Slider.BorderSizePixel = 0
Slider.ClipsDescendants = false
Slider.Visible = true
Slider.ZIndex = 1
Slider.AutomaticSize = Enum.AutomaticSize.None
Slider.LayoutOrder = #section:GetChildren()
Slider.Parent = section

Text_5.Name = "Text"
Text_5.Position = UDim2.new(0.009999999776482582,0,-0.10100000351667404,0)
Text_5.Size = UDim2.new(0.8190000057220459,0,0.6000000238418579,0)
Text_5.AnchorPoint = Vector2.new(0,0)
Text_5.BackgroundColor3 = Color3.fromRGB(255,255,255)
Text_5.BackgroundTransparency = 1
Text_5.BorderSizePixel = 1
Text_5.Text = SliderName or "Slider"
Text_5.TextColor3 = Color3.fromRGB(255,255,255)
Text_5.TextScaled = true
Text_5.TextSize = 8
Text_5.Font = Enum.Font.SourceSansSemibold
Text_5.TextTransparency = 0
Text_5.Visible = true
Text_5.ZIndex = 1
Text_5.AutomaticSize = Enum.AutomaticSize.None
Text_5.TextXAlignment = Enum.TextXAlignment.Left
Text_5.TextYAlignment = Enum.TextYAlignment.Center
Text_5.LayoutOrder = 0
Text_5.Parent = Slider

UIAspectRatioConstraint_5 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_5.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_5.AspectRatio = 9
UIAspectRatioConstraint_5.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_5.Parent = Slider

ValueText_2.Name = "ValueText"
ValueText_2.Position = UDim2.new(0.8690000176429749,0,-0.10199999809265137,0)
ValueText_2.Size = UDim2.new(0.08799999952316284,0,0.6000000238418579,0)
ValueText_2.AnchorPoint = Vector2.new(0,0)
ValueText_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
ValueText_2.BackgroundTransparency = 1
ValueText_2.BorderSizePixel = 1
ValueText_2.Text = Default
ValueText_2.TextColor3 = Color3.fromRGB(255,255,255)
ValueText_2.TextScaled = true
ValueText_2.TextSize = 8
ValueText_2.Font = Enum.Font.SourceSansSemibold
ValueText_2.TextTransparency = 0
ValueText_2.Visible = true
ValueText_2.ZIndex = 1
ValueText_2.AutomaticSize = Enum.AutomaticSize.None
ValueText_2.TextXAlignment = Enum.TextXAlignment.Left
ValueText_2.TextYAlignment = Enum.TextYAlignment.Center
ValueText_2.LayoutOrder = 0
ValueText_2.Parent = Slider

Fill.Name = "Fill"
Fill.Position = UDim2.new(0,0,0.6990000009536743,0)
Fill.Size = UDim2.new(1,0,0.25,0)
Fill.AnchorPoint = Vector2.new(0,0)
Fill.BackgroundColor3 = Color3.fromRGB(255,191,255)
Fill.BackgroundTransparency = 0
Fill.BorderSizePixel = 0
Fill.ClipsDescendants = false
Fill.Visible = true
Fill.ZIndex = 1
Fill.AutomaticSize = Enum.AutomaticSize.None
Fill.LayoutOrder = 0
Fill.Parent = Slider
UICorner_4 = Instance.new('UICorner')
UICorner_4.Name = "UICorner"
UICorner_4.CornerRadius = UDim.new(0,5)
UICorner_4.Parent = Fill

Move.Name = "Move"
Move.Position = UDim2.new(0,0,0.6990000009536743,0)
Move.Size = UDim2.new(1,0,1,0)
Move.AnchorPoint = Vector2.new(0,0)
Move.BackgroundColor3 = Color3.fromRGB(255,191,255)
Move.BackgroundTransparency = 0
Move.BorderSizePixel = 0
Move.ClipsDescendants = false
Move.Visible = true
Move.ZIndex = 1
Move.AutomaticSize = Enum.AutomaticSize.None
Move.LayoutOrder = 0
Move.Parent = Fill

Trigger.Name = "Trigger"
Trigger.Position = UDim2.new(0,0,0,0)
Trigger.Size = UDim2.new(1,0,1,0)
Trigger.AnchorPoint = Vector2.new(0,0)
Trigger.BackgroundColor3 = Color3.fromRGB(255,191,255)
Trigger.BackgroundTransparency = 1
Trigger.BorderSizePixel = 0
Trigger.Text = ""
Trigger.TextColor3 = Color3.fromRGB(27,42,53)
Trigger.TextScaled = false
Trigger.TextSize = 8
Trigger.Font = Enum.Font.Legacy
Trigger.TextTransparency = 0
Trigger.Visible = true
Trigger.ZIndex = 1
Trigger.AutomaticSize = Enum.AutomaticSize.None
Trigger.TextXAlignment = Enum.TextXAlignment.Center
Trigger.TextYAlignment = Enum.TextYAlignment.Center
Trigger.LayoutOrder = 0
Trigger.Parent = Fill

UIGradient_9 = Instance.new('UIGradient')
UIGradient_9.Name = "UIGradient"
UIGradient_9.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 44, 44)),ColorSequenceKeypoint.new(1, Color3.fromRGB(31,31,31))})
UIGradient_9.Rotation = 0
UIGradient_9.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_9.Offset = Vector2.new(0,0)
UIGradient_9.Parent = Fill

local Mouse = game.Players.LocalPlayer:GetMouse()

-- Set initial value
local normalizedDefault = (Default - Min) / (Max - Min)
OutputValue.Value = normalizedDefault
Move.Size = UDim2.fromScale(normalizedDefault, 1)
ValueText_2.Text = tostring(Default)

-- Tween setup
local TweenService = game:GetService("TweenService")
local TweenStyle = TweenInfo.new(0.25, Enum.EasingStyle.Exponential)

function UpdateSlider()
local output = math.clamp((Mouse.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
local value = math.round(output * (Max - Min) + Min) -- scale to Min/Max range
ValueText_2.Text = tostring(value)

if OutputValue.Value ~= output then    
    TweenService:Create(Move, TweenStyle, {Size = UDim2.fromScale(output, 1)}):Play()    
end    

OutputValue.Value = output  

-- Call the callback with the actual scaled value  
if SliderCallback then  
    SliderCallback(value)  
end

end

local sliderActive = false

function ActivateSlider()
sliderActive = true
while sliderActive do
UpdateSlider()
task.wait()
end
end

Trigger.MouseButton1Down:Connect(ActivateSlider)

game:GetService("UserInputService").InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
sliderActive = false
end
end)

return slider
end

function Section:AddDropdown(Name, MultiSelect, dropdownOption, Default, Callback)
local Dropdown = {}
Dropdown.Options = {}
Dropdown.Selected = Default or ""

-- Main Dropdown Frame  
local DropdownFrame = Instance.new('Frame')  
DropdownFrame.Name = "Dropdown"  
DropdownFrame.Position = UDim2.new(0,0,0,0)  
DropdownFrame.Size = UDim2.new(1,0,0.18,0) -- smaller initial height  
DropdownFrame.BackgroundTransparency = 1  
DropdownFrame.BorderSizePixel = 0  
DropdownFrame.LayoutOrder = #section:GetChildren()  
DropdownFrame.Parent = section

local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint.AspectRatio = 1
UIAspectRatioConstraint.Parent = DropdownFrame

-- Text Label  
local Text_3 = Instance.new('TextLabel')  
Text_3.Name = "Text"  
Text_3.Position = UDim2.new(0.009,0,-0.102,0)  
Text_3.Size = UDim2.new(0.8,0,0.4,0)  
Text_3.BackgroundTransparency = 1  
Text_3.Text = Name or "Dropdown"  
Text_3.TextColor3 = Color3.fromRGB(255,255,255)  
Text_3.TextScaled = true  
Text_3.Font = Enum.Font.SourceSansSemibold  
Text_3.TextYAlignment = Enum.TextYAlignment.Center  
Text_3.Parent = DropdownFrame  

-- TopBar Button  
local TopBar = Instance.new('Frame')  
TopBar.Name = "TopBar"  
TopBar.Position = UDim2.new(0.1,0,0.289,0)  
TopBar.Size = UDim2.new(0.8,0,0.6,0)  
TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  
TopBar.BorderSizePixel = 0  
TopBar.Parent = DropdownFrame  

local UIGradient_8 = Instance.new('UIGradient')  
UIGradient_8.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(26,26,26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22,22,22))})  
UIGradient_8.Rotation = 90  
UIGradient_8.Parent = TopBar  

local UIStroke_4 = Instance.new('UIStroke')  
UIStroke_4.Color = Color3.fromRGB(40,40,40)  
UIStroke_4.Parent = TopBar  

-- Value Text  
local ValueText = Instance.new('TextLabel')  
ValueText.Name = "ValueText"  
ValueText.Position = UDim2.new(0,0,0,0)  
ValueText.Size = UDim2.new(0.82,0,0.699,0)  
ValueText.BackgroundTransparency = 1  
ValueText.Text = Default or "ValueText"  
ValueText.TextColor3 = Color3.fromRGB(255,255,255)  
ValueText.TextScaled = true  
ValueText.Font = Enum.Font.SourceSansSemibold  
ValueText.TextXAlignment = Enum.TextXAlignment.Center  
ValueText.TextYAlignment = Enum.TextYAlignment.Center  
ValueText.Active = false  
ValueText.Parent = TopBar  

-- Arrow Text  
local Tex_2 = Instance.new('TextLabel')  
Tex_2.Name = "Tex"  
Tex_2.Position = UDim2.new(0.869,0,0,0)  
Tex_2.Size = UDim2.new(0.09,0,0.699,0)  
Tex_2.BackgroundTransparency = 1  
Tex_2.Text = ">"  
Tex_2.TextColor3 = Color3.fromRGB(255,255,255)  
Tex_2.TextScaled = true  
Tex_2.Font = Enum.Font.SourceSansSemibold  
Tex_2.TextXAlignment = Enum.TextXAlignment.Center  
Tex_2.TextYAlignment = Enum.TextYAlignment.Center  
Tex_2.Active = false  
Tex_2.Parent = TopBar  

-- DownBar  
local DownBar = Instance.new('Frame')  
DownBar.Name = "DownBar"  
DownBar.Position = UDim2.new(0,0,1,0)  
DownBar.Size = UDim2.new(1,0,0,0) -- start collapsed  
DownBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  
DownBar.Visible = false  
DownBar.ZIndex = 4  
DownBar.Parent = DropdownFrame  

local UIStroke_3 = Instance.new('UIStroke')  
UIStroke_3.Color = Color3.fromRGB(37,37,37)  
UIStroke_3.Parent = DownBar  

local UIGradient_7 = Instance.new('UIGradient')  
UIGradient_7.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(26,26,26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22,22,22))})  
UIGradient_7.Rotation = 90  
UIGradient_7.Parent = DownBar  

-- Scrolling Frame for Options  
local Scrolling = Instance.new('ScrollingFrame')  
Scrolling.Name = "Scrolling"  
Scrolling.Size = UDim2.new(1,0,1,0)  
Scrolling.BackgroundTransparency = 1  
Scrolling.BorderSizePixel = 0  
Scrolling.ScrollBarThickness = 1  
Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y  
Scrolling.Parent = DownBar  

local UIListLayout_6 = Instance.new('UIListLayout')  
UIListLayout_6.Padding = UDim.new(0,3)  
UIListLayout_6.Parent = Scrolling  

-- Click Trigger  
local Trigger = Instance.new('TextButton')  
Trigger.Name = "Trigger"  
Trigger.Size = UDim2.new(1,0,1,0)  
Trigger.BackgroundTransparency = 1  
Trigger.Text = ""  
Trigger.Parent = TopBar  
Trigger.ZIndex = 9  

Trigger.MouseButton1Click:Connect(function()  
    DownBar.Visible = not DownBar.Visible  
    if DownBar.Visible then  
        -- Expand DownBar to fit options  
        local numOptions = #dropdownOption  
        local optionHeight = 30  
        DownBar.Size = UDim2.new(1,0,0, math.min(numOptions * (optionHeight + 3), 200))  
    else  
        DownBar.Size = UDim2.new(1,0,0,0)  
    end  
end)  

-- Create options  
local Options = dropdownOption or {"Option"}  
for _, OptionName in ipairs(Options) do  
    local Option = Instance.new('TextButton')  
    Option.Name = "Option"  
    Option.Size = UDim2.new(1,0,0,30)  
    Option.BackgroundTransparency = 1  
    Option.Text = OptionName  
    Option.TextColor3 = Color3.fromRGB(255,255,255)  
    Option.TextScaled = true  
    Option.Font = Enum.Font.SourceSansSemibold  
    Option.ZIndex = 8  
    Option.Parent = Scrolling  

    Dropdown.Options[OptionName] = false  

    Option.MouseButton1Click:Connect(function()  
        if MultiSelect then  
            Dropdown.Options[OptionName] = not Dropdown.Options[OptionName]  
            Option.BackgroundTransparency = Dropdown.Options[OptionName] and 0 or 1  
            if Callback then  
                Callback(Dropdown.Options)  
            end  
        else  
            ValueText.Text = OptionName  
            Dropdown.Selected = OptionName  
            DownBar.Visible = false  
            if Callback then  
                Callback(Dropdown.Selected)  
            end  
        end  
    end)  
end  

-- Store references  
Dropdown.TopBar = TopBar  
Dropdown.DownBar = DownBar  
Dropdown.ValueText = ValueText  
Dropdown.Frame = DropdownFrame  

return Dropdown

end

function Section:AddListBox(values, Callback)
local Section = self

local ListBox = Instance.new('Frame')  
ListBox.Name = "ListBox"  
ListBox.Position = UDim2.new(0,0,0,0)  
ListBox.Size = UDim2.new(1,0,0.7,0)  
ListBox.AnchorPoint = Vector2.new(0,0)  
ListBox.BackgroundColor3 = Color3.fromRGB(162,162,162)  
ListBox.BackgroundTransparency = 1  
ListBox.LayoutOrder = #section:GetChildren()  
ListBox.Parent = section

local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint.AspectRatio = 1
UIAspectRatioConstraint.Parent = ListBox

local Scrolling = Instance.new('ScrollingFrame')  
Scrolling.Name = "Scrolling"  
Scrolling.Position = UDim2.new(0.1289999932050705,0,0,0)  
Scrolling.Size = UDim2.new(1,0,1.1,0)  
Scrolling.BackgroundColor3 = Color3.fromRGB(255,255,255)  
Scrolling.BorderSizePixel = 0  
Scrolling.CanvasSize = UDim2.new(0,0,2,0)  
Scrolling.ScrollBarThickness = 1  
Scrolling.Parent = ListBox  

local UIListLayout_4 = Instance.new('UIListLayout')  
UIListLayout_4.FillDirection = Enum.FillDirection.Vertical  
UIListLayout_4.Padding = UDim.new(0,3)  
UIListLayout_4.Parent = Scrolling  

local UICorner = Instance.new('UICorner')  
UICorner.CornerRadius = UDim.new(0,4)  
UICorner.Parent = Scrolling  

local UIGradient_5 = Instance.new('UIGradient')  
UIGradient_5.Color = ColorSequence.new({  
    ColorSequenceKeypoint.new(0, Color3.fromRGB(21,21,21)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))  
})  
UIGradient_5.Rotation = 90  
UIGradient_5.Parent = Scrolling  

local UIStroke_2 = Instance.new('UIStroke')  
UIStroke_2.Color = Color3.fromRGB(44,44,44)  
UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border  
UIStroke_2.Parent = Scrolling  

-- TEMPLATE BUTTON (we will clone this)  
local ListButton = Instance.new('TextButton')  
ListButton.Name = "ListButton"  
ListButton.Size = UDim2.new(1,0,0.05,0)  
ListButton.BackgroundColor3 = Color3.fromRGB(55,55,55)  
ListButton.BackgroundTransparency = 0.9  
ListButton.TextColor3 = Color3.fromRGB(127,127,127)  
ListButton.TextScaled = true  
ListButton.Font = Enum.Font.Code  
ListButton.Parent = nil  -- not parent yet, only clone later  

local UICorner_2 = Instance.new('UICorner')  
UICorner_2.CornerRadius = UDim.new(0,4)  
UICorner_2.Parent = ListButton  

-- Create each button from values  
for _,v in ipairs(values) do  
    local Btn = ListButton:Clone()  
    Btn.Text = tostring(v)  
    Btn.Parent = Scrolling  

    Btn.MouseButton1Click:Connect(function()  
        pcall(function()  
            Callback(v)  
        end)  
    end)  
end  

  

return ListBox

end

return Section

end

end

return UIBankroll
