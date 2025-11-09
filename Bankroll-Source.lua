--// Bankroll Mafia Style UI Library
--// by ChatGPT (GPT-5)

local Bankroll = {}
Bankroll.__index = Bankroll

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// Utility
local function Create(instance, props)
    local obj = Instance.new(instance)
    for i,v in pairs(props) do
        obj[i] = v
    end
    return obj
end

-----------------------------------------------------------
--  MAIN WINDOW
-----------------------------------------------------------
function Bankroll:CreateWindow(name)
    local ScreenGui = Create("ScreenGui", {
        Parent = PlayerGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Name = name or "BankrollMafiaUI"
    })

    local Main = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 640, 0, 420),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0
    })

    -- TOP TITLE BAR
    local Title = Create("TextLabel", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Text = name or "bankroll mafia",
        TextColor3 = Color3.fromRGB(230, 180, 255),
        TextSize = 18,
        Font = Enum.Font.GothamBold
    })

    -- GRADIENT EFFECT
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    Gradient.Rotation = 90
    Gradient.Parent = Main

    -----------------------------------------------------------
    -- PANELS (left + right)
    -----------------------------------------------------------
    local LeftPanel = Create("Frame", {
        Parent = Main,
        Position = UDim2.new(0, 10, 0, 35),
        Size = UDim2.new(0.48, -15, 1, -70),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0
    })

    local RightPanel = Create("Frame", {
        Parent = Main,
        Position = UDim2.new(0.52, 5, 0, 35),
        Size = UDim2.new(0.48, -15, 1, -70),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0
    })

    self.Main = Main
    self.LeftPanel = LeftPanel
    self.RightPanel = RightPanel

    -----------------------------------------------------------
    -- FOOTER TABS
    -----------------------------------------------------------
    local Tabs = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 1, -40),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0
    })

    local UIList = Create("UIListLayout", {
        Parent = Tabs,
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 15),
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })

    self.Tabs = Tabs
    return self
end

-----------------------------------------------------------
-- TAB BUTTON
-----------------------------------------------------------
function Bankroll:AddTab(text)
    local Button = Create("TextButton", {
        Parent = self.Tabs,
        Text = text,
        Size = UDim2.new(0, 90, 0, 28),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 160, 255),
        Font = Enum.Font.Gotham,
        TextSize = 16
    })
    return Button
end

-----------------------------------------------------------
-- SECTION HEADER
-----------------------------------------------------------
function Bankroll:AddSection(parentSide, title)
    local Frame = parentSide == "left" and self.LeftPanel or self.RightPanel

    local Section = Create("Frame", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 40)
    })

    local Label = Create("TextLabel", {
        Parent = Section,
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(230, 200, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    return Section
end

-----------------------------------------------------------
-- TOGGLE
-----------------------------------------------------------
function Bankroll:AddToggle(parent, title, callback)
    local Toggle = Create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 24)
    })

    local Box = Create("Frame", {
        Parent = Toggle,
        BackgroundColor3 = Color3.fromRGB(170, 100, 255),
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 0, 0.5, -8),
        BorderSizePixel = 0
    })

    local Label = Create("TextLabel", {
        Parent = Toggle,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 25, 0, 0),
        Size = UDim2.new(1, -25, 1, 0),
        Text = title,
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(220, 200, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })

   local toggled = false
    Toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggled = not toggled
            Box.BackgroundTransparency = toggled and 0 or 0.7
            if callback then callback(toggled) end
        end
    end)

    return Toggle
end

-----------------------------------------------------------
-- DROPDOWN (Simple)
-----------------------------------------------------------
function Bankroll:AddDropdown(parent, title, list, callback)
    local Holder = Create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 28)
    })

    local Button = Create("TextButton", {
        Parent = Holder,
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Text = title,
        TextColor3 = Color3.fromRGB(240, 200, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        Size = UDim2.new(1, 0, 1, 0)
    })

    local ListFrame = Create("Frame", {
        Parent = Holder,
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, 2),
        Size = UDim2.new(1, 0, 0, #list * 20),
        Visible = false
    })

    local Layout = Instance.new("UIListLayout", ListFrame)

    for _, option in ipairs(list) do
        local Option = Create("TextButton", {
            Parent = ListFrame,
            Text = option,
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 200, 255),
            Font = Enum.Font.Gotham,
            TextSize = 14,
            Size = UDim2.new(1, 0, 0, 20)
        })

        Option.MouseButton1Click:Connect(function()
            Button.Text = option
            ListFrame.Visible = false
            if callback then callback(option) end
        end)
    end

    Button.MouseButton1Click:Connect(function()
        ListFrame.Visible = not ListFrame.Visible
    end)

    return Holder
end

return Bankroll
