local Bankroll = {}
Bankroll.__index = Bankroll

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Utility function for gradients
local function applyGradient(inst)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 144, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 205, 255)),
    })
    grad.Parent = inst
end

-- Create main window
function Bankroll:AddWindow(title)
    local Window = {}
    Window.__index = Window

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0.85, 0, 0.6, 0)
    Main.Position = UDim2.new(0.075, 0, 0.2, 0)
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

    -- HEADER
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Header.Parent = Main
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

    local HeaderText = Instance.new("TextLabel")
    HeaderText.Parent = Header
    HeaderText.BackgroundTransparency = 1
    HeaderText.Size = UDim2.new(1, 0, 1, 0)
    HeaderText.Text = title
    HeaderText.Font = Enum.Font.GothamBold
    HeaderText.TextScaled = true
    HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)

    applyGradient(Header)

    -- TAB BAR
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 50)
    TabBar.Position = UDim2.new(0, 0, 1, -50)
    TabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBar.Parent = Main
    Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 12)
    applyGradient(TabBar)

    local TabList = Instance.new("UIListLayout", TabBar)
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.VerticalAlignment = Enum.VerticalAlignment.Center
    TabList.Padding = UDim.new(0, 6)

    -- Pages folder
    local Pages = Instance.new("Folder")
    Pages.Parent = Main

    function Window:AddTab(tabName)
        local Tab = {}
        Tab.__index = Tab

        local Page = Instance.new("Frame")
        Page.Parent = Pages
        Page.Size = UDim2.new(1, 0, 1, -95)
        Page.Position = UDim2.new(0, 0, 0, 45)
        Page.BackgroundTransparency = 1
        Page.Visible = false

        local Left = Instance.new("Frame", Page)
        Left.Size = UDim2.new(0.48, 0, 1, 0)
        Left.Position = UDim2.new(0.02, 0, 0, 0)
        Left.BackgroundTransparency = 1
        local Right = Instance.new("Frame", Page)
        Right.Size = UDim2.new(0.48, 0, 1, 0)
        Right.Position = UDim2.new(0.5, 0, 0, 0)
        Right.BackgroundTransparency = 1

        Instance.new("UIListLayout", Left).Padding = UDim.new(0, 6)
        Instance.new("UIListLayout", Right).Padding = UDim.new(0, 6)

        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabBar
        TabButton.Size = UDim2.new(0.25, 0, 0.7, 0)
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextScaled = true
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 10)
        applyGradient(TabButton)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Pages:GetChildren()) do
                v.Visible = false
            end
            Page.Visible = true
        end)

        if #Pages:GetChildren() == 1 then
            Page.Visible = true
        end

        function Tab:AddSection(sectionName, side)
            local Section = Instance.new("Frame")
            Section.Size = UDim2.new(1, 0, 0, 60)
            Section.BackgroundTransparency = 0.8
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Section).CornerRadius = UDim.new(0, 10)
            applyGradient(Section)

            local Label = Instance.new("TextLabel")
            Label.Parent = Section
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, -10, 1, 0)
            Label.Position = UDim2.new(0, 5, 0, 0)
            Label.Text = sectionName
            Label.Font = Enum.Font.GothamBold
            Label.TextScaled = true
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)

            if side == "left" then
                Section.Parent = Left
            else
                Section.Parent = Right
            end

            return Section
        end

        return Tab
    end

    return Window
end

return Bankroll
