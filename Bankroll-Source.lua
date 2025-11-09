local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Bankroll = {}
Bankroll.Theme = {
	Main = Color3.fromRGB(255,182,193),
	Dark = Color3.fromRGB(20,20,20),
	Section = Color3.fromRGB(30,30,30),
	Text = Color3.fromRGB(255,255,255)
}

local function tween(o,p,t)
	TweenService:Create(o,TweenInfo.new(t or 0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),p):Play()
end

function Bankroll:CreateWindow(title)
	local ui = {}
	local gui = Instance.new("ScreenGui")
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local main = Instance.new("Frame")
	main.Size = UDim2.new(0,540,0,360)
	main.Position = UDim2.new(0.5,-270,0.5,-180)
	main.BackgroundColor3 = Bankroll.Theme.Dark
	main.Active = true
	main.Draggable = true
	main.Parent = gui
	local corner = Instance.new("UICorner",main)
	corner.CornerRadius = UDim.new(0,4)

	local topbar = Instance.new("Frame")
	topbar.Size = UDim2.new(1,0,0,36)
	topbar.BackgroundColor3 = Bankroll.Theme.Section
	topbar.Parent = main
	local topcorner = Instance.new("UICorner",topbar)
	topcorner.CornerRadius = UDim.new(0,4)

	local titletext = Instance.new("TextLabel")
	titletext.Text = title or "Bankroll"
	titletext.Size = UDim2.new(1,0,1,0)
	titletext.BackgroundTransparency = 1
	titletext.TextColor3 = Bankroll.Theme.Main
	titletext.TextScaled = true
	titletext.Font = Enum.Font.GothamBold
	titletext.Parent = topbar

	local tabs = Instance.new("Frame")
	tabs.Size = UDim2.new(1,0,0,36)
	tabs.Position = UDim2.new(0,0,0,36)
	tabs.BackgroundColor3 = Bankroll.Theme.Dark
	tabs.Parent = main
	local tablayout = Instance.new("UIListLayout",tabs)
	tablayout.FillDirection = Enum.FillDirection.Horizontal
	tablayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tablayout.Padding = UDim.new(0,6)

	local fade = Instance.new("Frame")
	fade.BackgroundColor3 = Bankroll.Theme.Dark
	fade.Size = main.Size
	fade.Position = main.Position
	fade.BackgroundTransparency = 0
	fade.Parent = gui
	tween(fade,{BackgroundTransparency=1},0.4)
	task.delay(0.4,function()fade:Destroy()end)

	local container = Instance.new("Frame")
	container.Size = UDim2.new(1,0,1,-72)
	container.Position = UDim2.new(0,0,0,72)
	container.BackgroundTransparency = 1
	container.Parent = main

	local left = Instance.new("Frame")
	left.Size = UDim2.new(0.5,-5,1,0)
	left.Position = UDim2.new(0,0,0,0)
	left.BackgroundTransparency = 1
	left.Parent = container

	local right = Instance.new("Frame")
	right.Size = UDim2.new(0.5,-5,1,0)
	right.Position = UDim2.new(0.5,5,0,0)
	right.BackgroundTransparency = 1
	right.Parent = container

	function ui:CreateTab(tabname)
		local tab = {}
		local button = Instance.new("TextButton")
		button.Text = tabname
		button.Font = Enum.Font.Gotham
		button.TextSize = 16
		button.TextColor3 = Bankroll.Theme.Text
		button.BackgroundColor3 = Bankroll.Theme.Section
		button.Size = UDim2.new(0,120,1,0)
		button.AutoButtonColor = false
		button.Parent = tabs
		local corner = Instance.new("UICorner",button)
		corner.CornerRadius = UDim.new(0,4)
		local page = Instance.new("Frame")
		page.Size = UDim2.new(1,0,1,0)
		page.BackgroundTransparency = 1
		page.Visible = false
		page.Parent = container
		local leftsec = left:Clone()
		leftsec.Visible = true
		leftsec.Parent = page
		local rightsec = right:Clone()
		rightsec.Visible = true
		rightsec.Parent = page
		function tab:Section(side)
			return side == "Right" and rightsec or leftsec
		end
		function tab:Show()
			for _,p in pairs(container:GetChildren())do if p:IsA("Frame")then p.Visible=false end end
			page.Visible = true
		end
		button.MouseButton1Click:Connect(function()
			for _,b in pairs(tabs:GetChildren())do if b:IsA("TextButton")then tween(b,{BackgroundColor3=Bankroll.Theme.Section},0.2)end end
			tween(button,{BackgroundColor3=Bankroll.Theme.Main},0.2)
			tab:Show()
		end)
		return tab
	end

	function ui:Button(parent,text,callback)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1,-10,0,32)
		b.BackgroundColor3 = Bankroll.Theme.Section
		b.TextColor3 = Bankroll.Theme.Text
		b.Text = text
		b.Font = Enum.Font.GothamSemibold
		b.TextScaled = true
		b.AutoButtonColor = false
		b.Parent = parent
		local c = Instance.new("UICorner",b)
		c.CornerRadius = UDim.new(0,4)
		b.MouseButton1Click:Connect(function()
			tween(b,{BackgroundColor3=Bankroll.Theme.Main},0.15)
			task.wait(0.15)
			tween(b,{BackgroundColor3=Bankroll.Theme.Section},0.15)
			if callback then callback()end
		end)
	end

	function ui:Toggle(parent,text,callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1,-10,0,32)
		frame.BackgroundColor3 = Bankroll.Theme.Section
		frame.Parent = parent
		local c = Instance.new("UICorner",frame)
		c.CornerRadius = UDim.new(0,4)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.8,0,1,0)
		label.Position = UDim2.new(0,6,0,0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Bankroll.Theme.Text
		label.Text = text
		label.Font = Enum.Font.GothamSemibold
		label.TextScaled = true
		label.Parent = frame
		local t = Instance.new("Frame")
		t.Size = UDim2.new(0,24,0,24)
		t.Position = UDim2.new(1,-30,0.5,-12)
		t.BackgroundColor3 = Bankroll.Theme.Dark
		t.Parent = frame
		local tc = Instance.new("UICorner",t)
		tc.CornerRadius = UDim.new(0,4)
		local on = false
		t.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
				on = not on
				tween(t,{BackgroundColor3=on and Bankroll.Theme.Main or Bankroll.Theme.Dark},0.15)
				if callback then callback(on)end
			end
		end)
	end

	function ui:Slider(parent,text,min,max,default,callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1,-10,0,38)
		frame.BackgroundColor3 = Bankroll.Theme.Section
		frame.Parent = parent
		local c = Instance.new("UICorner",frame)
		c.CornerRadius = UDim.new(0,4)
		local label = Instance.new("TextLabel")
		label.Text = text.." : "..tostring(default)
		label.Size = UDim2.new(1, -10, 0.5, 0)
		label.Position = UDim2.new(0,5,0,0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Bankroll.Theme.Text
		label.TextScaled = true
		label.Font = Enum.Font.Gotham
		label.Parent = frame
		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1,-10,0,6)
		bar.Position = UDim2.new(0,5,1,-10)
		bar.BackgroundColor3 = Bankroll.Theme.Dark
		bar.Parent = frame
		local fill = Instance.new("Frame")
		fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
		fill.BackgroundColor3 = Bankroll.Theme.Main
		fill.Parent = bar
		local held = false
		bar.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
				held = true
			end
		end)
		bar.InputEnded:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
				held = false
			end
		end)
		UserInputService.InputChanged:Connect(function(i)
			if held and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
				local rel = math.clamp((i.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
				fill.Size = UDim2.new(rel,0,1,0)
				local val = math.floor(min + (max - min)*rel)
				label.Text = text.." : "..val
				if callback then callback(val)end
			end
		end)
	end

	function ui:Dropdown(parent,text,options,callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1,-10,0,32)
		frame.BackgroundColor3 = Bankroll.Theme.Section
		frame.Parent = parent
		local c = Instance.new("UICorner",frame)
		c.CornerRadius = UDim.new(0,4)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -30, 1, 0)
		label.Position = UDim2.new(0,5,0,0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Bankroll.Theme.Text
		label.Text = text
		label.Font = Enum.Font.Gotham
		label.TextScaled = true
		label.Parent = frame
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0,24,0,24)
		btn.Position = UDim2.new(1,-30,0.5,-12)
		btn.BackgroundColor3 = Bankroll.Theme.Dark
		btn.Text = "▼"
		btn.TextColor3 = Bankroll.Theme.Text
		btn.Font = Enum.Font.GothamBold
		btn.TextScaled = true
		btn.Parent = frame
		local list = Instance.new("Frame")
		list.Size = UDim2.new(1,0,0,#options*28)
		list.Position = UDim2.new(0,0,1,4)
		list.BackgroundColor3 = Bankroll.Theme.Section
		list.Visible = false
		list.Parent = frame
		local lc = Instance.new("UICorner",list)
		lc.CornerRadius = UDim.new(0,4)
		local selected = {}
		for _,opt in ipairs(options)do
			local o = Instance.new("TextButton")
			o.Size = UDim2.new(1,0,0,28)
			o.Text = opt
			o.TextColor3 = Bankroll.Theme.Text
			o.Font = Enum.Font.Gotham
			o.BackgroundColor3 = Bankroll.Theme.Dark
			o.Parent = list
			local check = Instance.new("TextLabel")
			check.Text = ""
			check.Size = UDim2.new(0,20,0,20)
			check.Position = UDim2.new(1,-25,0.5,-10)
			check.TextColor3 = Bankroll.Theme.Main
			check.BackgroundTransparency = 0
			check.BackgroundColor3 = Bankroll.Theme.Dark
			check.Parent = o
			local cc = Instance.new("UICorner",check)
			cc.CornerRadius = UDim.new(0,4)
			o.MouseButton1Click:Connect(function()
				if selected[opt] then
					selected[opt] = nil
					check.Text = ""
				else
					selected[opt] = true
					check.Text = "✔"
				end
				local sel = {}
				for k,_ in pairs(selected)do table.insert(sel,k)end
				label.Text = text..": "..table.concat(sel,", ")
				if callback then callback(sel)end
			end)
		end
		btn.MouseButton1Click:Connect(function()
			list.Visible = not list.Visible
			tween(list,{BackgroundTransparency=list.Visible and 0 or 1},0.2)
		end)
	end

	function ui:ColorPicker(parent,text,default,callback)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1,-10,0,36)
		frame.BackgroundColor3 = Bankroll.Theme.Section
		frame.Parent = parent
		local c = Instance.new("UICorner",frame)
		c.CornerRadius = UDim.new(0,4)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.7,0,1,0)
		label.Position = UDim2.new(0,6,0,0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Bankroll.Theme.Text
		label.Text = text
		label.Font = Enum.Font.Gotham
		label.TextScaled = true
		label.Parent = frame
		local box = Instance.new("Frame")
		box.Size = UDim2.new(0,24,0,24)
		box.Position = UDim2.new(1,-30,0.5,-12)
		box.BackgroundColor3 = default or Bankroll.Theme.Main
		box.Parent = frame
		local bc = Instance.new("UICorner",box)
		bc.CornerRadius = UDim.new(0,4)

		local picker = Instance.new("Frame")
		picker.Size = UDim2.new(0,200,0,200)
		picker.Position = UDim2.new(0.5,-100,0.5,-100)
		picker.BackgroundColor3 = Color3.new(1,1,1)
		picker.Visible = false
		picker.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		local pc = Instance.new("UICorner",picker)
		pc.CornerRadius = UDim.new(0,4)

		local valSlider = Instance.new("Frame")
		valSlider.Size = UDim2.new(0,20,1,0)
		valSlider.Position = UDim2.new(1,5,0,0)
		valSlider.BackgroundColor3 = Color3.new(0,0,0)
		valSlider.Parent = picker
		local vs = Instance.new("UICorner",valSlider)
		vs.CornerRadius = UDim.new(0,4)

		local currentColor = default or Bankroll.Theme.Main

		local function updateColor(pos)
			local relX = math.clamp((pos.X-picker.AbsolutePosition.X)/picker.AbsoluteSize.X,0,1)
			local relY = math.clamp((pos.Y-picker.AbsolutePosition.Y)/picker.AbsoluteSize.Y,0,1)
			currentColor = Color3.fromHSV(relX,1-relY,1)
			box.BackgroundColor3 = currentColor
			if callback then callback(currentColor)end
		end

		box.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
				picker.Visible = not picker.Visible
			end
		end)

		picker.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
				updateColor(i.Position)
				local con
				con = UserInputService.InputChanged:Connect(function(inp)
					if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then
						updateColor(inp.Position)
					end
				end)
				UserInputService.InputEnded:Connect(function(inp)
					if inp.UserInputType==Enum.UserInputType.Touch or inp.UserInputType==Enum.UserInputType.MouseButton1 then
						con:Disconnect()
					end
				end)
			end
		end)
	end

	return ui
end

return Bankroll
