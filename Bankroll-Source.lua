--// Bankroll Mafia UI Library
--// designed based on your reference image

local Bankroll = {}
Bankroll.Accent = Color3.fromRGB(190, 120, 255)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

--==========================================================
-- Window Constructor
--==========================================================
function Bankroll:CreateWindow(title)
    local UI = {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = pgui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 620, 0, 420)
    Main.Position = UDim2.new(0.5, -310, 0.5, -210)
    Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Parent = ScreenGui

    local Topbar = Instance.new("TextLabel")
    Topbar.Text = title
    Topbar.Size = UDim2.new(1,0,0,32)
    Topbar.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Topbar.BorderSizePixel = 0
    Topbar.TextColor3 = Color3.fromRGB(200,200,200)
    Topbar.Font = Enum.Font.GothamBold
    Topbar.TextSize = 14
    Topbar.Parent = Main

    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(1,0,0,2)
    Divider.Position = UDim2.new(0,0,0,32)
    Divider.BackgroundColor3 = Bankroll.Accent
    Divider.BorderSizePixel = 0
    Divider.Parent = Main

    -- container
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -20, 1, -80)
    Content.Position = UDim2.new(0,10,0,40)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    UI._content = Content
    UI._tabs = {}

    --==========================================================
    -- Bottom Tabs
    --==========================================================
    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1,0,0,35)
    TabBar.Position = UDim2.new(0,0,1,-35)
    TabBar.BackgroundColor3 = Color3.fromRGB(15,15,15)
    TabBar.BorderSizePixel = 0
    TabBar.Parent = Main

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0,6)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TabLayout.Parent = TabBar

    function UI:CreateTab(name)
        local Tab = {}
        
        local Btn = Instance.new("TextButton")
        Btn.Text = name
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 13
        Btn.TextColor3 = Color3.fromRGB(180,180,180)
        Btn.AutoButtonColor = false
        Btn.Size = UDim2.new(0,80,1,-10)
        Btn.BackgroundTransparency = 1
        Btn.Parent = TabBar

        local Page = Instance.new("Frame")
        Page.Visible = false
        Page.Size = UDim2.new(1,0,1,0)
        Page.BackgroundTransparency = 1
        Page.Parent = Content

        Tab.Page = Page

        Btn.MouseButton1Click:Connect(function()
            for _,t in pairs(UI._tabs) do
                t.Page.Visible = false
            end
            Page.Visible = true
        end)

        table.insert(UI._tabs, Tab)
        if #UI._tabs == 1 then Page.Visible = true end

        function Tab:AddSection(title)
            local S = {}

            local Box = Instance.new("Frame")
            Box.Size = UDim2.new(0.48,0,0,180)
            Box.BackgroundColor3 = Color3.fromRGB(15,15,15)
            Box.BorderSizePixel = 0
            Box.Parent = Page

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -10, 0, 22)
            Title.Position = UDim2.new(0,5,0,5)
            Title.BackgroundTransparency = 1
            Title.Text = title
            Title.Font = Enum.Font.GothamBold
            Title.TextColor3 = Color3.fromRGB(200,200,200)
            Title.TextSize = 13
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = Box

            local Layout = Instance.new("UIListLayout")
            Layout.Padding = UDim.new(0,6)
            Layout.Parent = Box

            S.Parent = Box

            ---------------------------------------------------
            -- TOGGLE (Right-side small switch like the image)
            ---------------------------------------------------
            function S:AddToggle(name, default, callback)
                local T = Instance.new("Frame")
                T.Size = UDim2.new(1,-10,0,22)
                T.BackgroundTransparency = 1
                T.Parent = Box

                local Label = Instance.new("TextLabel")
                Label.BackgroundTransparency = 1
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Text = name
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 12
                Label.TextColor3 = Color3.fromRGB(200,200,200)
                Label.Size = UDim2.new(1,-40,1,0)
                Label.Parent = T

                local Switch = Instance.new("Frame")
                Switch.Size = UDim2.new(0,28,0,12)
                Switch.Position = UDim2.new(1,-32,0.5,-6)
                Switch.BackgroundColor3 = Color3.fromRGB(50,50,50)
                Switch.BorderSizePixel = 0
                Switch.Parent = T

                local Dot = Instance.new("Frame")
                Dot.Size = UDim2.new(0,12,0,12)
                Dot.Position = default and UDim2.new(1,-12,0,0) or UDim2.new(0,0,0,0)
                Dot.BackgroundColor3 = default and Bankroll.Accent or Color3.fromRGB(120,120,120)
                Dot.BorderSizePixel = 0
                Dot.Parent = Switch

                local state = default

                local function update()
                    TweenService:Create(Dot, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = state and UDim2.new(1,-12,0,0) or UDim2.new(0,0,0,0),
                        BackgroundColor3 = state and Bankroll.Accent or Color3.fromRGB(120,120,120)
                    }):Play()
                    if callback then callback(state) end
                end

                T.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        state = not state
                        update()
                    end
                end)

                update()
            end

            ---------------------------------------------------
            -- DROPDOWN (dark, black, arrow, like image)
            ---------------------------------------------------
            function S:AddDropdown(name, options, callback)
                local D = Instance.new("Frame")
                D.Size = UDim2.new(1,-10,0,26)
                D.BackgroundTransparency = 1
                D.Parent = Box

                local Btn = Instance.new("TextButton")
                Btn.Size = UDim2.new(1,0,1,0)
                Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
                Btn.BorderSizePixel = 0
                Btn.Text = name
                Btn.Font = Enum.Font.Gotham
                Btn.TextSize = 12
                Btn.TextColor3 = Color3.fromRGB(200,200,200)
                Btn.Parent = D

                local List = Instance.new("Frame")
                List.Visible = false
                List.Size = UDim2.new(1,0,0,#options*22)
                List.Position = UDim2.new(0,0,1,2)
                List.BackgroundColor3 = Color3.fromRGB(15,15,15)
                List.BorderSizePixel = 0
                List.Parent = D

                local layout = Instance.new("UIListLayout")
                layout.Parent = List

                for _,opt in ipairs(options) do
                    local O = Instance.new("TextButton")
                    O.Size = UDim2.new(1,0,0,22)
                    O.BackgroundTransparency = 1
                    O.Text = opt
                    O.TextColor3 = Color3.fromRGB(200,200,200)
                    O.Font = Enum.Font.Gotham
                    O.TextSize = 12
                    O.Parent = List

                    O.MouseButton1Click:Connect(function()
                        Btn.Text = opt
                        List.Visible = false
                        if callback then callback(opt) end
                    end)
                end

                Btn.MouseButton1Click:Connect(function()
                    List.Visible = not List.Visible
                end)
            end

            return S
        end

        return Tab
    end

    return UI
end

return Bankroll
