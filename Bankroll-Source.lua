-- BankrollLib ModuleScript
-- Bankroll Mafia style, gradient everywhere, toggles without dot, UICorner 0 & 4, pixel-focused

local Bankroll = {}
Bankroll.DefaultGradient = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
Bankroll.Background = Color3.fromRGB(12,12,12)
Bankroll.Panel = Color3.fromRGB(18,18,18)
Bankroll.Text = Color3.fromRGB(210,210,210)
Bankroll.SubText = Color3.fromRGB(150,150,150)
Bankroll.ToggleOff = Color3.fromRGB(38,38,38)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- small helper to create Instances
local function new(class, props)
    local ins = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            ins[k] = v
        end
    end
    return ins
end

-- convenience: apply corner (two values used: 0 and 4)
local function applyCorner(parent, px)
    local c = new("UICorner", {CornerRadius = UDim.new(0, px)})
    c.Parent = parent
    return c
end

-- apply gradient to a GUI object (UIGradient)
local function applyGradient(gui, cs)
    -- remove existing
    for _,v in ipairs(gui:GetChildren()) do
        if v:IsA("UIGradient") then v:Destroy() end
    end
    local g = new("UIGradient")
    g.Color = cs or Bankroll.DefaultGradient
    g.Rotation = 0
    g.Parent = gui
    return g
end

-- constants for base sizes (pixel-targeted, scales with aspect constraint)
local BASE_W = 620
local BASE_H = 380

function Bankroll:CreateWindow(title)
    local UI = {}

    -- ScreenGui
    local sg = new("ScreenGui", {Name = "BankrollScreen", IgnoreGuiInset = true, ResetOnSpawn = false})
    sg.Parent = pgui

    -- Container (size uses fixed base values + aspect constraint to preserve pixel ratio)
    local container = new("Frame", {
        Name = "Container",
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0.5,0,0),
        Size = UDim2.new(0, BASE_W, 0, BASE_H),
        BackgroundColor3 = Bankroll.Background,
        BorderSizePixel = 0,
        Active = true,
    })
    container.Parent = sg
    applyCorner(container, 4) -- main corners 4px
    local asp = new("UIAspectRatioConstraint", {AspectRatio = BASE_W/BASE_H, DominantAxis = Enum.DominantAxis.Width})
    asp.Parent = container

    -- Apply global gradient (default white->white). This is the "all color white" starting point.
    applyGradient(container, Bankroll.DefaultGradient)

    -- Topbar
    local top = new("Frame", {Size = UDim2.new(1,0,0,36), BackgroundColor3 = Bankroll.Panel, BorderSizePixel = 0, Parent = container})
    applyCorner(top, 4)
    local titleLbl = new("TextLabel", {
        Parent = top,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Text = title or "bankroll mafia",
        TextColor3 = Bankroll.Text,
    })
    -- subtle inner gradient on topbar so color can be changed via SetGradient
    applyGradient(top, Bankroll.DefaultGradient)

    -- accent divider
    local accent = new("Frame", {Size = UDim2.new(1,0,0,2), Position = UDim2.new(0,0,0,36), BackgroundColor3 = Color3.fromRGB(190,120,255), BorderSizePixel = 0, Parent = container})
    -- accent uses gradient too (initially tinted via Color3 but gradient will override if set)
    applyGradient(accent, Bankroll.DefaultGradient)

    -- content area with padding
    local content = new("Frame", {Size = UDim2.new(1,-20,1,-110), Position = UDim2.new(0,10,0,42), BackgroundTransparency = 1, Parent = container})
    -- columns (left & right)
    local left = new("Frame", {Parent = content, Size = UDim2.new(0.48,0,1,0), Position = UDim2.new(0,0,0,0), BackgroundTransparency = 1})
    local right = new("Frame", {Parent = content, Size = UDim2.new(0.48,0,1,0), Position = UDim2.new(0.52,0,0,0), BackgroundTransparency = 1})

    -- panel creator for sections (rounded 4)
    local function makeSection(parent, headerText, height)
        height = height or 160
        local panel = new("Frame", {Parent = parent, Size = UDim2.new(1,-12,0,height), Position = UDim2.new(0,6,0,0), BackgroundColor3 = Bankroll.Panel, BorderSizePixel = 0})
        applyCorner(panel, 4)
        applyGradient(panel, Bankroll.DefaultGradient)

        -- header label
        local header = new("TextLabel", {
            Parent = panel,
            BackgroundTransparency = 1,
            Size = UDim2.new(1,-12,0,24),
            Position = UDim2.new(0,6,0,6),
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            Text = headerText or "",
            TextColor3 = Bankroll.Text,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        -- items container
        local items = new("Frame", {Parent = panel, BackgroundTransparency = 1, Size = UDim2.new(1,-12,1,-40), Position = UDim2.new(0,6,0,36)})
        local layout = new("UIListLayout", {Parent = items, Padding = UDim.new(0,6), SortOrder = Enum.SortOrder.LayoutOrder})
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

        -- keep parent's CanvasSize updated if parent is a ScrollingFrame
        coroutine.wrap(function()
            task.wait()
            local list = parent:FindFirstChildOfClass("UIListLayout")
            if list and parent:IsA("ScrollingFrame") then
                parent.CanvasSize = UDim2.new(0,0,0, list.AbsoluteContentSize.Y + 16)
            end
        end)()

        return {
            Frame = panel,
            Items = items,
            AddToggle = function(_, name, default, cb)
                default = default or false
                local row = new("Frame", {Parent = items, Size = UDim2.new(1,0,0,24), BackgroundTransparency = 1})
                local lbl = new("TextLabel", {
                    Parent = row,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,-36,1,0),
                    Font = Enum.Font.Gotham,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = name,
                    TextColor3 = Bankroll.Text
                })

                local toggle = new("TextButton", {
                    Parent = row,
                    Size = UDim2.new(0,22,0,16),
                    Position = UDim2.new(1,-26,0,4),
                    BackgroundColor3 = default and Color3.fromRGB(255,255,255) or Bankroll.ToggleOff,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Text = "",
                })
                -- toggle uses UICorner 0 (square) per your "0,4" req
                applyCorner(toggle, 0)
                -- gradient overlay for toggle (will tint when set)
                local togGrad = applyGradient(toggle, Bankroll.DefaultGradient)
                togGrad.Enabled = true

                local state = default
                local function set(v)
                    state = not (v == false)
                    local goal = {BackgroundColor3 = state and Color3.fromRGB(255,255,255) or Bankroll.ToggleOff}
                    TweenService:Create(toggle, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
                    -- tween gradient transparency to make color visible when ON
                    togGrad.Transparency = NumberSequence.new(state and 0 or 0.6)
                    if cb then pcall(cb, state) end
                end
                toggle.MouseButton1Click:Connect(function() set(not state) end)
                set(state)
                return {Set = set, Get = function() return state end}
            end,
            AddDropdown = function(_, name, options, cb)
                options = options or {"Select"}
                local row = new("Frame", {Parent = items, Size = UDim2.new(1,0,0,28), BackgroundTransparency = 1})
                local lbl = new("TextLabel", {
                    Parent = row,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,-12,1,0),
                    Font = Enum.Font.Gotham,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = name,
                    TextColor3 = Bankroll.SubText
                })
                local box = new("TextButton", {
                    Parent = row,
                    Size = UDim2.new(1,0,1,0),
                    Position = UDim2.new(0,0,0,0),
                    BackgroundColor3 = Color3.fromRGB(20,20,20),
                    BorderSizePixel = 0,
                    Text = options[1] or "Select",
                    Font = Enum.Font.Gotham,
                    TextSize = 13,
                    TextColor3 = Bankroll.Text,
                    AutoButtonColor = false
                })
                applyCorner(box, 4)
                applyGradient(box, Bankroll.DefaultGradient)

                local list = new("Frame", {Parent = box, Size = UDim2.new(1,0,0,#options*28), Position = UDim2.new(0,0,1,6), BackgroundColor3 = Bankroll.Panel, BorderSizePixel = 0, Visible = false})
                applyCorner(list, 4)
                applyGradient(list, Bankroll.DefaultGradient)
                local layout = new("UIListLayout", {Parent = list, Padding = UDim.new(0,4)})
                layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

                for _,opt in ipairs(options) do
                    local item = new("TextButton", {Parent = list, BackgroundTransparency = 1, Size = UDim2.new(1,0,0,26), Text = opt, Font = Enum.Font.Gotham, TextColor3 = Bankroll.Text, TextSize = 13, AutoButtonColor = false})
                    item.MouseButton1Click:Connect(function()
                        box.Text = opt
                        list.Visible = false
                        if cb then pcall(cb, opt) end
                    end)
                end
                box.MouseButton1Click:Connect(function() list.Visible = not list.Visible end)

                return {
                    Set = function(v) box.Text = v end,
                    Get = function() return box.Text end
                }
            end
        }
    end

    -- left & right scrollers (panels have rounded 4)
    local leftPanel = new("Frame", {Parent = left, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1})
    local rightPanel = new("Frame", {Parent = right, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1})

    local leftScroll = new("ScrollingFrame", {Parent = leftPanel, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,0)})
    local rightScroll = new("ScrollingFrame", {Parent = rightPanel, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,0)})

    local leftLayout = new("UIListLayout", {Parent = leftScroll, Padding = UDim.new(0,12)})
    leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    local rightLayout = new("UIListLayout", {Parent = rightScroll, Padding = UDim.new(0,12)})
    rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

    -- bottom tab bar (no icons as requested)
    local tabBar = new("Frame", {Parent = container, Size = UDim2.new(1,0,0,44), Position = UDim2.new(0,0,1,-44), BackgroundColor3 = Bankroll.Panel, BorderSizePixel = 0})
    applyCorner(tabBar, 4)
    applyGradient(tabBar, Bankroll.DefaultGradient)
    local tabLayout = new("UIListLayout", {Parent = tabBar, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0,12)})
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    -- store tabs
    UI.Tabs = {}
    -- helper: create a tab (switches left/right scroller visibility)
    function UI:CreateTab(name)
        local btn = new("TextButton", {Parent = tabBar, BackgroundTransparency = 1, Size = UDim2.new(0,96,0,28), Font = Enum.Font.Gotham, Text = name, TextSize = 13, TextColor3 = Bankroll.SubText, AutoButtonColor = false})
        local tab = {Name = name, Btn = btn, Left = {}, Right = {}}
        -- create dedicated pages as Frames inside scrollers
        local lpage = new("Frame", {Parent = leftScroll, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false})
        local rpage = new("Frame", {Parent = rightScroll, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false})
        local llist = new("UIListLayout", {Parent = lpage, Padding = UDim.new(0,12)})
        local rlist = new("UIListLayout", {Parent = rpage, Padding = UDim.new(0,12)})

        -- on first tab, show by default
        if #UI.Tabs == 0 then
            lpage.Visible = true; rpage.Visible = true
            btn.TextColor3 = Bankroll.Text
        end

        btn.MouseButton1Click:Connect(function()
            for _,t in ipairs(UI.Tabs) do
                t._lpage.Visible = false; t._rpage.Visible = false
                t.Btn.TextColor3 = Bankroll.SubText
            end
            lpage.Visible = true; rpage.Visible = true
            btn.TextColor3 = Bankroll.Text
        end)

        tab._lpage = lpage; tab._rpage = rpage

        function tab:AddLeftSection(header, h)
            local s = makeSection(lpage, header, h)
            return s
        end
        function tab:AddRightSection(header, h)
            local s = makeSection(rpage, header, h)
            return s
        end

        table.insert(UI.Tabs, tab)
        return tab
    end

    -- function to set global gradient (applies to many elements: container, panels, topbar, accent, tabbar, existing sections, etc.)
    function UI:SetGradient(colorSequence)
        if not colorSequence or typeof(colorSequence) ~= "ColorSequence" then return end
        -- container
        for _,g in ipairs(container:GetChildren()) do
            if g:IsA("UIGradient") then g:Destroy() end
        end
        applyGradient(container, colorSequence)
        -- top & accent & tabbar
        applyGradient(top, colorSequence)
        applyGradient(accent, colorSequence)
        applyGradient(tabBar, colorSequence)
        -- all existing panels and dropdown lists & toggles inside
        local function applyRecursively(parent)
            for _,v in ipairs(parent:GetChildren()) do
                if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") then
                    -- only certain frames should get gradient: panel-like or buttons
                    -- attach gradient if none exists
                    local has = false
                    for _,ch in ipairs(v:GetChildren()) do if ch:IsA("UIGradient") then has = true end end
                    if not has then
                        -- do not apply to content containers that are transparent
                        if v.BackgroundTransparency < 1 then applyGradient(v, colorSequence) end
                    else
                        for _,ch in ipairs(v:GetChildren()) do if ch:IsA("UIGradient") then ch.Color = colorSequence end end
                    end
                end
                applyRecursively(v)
            end
        end
        applyRecursively(container)
    end

    -- expose references
    UI.ScreenGui = sg
    UI.Container = container
    UI.LeftScroll = leftScroll
    UI.RightScroll = rightScroll
    UI.SetGradient = UI.SetGradient

    return UI
end

return Bankroll
