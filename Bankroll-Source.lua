local Bankroll = {}


function Bankroll:AddWindow(Title)
local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local Bankroll = Instance.new('ScreenGui')
Bankroll.Name = "Bankroll"
Bankroll.Enabled = true
Bankroll.DisplayOrder = 0
Bankroll.IgnoreGuiInset = false
Bankroll.Parent = PlayerGui

local Frame = Instance.new('Frame')
Frame.Name = "Frame"
Frame.Position = UDim2.new(0,0,0,0)
Frame.Size = UDim2.new(0.5600000023841858,0,0.9390000104904175,0)
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

local UIGradient_11 = Instance.new('UIGradient')
UIGradient_11.Name = "UIGradient"
UIGradient_11.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(15,15,15)),ColorSequenceKeypoint.new(1, Color3.fromRGB(9,9,9))})
UIGradient_11.Rotation = 90
UIGradient_11.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_11.Parent = Frame

local UIAspectRatioConstraint_6 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_6.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_6.AspectRatio = 1.159999966621399
UIAspectRatioConstraint_6.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_6.Parent = Frame
UIScale = Instance.new('UIScale')
UIScale.Name = "UIScale"
UIScale.Scale = 0.8999999761581421
UIScale.Parent = Frame

local Header = Instance.new('Frame')
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

local HeaderLine = Instance.new('Frame')
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

local UIGradient_12 = Instance.new('UIGradient')
UIGradient_12.Name = "UIGradient"
UIGradient_12.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,191,255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(65,48,65))})
UIGradient_12.Rotation = 0
UIGradient_12.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})

UIGradient_12.Parent = HeaderLine
local HeaderLin2 = Instance.new('Frame')
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

local UIGradient_13 = Instance.new('UIGradient')
UIGradient_13.Name = "UIGradient"
UIGradient_13.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(63,47,63)),ColorSequenceKeypoint.new(1, Color3.fromRGB(181,136,181))})
UIGradient_13.Rotation = 0
UIGradient_13.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_13.Parent = HeaderLin2

local Title = Instance.new('TextLabel')
Title.Name = "Title"
Title.Position = UDim2.new(0.30000001192092896,0,0,0)
Title.Size = UDim2.new(0.30000001192092896,0,0.800000011920929,0)
Title.AnchorPoint = Vector2.new(0,0)
Title.BackgroundColor3 = Color3.fromRGB(162,162,162)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 1
Title.Text = "Bankroll Mafia"
Title.TextColor3 = Color3.fromRGB(255,191,255)
Title.TextScaled = true
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

local UIGradient_14 = Instance.new('UIGradient')
UIGradient_14.Name = "UIGradient"
UIGradient_14.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,30))})
UIGradient_14.Rotation = 90
UIGradient_14.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_14.Parent = Header
local UIStroke_7 = Instance.new('UIStroke')
UIStroke_7.Name = "UIStroke"
UIStroke_7.Color = Color3.fromRGB(44,44,44)
UIStroke_7.Transparency = 0
UIStroke_7.Thickness = 1
UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke_7.Parent = Frame

local Bottom = Instance.new('Frame')
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
TabScroll.Position = UDim2.new(0,0,0.10000000149011612,0)
TabScroll.Size = UDim2.new(1,0,0.8989999890327454,0)
TabScroll.AnchorPoint = Vector2.new(0,0)
TabScroll.BackgroundColor3 = Color3.fromRGB(162,162,162)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new(2,0,0,0)
TabScroll.ScrollBarThickness = 0
TabScroll.Visible = true
TabScroll.ZIndex = 1
TabScroll.LayoutOrder = 0
TabScroll.Parent = Bottom
TabScroll.AutomaticSize = Enum.AutomaticSize.X

local UIListLayout = Instance.new('UIListLayout')
UIListLayout.Name = "UIListLayout"
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Padding = UDim.new(0,4)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = TabScroll

local BottomLine = Instance.new('Frame')
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

local UIGradient_2 = Instance.new('UIGradient')
UIGradient_2.Name = "UIGradient"
UIGradient_2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,191,255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(65,48,65))})
UIGradient_2.Rotation = 0
UIGradient_2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_2.Parent = BottomLine
local BottomLin2 = Instance.new('Frame')
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

local UIGradient_3 = Instance.new('UIGradient')
UIGradient_3.Name = "UIGradient"
UIGradient_3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(63,47,63)),ColorSequenceKeypoint.new(1, Color3.fromRGB(181,136,181))})
UIGradient_3.Rotation = 0
UIGradient_3.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_3.Parent = BottomLin2
UIGradient_4 = Instance.new('UIGradient')
UIGradient_4.Name = "UIGradient"
UIGradient_4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(18,18,18)),ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,30))})
UIGradient_4.Rotation = 90
UIGradient_4.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_4.Parent = Bottom
      return Frame
end

function Bankroll:AddTab(tabtext)
local TabButton = Instance.new('Frame')
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
TabButton.LayoutOrder = 0
TabButton.Parent = TabScroll

local Text = Instance.new('TextLabel')
Text.Name = "Text"
Text.Position = UDim2.new(0,0,0,0)
Text.Size = UDim2.new(0.9179999828338623,0,0.7870000004768372,0)
Text.AnchorPoint = Vector2.new(0,0)
Text.BackgroundColor3 = Color3.fromRGB(162,162,162)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 1
Text.Text = tabtext or "Tab"
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

local SwitchClick = Instance.new('TextButton')
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

local UIGradient = Instance.new('UIGradient')
UIGradient.Name = "UIGradient"
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(16,16,16)),ColorSequenceKeypoint.new(1, Color3.fromRGB(28,28,28))})
UIGradient.Rotation = -90
UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})

UIGradient.Parent = TabButton
local UIStroke = Instance.new('UIStroke')
UIStroke.Name = "UIStroke"
UIStroke.Color = Color3.fromRGB(53,53,53)
UIStroke.Transparency = 0
UIStroke.Thickness = 1
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = TabButton

return TabButton
end

function Bankroll:AddSection(section, position)

local Container = Instance.new('Frame')
Container.Name = "Container"
Container.Position = UDim2.new(0.014000000432133675,0,0.06700000166893005,0)
Container.Size = UDim2.new(0.9700000286102295,0,0.8240000009536743,0)
Container.AnchorPoint = Vector2.new(0,0)
Container.BackgroundColor3 = Color3.fromRGB(162,162,162)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 1
Container.ClipsDescendants = false
Container.Visible = true
Container.ZIndex = 1
Container.AutomaticSize = Enum.AutomaticSize.None
Container.LayoutOrder = 0
Container.Parent = Frame

local UIListLayout_2 = Instance.new('UIListLayout')
UIListLayout_2.Name = "UIListLayout"
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_2.Padding = UDim.new(0,8)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Parent = Container

local Right = Instance.new('ScrollingFrame')
Right.Name = "Right"
Right.Position = UDim2.new(0,0,0,0)
Right.Size = UDim2.new(0.48899999260902405,0,1,0)
Right.AnchorPoint = Vector2.new(0,0)
Right.BackgroundColor3 = Color3.fromRGB(162,162,162)
Right.BackgroundTransparency = 1
Right.BorderSizePixel = 0
Right.CanvasSize = UDim2.new(0,0,2,0)
Right.ScrollBarThickness = 0
Right.Visible = true
Right.ZIndex = 1
Right.LayoutOrder = 2
Right.Parent = Container

local UIListLayout_3 = Instance.new('UIListLayout')
UIListLayout_3.Name = "UIListLayout"
UIListLayout_3.FillDirection = Enum.FillDirection.Vertical
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_3.Padding = UDim.new(0,3)
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Parent = Right

local Left = Instance.new('ScrollingFrame')
Left.Name = "Left"
Left.Position = UDim2.new(0,0,0,0)
Left.Size = UDim2.new(0.48899999260902405,0,1,0)
Left.AnchorPoint = Vector2.new(0,0)
Left.BackgroundColor3 = Color3.fromRGB(162,162,162)
Left.BackgroundTransparency = 1
Left.BorderSizePixel = 0
Left.CanvasSize = UDim2.new(0,0,2,0)
Left.ScrollBarThickness = 0
Left.Visible = true
Left.ZIndex = 1
Left.LayoutOrder = 1
Left.Parent = Container

local UIListLayout_4 = Instance.new('UIListLayout')
UIListLayout_4.Name = "UIListLayout"
UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_4.Padding = UDim.new(0,10)
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Parent = Left

local section = Instance.new('Frame')
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
section.Parent = Left

local UICorner_2 = Instance.new('UICorner')
UICorner_2.Name = "UICorner"
UICorner_2.CornerRadius = UDim.new(0,4)
UICorner_2.Parent = section

local SectionTitle = Instance.new('TextLabel')
SectionTitle.Name = "SectionTitle"
SectionTitle.Position = UDim2.new(0,0,0,0)
SectionTitle.Size = UDim2.new(1,0,0.9909999966621399,0)
SectionTitle.AnchorPoint = Vector2.new(0,0)
SectionTitle.BackgroundColor3 = Color3.fromRGB(162,162,162)
SectionTitle.BackgroundTransparency = 1
SectionTitle.BorderSizePixel = 1
SectionTitle.Text = section or "Section"
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

local UIAspectRatioConstraint_2 = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint_2.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint_2.AspectRatio = 14
UIAspectRatioConstraint_2.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint_2.Parent = SectionTitle

local UIListLayout_5 = Instance.new('UIListLayout')
UIListLayout_5.Name = "UIListLayout"
UIListLayout_5.FillDirection = Enum.FillDirection.Vertical
UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout_5.Padding = UDim.new(0,6)
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Parent = section

local UIGradient_6 = Instance.new('UIGradient')
UIGradient_6.Name = "UIGradient"
UIGradient_6.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(25,25,25)),ColorSequenceKeypoint.new(1, Color3.fromRGB(12,12,12))})
UIGradient_6.Rotation = 90
UIGradient_6.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,0,0)})
UIGradient_6.Parent = section

if position == "left" then
    section.Parent = Left
elseif position == "right" then
    section.Parent = Right
end
return section
end

return Bankroll


