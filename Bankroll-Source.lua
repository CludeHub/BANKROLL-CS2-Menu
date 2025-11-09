-- CS2 Full Mobile-Optimized UI Library
local CS2UI = {}
CS2UI.__index = CS2UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Tween helper
local function tween(inst, props, t)
	t = t or 0.25
	TweenService:Create(inst, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Utility function to create scaled size
local function scaled(val)
	return UDim2.new(val,0,val,0)
end

-- Create main window
function CS2UI:CreateWindow(title)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = title.."UI"
	ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ResetOnSpawn = false

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0.9,0,0.8,0)
	MainFrame.Position = UDim2.new(0.05,0,0.1,0)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui

	local aspect = Instance.new("UIAspectRatioConstraint")
	aspect.AspectRatio = 1.3
	aspect.AspectType = Enum.AspectType.ScaleWithParentSize
	aspect.Parent = MainFrame

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(40,40,40)),ColorSequenceKeypoint.new(1,Color3.fromRGB(15,15,15))}
	gradient.Rotation = 45
	gradient.Parent = MainFrame

	local selfWindow = {ScreenGui = ScreenGui, MainFrame = MainFrame, Tabs = {}}
	setmetatable(selfWindow, CS2UI)
	return selfWindow
end

-- Add Tab
function CS2UI:AddTab(name)
	local tabCount = #self.Tabs
	local tabButton = Instance.new("TextButton")
	tabButton.Text = name
	tabButton.Size = UDim2.new(0.2,0,0.06,0)
	tabButton.Position = UDim2.new(0.05 + tabCount*0.21,0,0.02,0)
	tabButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
	tabButton.TextColor3 = Color3.fromRGB(255,255,255)
	tabButton.Parent = self.MainFrame

	local tabFrame = Instance.new("ScrollingFrame")
	tabFrame.Size = UDim2.new(0.9,0,0.85,0)
	tabFrame.Position = UDim2.new(0.05,0,0.1,0)
	tabFrame.BackgroundTransparency = 1
	tabFrame.ScrollBarThickness = 8
	tabFrame.CanvasSize = UDim2.new(0,0,0,0)
	tabFrame.Visible = false
	tabFrame.Parent = self.MainFrame

	self.Tabs[name] = {Button = tabButton, Frame = tabFrame, Elements = {}}

	tabButton.MouseButton1Click:Connect(function()
		for _,v in pairs(self.Tabs) do
			v.Frame.Visible = false
		end
		tabFrame.Visible = true
	end)

	return tabFrame
end

-- Add Button
function CS2UI:AddButton(parent, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,0.07*parent.AbsoluteSize.Y)
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Text = text
	btn.Parent = parent
	btn.MouseEnter:Connect(function() tween(btn,{BackgroundColor3=Color3.fromRGB(70,70,70)}) end)
	btn.MouseLeave:Connect(function() tween(btn,{BackgroundColor3=Color3.fromRGB(50,50,50)}) end)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Add Toggle
function CS2UI:AddToggle(parent, text, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1,0,0,0.07*parent.AbsoluteSize.Y)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.7,0,1,0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.BackgroundTransparency = 1
	label.Parent = frame

	local box = Instance.new("TextButton")
	box.Size = UDim2.new(0.2,0,0.8,0)
	box.Position = UDim2.new(0.75,0,0.1,0)
	box.Text = ""
	box.BackgroundColor3 = default and Color3.fromRGB(0,222,255) or Color3.fromRGB(50,50,50)
	box.Parent = frame

	box.MouseButton1Click:Connect(function()
		default = not default
		box.BackgroundColor3 = default and Color3.fromRGB(0,222,255) or Color3.fromRGB(50,50,50)
		if callback then callback(default) end
	end)

	return frame
end

-- Add Slider
function CS2UI:AddSlider(parent, text, min, max, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1,0,0,0.07*parent.AbsoluteSize.Y)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.4,0,1,0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.BackgroundTransparency = 1
	label.Parent = frame

	local sliderBG = Instance.new("Frame")
	sliderBG.Size = UDim2.new(0.55,0,0.4,0)
	sliderBG.Position = UDim2.new(0.43,0,0.3,0)
	sliderBG.BackgroundColor3 = Color3.fromRGB(50,50,50)
	sliderBG.Parent = frame

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new((default-min)/(max-min),0,1,0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(0,222,255)
	sliderFill.Parent = sliderBG

	local dragging = false
	sliderBG.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end
	end)
	sliderBG.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
	end)
	sliderBG.InputChanged:Connect(function(input)
		if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
			local pos = math.clamp((input.Position.X - sliderBG.AbsolutePosition.X)/sliderBG.AbsoluteSize.X,0,1)
			sliderFill.Size = UDim2.new(pos,0,1,0)
			local value = min + (max-min)*pos
			if callback then callback(value) end
		end
	end)

	return frame
end

-- Add Dropdown
function CS2UI:AddDropdown(parent, text, options, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1,0,0,0.07*parent.AbsoluteSize.Y)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.4,0,1,0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.BackgroundTransparency = 1
	label.Parent = frame

	local dropBtn = Instance.new("TextButton")
	dropBtn.Size = UDim2.new(0.5,0,1,0)
	dropBtn.Position = UDim2.new(0.5,0,0,0)
	dropBtn.Text = "Select"
	dropBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	dropBtn.TextColor3 = Color3.fromRGB(255,255,255)
	dropBtn.Parent = frame

	local dropFrame = Instance.new("ScrollingFrame")
	dropFrame.Size = UDim2.new(0.5,0,0,0)
	dropFrame.Position = UDim2.new(0.5,0,1,0)
	dropFrame.CanvasSize = UDim2.new(0,0,0,0)
	dropFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
	dropFrame.ScrollBarThickness = 6
	dropFrame.Visible = false
	dropFrame.Parent = frame

	dropBtn.MouseButton1Click:Connect(function() dropFrame.Visible = not dropFrame.Visible end)

	local optionY = 0
	for i,opt in pairs(options) do
		local optBtn = Instance.new("TextButton")
		optBtn.Size = UDim2.new(1,0,0,0.07*parent.AbsoluteSize.Y)
		optBtn.Position = UDim2.new(0,0,0,optionY)
		optBtn.Text = opt
		optBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
		optBtn.TextColor3 = Color3.fromRGB(255,255,255)
		optBtn.Parent = dropFrame
		optBtn.MouseButton1Click:Connect(function()
			dropBtn.Text = opt
			dropFrame.Visible = false
			if callback then callback(opt) end
		end)
		optionY = optionY + 0.07*parent.AbsoluteSize.Y
		dropFrame.CanvasSize = UDim2.new(0,0,0,optionY)
	end

	return frame
end

-- Add MultiSelect Dropdown
function CS2UI:AddMultiDropdown(parent, text, options, callback)
	local selected = {}
	local frame = self:AddDropdown(parent, text, options, function(opt)
		if table.find(selected,opt) then
			for i,v in pairs(selected) do
				if v==opt then table.remove(selected,i) break end
			end
		else
			table.insert(selected,opt)
		end
		if callback then callback(selected) end
	end)
	return frame
end

-- Add Toggle+Slider
function CS2UI:AddToggleSlider(parent, text, defaultToggle, min, max, defaultSlider, callback)
	local frame = self:AddToggle(parent,text,defaultToggle,function(t)
		callback(t,nil)
	end)
	local slider = self:AddSlider(parent,text,min,max,defaultSlider,function(s)
		callback(nil,s)
	end)
	return frame, slider
end

-- Add Toggle+Dropdown
function CS2UI:AddToggleDropdown(parent,text,defaultToggle,options,callback)
	local frame = self:AddToggle(parent,text,defaultToggle,function(t)
		callback(t,nil)
	end)
	local drop = self:AddDropdown(parent,text,options,function(d)
		callback(nil,d)
	end)
	return frame, drop
end

-- Add Slider+Dropdown
function CS2UI:AddSliderDropdown(parent,text,min,max,default,options,callback)
	local slider = self:AddSlider(parent,text,min,max,default,function(s)
		callback(nil,s)
	end)
	local drop = self:AddDropdown(parent,text,options,function(d)
		callback(nil,d)
	end)
	return slider, drop
end

-- Add Slider+ColorPicker
function CS2UI:AddSliderColor(parent,text,min,max,default,defaultColor,callback)
	local slider = self:AddSlider(parent,text,min,max,default,function(s)
		callback(nil,s,nil)
	end)
	-- Simple colorpicker button
	local colorBtn = self:AddButton(parent,"Pick Color",function()
		callback(nil,nil,Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)))
	end)
	return slider, colorBtn
end

-- Add Dropdown+ColorPicker
function CS2UI:AddDropdownColor(parent,text,options,defaultColor,callback)
	local drop = self:AddDropdown(parent,text,options,function(d)
		callback(d,nil)
	end)
	local colorBtn = self:AddButton(parent,"Pick Color",function()
		callback(nil,Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)))
	end)
	return drop,colorBtn
end

return CS2UI
