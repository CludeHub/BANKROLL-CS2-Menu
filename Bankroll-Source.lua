-- BankrollLib ModuleScript v4 (Full: toggles, dropdowns, sliders, colorpicker, UIStroke, animations)
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
Bankroll.Accent = Color3.fromRGB(190,120,255)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local BASE_W, BASE_H = 620, 400 -- +10 height as requested

local function new(class,props)
    local ins = Instance.new(class)
    if props then for k,v in pairs(props) do ins[k]=v end end
    return ins
end

local function applyCorner(parent,px)
    local c = new("UICorner",{CornerRadius=UDim.new(0,px)})
    c.Parent=parent
    return c
end

local function applyGradient(gui,cs)
    for _,v in ipairs(gui:GetChildren()) do if v:IsA("UIGradient") then v:Destroy() end end
    local g = new("UIGradient")
    g.Color = cs or Bankroll.DefaultGradient
    g.Rotation=0
    g.Parent=gui
    return g
end

local function applyStroke(gui,thickness,color)
    local stroke = new("UIStroke",{Parent=gui,Thickness=thickness or 1,Color=color or Color3.fromRGB(90,90,90)})
    return stroke
end

function Bankroll:CreateWindow(title)
    local UI={}
    local sg = new("ScreenGui",{Name="BankrollScreen",IgnoreGuiInset=true,ResetOnSpawn=false})
    sg.Parent = pgui

    -- Main container
    local container=new("Frame",{Name="Container",AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),
        Size=UDim2.new(0,BASE_W,0,BASE_H),BackgroundColor3=Bankroll.Background,BorderSizePixel=0,Active=true})
    container.Parent=sg
    applyCorner(container,4)
    new("UIAspectRatioConstraint",{Parent=container,AspectRatio=BASE_W/BASE_H,DominantAxis=Enum.DominantAxis.Width})
    applyGradient(container,Bankroll.DefaultGradient)

    -- Make draggable
    local dragging=false
    local dragInput,dragStart,startPos
    local function update(input)
        local delta = input.Position - dragStart
        container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    container.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true
            dragStart=input.Position
            startPos=container.Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then
                    dragging=false
                end
            end)
        end
    end)
    container.InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input==dragInput and dragging then update(input) end
    end)

    -- Topbar
    local top=new("Frame",{Size=UDim2.new(1,0,0,36),BackgroundColor3=Bankroll.Panel,BorderSizePixel=0,Parent=container})
    applyCorner(top,4)
    local titleLbl=new("TextLabel",{Parent=top,BackgroundTransparency=1,Size=UDim2.new(1,0,1,0),
        Font=Enum.Font.GothamBold,TextSize=16,Text=title or "bankroll mafia",TextColor3=Bankroll.Text})
    applyGradient(top,Bankroll.DefaultGradient)

    -- Accent
    local accent=new("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,0,36),BackgroundColor3=Bankroll.Accent,BorderSizePixel=0,Parent=container})
    applyGradient(accent,Bankroll.DefaultGradient)

    -- Content frames
    local content=new("Frame",{Size=UDim2.new(1,-20,1,-110),Position=UDim2.new(0,10,0,42),BackgroundTransparency=1,Parent=container})
    local left=new("Frame",{Parent=content,Size=UDim2.new(0.48,0,1,0),BackgroundTransparency=1})
    local right=new("Frame",{Parent=content,Size=UDim2.new(0.48,0,1,0),Position=UDim2.new(0.52,0,0,0),BackgroundTransparency=1})

    local function makeSection(parent,headerText,height)
        height=height or 160
        local panel=new("Frame",{Parent=parent,Size=UDim2.new(1,-12,0,height),Position=UDim2.new(0,6,0,0),BackgroundColor3=Bankroll.Panel,BorderSizePixel=0})
        applyCorner(panel,4)
        applyGradient(panel,Bankroll.DefaultGradient)
        applyStroke(panel,1,Color3.fromRGB(90,90,90))

        local header=new("TextLabel",{Parent=panel,BackgroundTransparency=1,Size=UDim2.new(1,-12,0,24),Position=UDim2.new(0,6,0,6),
            Font=Enum.Font.GothamBold,TextSize=13,Text=headerText or "",TextColor3=Bankroll.Text,TextXAlignment=Enum.TextXAlignment.Left})
        local items=new("Frame",{Parent=panel,BackgroundTransparency=1,Size=UDim2.new(1,-12,1,-40),Position=UDim2.new(0,6,0,36)})
        local layout=new("UIListLayout",{Parent=items,Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder})
        layout.HorizontalAlignment=Enum.HorizontalAlignment.Left

        -- Toggle
        local function AddToggle(name,default,cb)
            default=default or false
            local row=new("Frame",{Parent=items,Size=UDim2.new(1,0,0,24),BackgroundTransparency=1})
            local lbl=new("TextLabel",{Parent=row,BackgroundTransparency=1,Size=UDim2.new(1,-36,1,0),
                Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Text=name,TextColor3=Bankroll.Text})
            local toggle=new("TextButton",{Parent=row,Size=UDim2.new(0,22,0,16),Position=UDim2.new(1,-26,0,4),
                BackgroundColor3=default and Color3.fromRGB(255,255,255) or Bankroll.ToggleOff,BorderSizePixel=0,AutoButtonColor=false,Text=""})
            applyCorner(toggle,0)
            local grad=applyGradient(toggle,Bankroll.DefaultGradient)
            grad.Transparency=NumberSequence.new(default and 0 or 0.6)
            local state=default
            local function set(v)
                state=not (v==false)
                local goal={BackgroundColor3=state and Color3.fromRGB(255,255,255) or Bankroll.ToggleOff}
                TweenService:Create(toggle,TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),goal):Play()
                grad.Transparency=NumberSequence.new(state and 0 or 0.6)
                if cb then pcall(cb,state) end
            end
            toggle.MouseButton1Click:Connect(function() set(not state) end)
            set(state)
            return {Set=set,Get=function() return state end}
        end

        -- Dropdown
        local function AddDropdown(name,options,cb)
            options=options or {"Select"}
            local row=new("Frame",{Parent=items,Size=UDim2.new(1,0,0,28),BackgroundTransparency=1})
            local lbl=new("TextLabel",{Parent=row,BackgroundTransparency=1,Size=UDim2.new(1,-12,1,0),Font=Enum.Font.Gotham,TextSize=13,
                TextXAlignment=Enum.TextXAlignment.Left,Text=name,TextColor3=Bankroll.SubText})
            local box=new("TextButton",{Parent=row,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),
                BackgroundColor3=Color3.fromRGB(20,20,20),BorderSizePixel=0,Text=options[1] or "Select",
                Font=Enum.Font.Gotham,TextSize=13,TextColor3=Bankroll.Text,AutoButtonColor=false})
            applyCorner(box,4)
            applyGradient(box,Bankroll.DefaultGradient)
            local arrow=new("TextLabel",{Parent=box,Text="▼",Size=UDim2.new(0,16,1,0),Position=UDim2.new(1,-16,0,0),
                BackgroundTransparency=1,TextColor3=Bankroll.SubText,Font=Enum.Font.Gotham,TextSize=12})
            local list=new("Frame",{Parent=box,Size=UDim2.new(1,0,0,#options*28),Position=UDim2.new(0,0,1,6),
                BackgroundColor3=Bankroll.Panel,BorderSizePixel=0,Visible=false})
            applyCorner(list,4)
            applyGradient(list,Bankroll.DefaultGradient)
            local layout=new("UIListLayout",{Parent=list,Padding=UDim.new(0,4)})
            layout.HorizontalAlignment=Enum.HorizontalAlignment.Left
            for _,opt in ipairs(options) do
                local item=new("TextButton",{Parent=list,BackgroundTransparency=1,Size=UDim2.new(1,0,0,26),Text=opt,
                    Font=Enum.Font.Gotham,TextColor3=Bankroll.Text,TextSize=13,AutoButtonColor=false})
                item.MouseButton1Click:Connect(function()
                    box.Text=opt
                    list.Visible=false
                    if cb then pcall(cb,opt) end
                end)
            end
            box.MouseButton1Click:Connect(function()
                list.Visible=not list.Visible
            end)
            return {Set=function(v) box.Text=v end,Get=function() return box.Text end}
        end

        -- Slider
        local function AddSlider(name,min,max,default,cb)
            min=min or 0 max=max or 100 default=default or min
            local row=new("Frame",{Parent=items,Size=UDim2.new(1,0,0,28),BackgroundTransparency=1})
            local lbl=new("TextLabel",{Parent=row,BackgroundTransparency=1,Size=UDim2.new(1,-40,1,0),Font=Enum.Font.Gotham,TextSize=13,
                Text=name,TextColor3=Bankroll.Text,TextXAlignment=Enum.TextXAlignment.Left})
            local sliderBG=new("Frame",{Parent=row,Size=UDim2.new(1,0,0,6),Position=UDim2.new(0,0,0.5,-3),BackgroundColor3=Bankroll.Panel,BorderSizePixel=0})
            applyCorner(sliderBG,3)
            local fill=new("Frame",{Parent=sliderBG,Size=UDim2.new((default-min)/(max-min),0,1,0),BackgroundColor3=Bankroll.Accent,BorderSizePixel=0})
            applyCorner(fill,3)
            local dragging=false
            local function updateSlider(x)
                local width=sliderBG.AbsoluteSize.X
                local pos=math.clamp(x/width,0,1)
                fill.Size=UDim2.new(pos,0,1,0)
                local val=min+(pos*(max-min))
                if cb then pcall(cb,val) end
            end
            sliderBG.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1 then
                    dragging=true
                    updateSlider(input.Position.X-sliderBG.AbsolutePosition.X)
                end
            end)
            sliderBG.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position.X-sliderBG.AbsolutePosition.X)
                end
            end)
            return {Set=function(v) fill.Size=UDim2.new((v-min)/(max-min),0,1,0) end,Get=function() return min+(fill.Size.X.Scale*(max-min)) end}
        end

        -- ColorPicker
        local function AddColorPicker(name,default,cb)
            default=default or Color3.fromRGB(255,255,255)
            local row=new("Frame",{Parent=items,Size=UDim2.new(1,0,0,28),BackgroundTransparency=1})
            local lbl=new("TextLabel",{Parent=row,BackgroundTransparency=1,Size=UDim2.new(1,-36,1,0),Font=Enum.Font.Gotham,TextSize=13,
                TextColor3=Bankroll.Text,Text=name,TextXAlignment=Enum.TextXAlignment.Left})
            local box=new("TextButton",{Parent=row,Size=UDim2.new(0,24,0,24),Position=UDim2.new(1,-28,0,2),BackgroundColor3=default,BorderSizePixel=0,AutoButtonColor=false})
            applyCorner(box,4)
            local pickerFrame=new("Frame",{Parent=row,Size=UDim2.new(0,200,0,150),BackgroundColor3=Bankroll.Panel,BorderSizePixel=0,Visible=false,Position=UDim2.new(0,0,1,6)})
            applyCorner(pickerFrame,4)
            applyGradient(pickerFrame,Bankroll.DefaultGradient)
            -- simplified colorpicker: just 3 sliders R,G,B
            local rSlider = nil
            rSlider = (function()
                local s = makeSection(pickerFrame,"R",30)
                return s:AddSlider("R",0,255,default.R*255,function(v) default=Color3.fromRGB(v,default.G*255,default.B*255); box.BackgroundColor3=default if cb then pcall(cb,default) end end)
            end)()
            local gSlider = nil
            gSlider = (function()
                local s = makeSection(pickerFrame,"G",30)
                return s:AddSlider("G",0,255,default.G*255,function(v) default=Color3.fromRGB(default.R*255,v,default.B*255); box.BackgroundColor3=default if cb then pcall(cb,default) end end)
            end)()
            local bSlider = nil
            bSlider = (function()
                local s = makeSection(pickerFrame,"B",30)
                return s:AddSlider("B",0,255,default.B*255,function(v) default=Color3.fromRGB(default.R*255,default.G*255,v); box.BackgroundColor3=default if cb then pcall(cb,default) end end)
            end)()
            box.MouseButton1Click:Connect(function() pickerFrame.Visible=not pickerFrame.Visible end)
            return {Set=function(c) box.BackgroundColor3=c end,Get=function() return default end}
        end

        return {AddToggle=AddToggle,AddDropdown=AddDropdown,AddSlider=AddSlider,AddColorPicker=AddColorPicker}
    end

    -- Left/Right ScrollingFrames
    local leftPanel=new("Frame",{Parent=left,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1})
    local rightPanel=new("Frame",{Parent=right,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1})
    local leftScroll=new("ScrollingFrame",{Parent=leftPanel,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=6,CanvasSize=UDim2.new(0,0,0,0)})
    local rightScroll=new("ScrollingFrame",{Parent=rightPanel,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=6,CanvasSize=UDim2.new(0,0,0,0)})
    new("UIListLayout",{Parent=leftScroll,Padding=UDim.new(0,12),HorizontalAlignment=Enum.HorizontalAlignment.Left})
    new("UIListLayout",{Parent=rightScroll,Padding=UDim.new(0,12),HorizontalAlignment=Enum.HorizontalAlignment.Left})

    -- Bottom tab bar
    local tabBar=new("Frame",{Parent=container,Size=UDim2.new(1,0,0,44),Position=UDim2.new(0,0,1,-44),BackgroundColor3=Bankroll.Panel,BorderSizePixel=0})
    applyCorner(tabBar,4)
    applyGradient(tabBar,Bankroll.DefaultGradient)
    local tabLayout=new("UIListLayout",{Parent=tabBar,HorizontalAlignment=Enum.HorizontalAlignment.Center,Padding=UDim.new(0,12)})
    tabLayout.FillDirection=Enum.FillDirection.Horizontal
    tabLayout.VerticalAlignment=Enum.VerticalAlignment.Center

    UI.Tabs={}
    function UI:CreateTab(name,icon)
        local btn=new("TextButton",{Parent=tabBar,BackgroundTransparency=1,Size=UDim2.new(0,96,0,28),Font=Enum.Font.Gotham,Text=name,TextSize=13,TextColor3=Bankroll.SubText,AutoButtonColor=false})
        if icon then
            local ico=new("ImageLabel",{Parent=btn,Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,0,0.5,-8),BackgroundTransparency=1,Image=icon})
            ico.AnchorPoint = Vector2.new(0,0.5)
        end
        local tab={Name=name,Btn=btn,Left={},Right={}}
        local lpage=new("Frame",{Parent=leftScroll,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false})
        local rpage=new("Frame",{Parent=rightScroll,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false})
        new("UIListLayout",{Parent=lpage,Padding=UDim.new(0,12)})
        new("UIListLayout",{Parent=rpage,Padding=UDim.new(0,12)})

        -- Show first tab by default
        if #UI.Tabs==0 then
            lpage.Visible=true
            rpage.Visible=true
            btn.TextColor3=Bankroll.Text
        end

        btn.MouseButton1Click:Connect(function()
            for _,t in ipairs(UI.Tabs) do
                t._lpage.Visible=false
                t._rpage.Visible=false
                t.Btn.TextColor3=Bankroll.SubText
            end
            lpage.Visible=true
            rpage.Visible=true
            btn.TextColor3=Bankroll.Text
        end)

        tab._lpage=lpage
        tab._rpage=rpage

        function tab:AddLeftSection(header,h)
            local s = makeSection(lpage,header,h)
            return s
        end
        function tab:AddRightSection(header,h)
            local s = makeSection(rpage,header,h)
            return s
        end

        table.insert(UI.Tabs,tab)
        return tab
    end

    function UI:SetGradient(cs)
        if not cs or typeof(cs)~="ColorSequence" then return end
        applyGradient(container,cs)
        applyGradient(top,cs)
        applyGradient(accent,cs)
        applyGradient(tabBar,cs)
        local function applyRecursively(parent)
            for _,v in ipairs(parent:GetChildren()) do
                if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") then
                    local has=false
                    for _,ch in ipairs(v:GetChildren()) do if ch:IsA("UIGradient") then has=true end end
                    if not has and v.BackgroundTransparency<1 then
                        applyGradient(v,cs)
                    else
                        for _,ch in ipairs(v:GetChildren()) do if ch:IsA("UIGradient") then ch.Color=cs end end
                    end
                end
                applyRecursively(v)
            end
        end
        applyRecursively(container)
    end

    UI.ScreenGui=sg
    UI.Container=container
    UI.LeftScroll=leftScroll
    UI.RightScroll=rightScroll
    UI.SetGradient=UI.SetGradient

    return UI
end

return Bankroll
