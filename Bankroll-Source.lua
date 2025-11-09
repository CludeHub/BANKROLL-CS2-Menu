local BankrollUI = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local function new(class, props)
	local obj = Instance.new(class)
	if props then
		for k, v in pairs(props) do
			obj[k] = v
		end
	end
	return obj
end

local function makeToggle(parent, text, startVal)
	local holder = new("Frame", {
		Parent = parent,
		Size = UDim2.new(1, 0, 0, 32),
		BackgroundTransparency = 1,
	})
	local label = new("TextLabel", {
		Parent = holder,
		Position = UDim2.new(0, 6, 0, 4),
		Size = UDim2.new(0.7, -6, 1, -8),
		BackgroundTransparency = 1,
		Text = text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Color3.new(1,1,1),
		Font = Enum.Font.SourceSans,
		TextSize = 14,
	})
	local btn = new("TextButton", {
		Parent = holder,
		Size = UDim2.new(0, 42, 0, 22),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -8, 0, 5),
		Text = "",
		BackgroundColor3 = startVal and Color3.fromRGB(195,154,249) or Color3.fromRGB(36,36,36),
	})
	new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,6)})
	new("UIStroke", {Parent = btn, Color = Color3.fromRGB(40,40,40), Thickness = 1})
	local state = startVal and true or false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.BackgroundColor3 = state and Color3.fromRGB(195,154,249) or Color3.fromRGB(36,36,36)
	end)
	return holder, function() return state end, function(v) state = v; btn.BackgroundColor3 = state and Color3.fromRGB(195,154,249) or Color3.fromRGB(36,36,36) end
end

local function makeDropdown(parent, items, widthScale)
	local holder = new("TextButton", {
		Parent = parent,
		Size = UDim2.new(widthScale or 1, 0, 0, 30),
		BackgroundColor3 = Color3.fromRGB(25,25,25),
		Text = "",
		AutoButtonColor = false,
	})
	new("UICorner", {Parent = holder, CornerRadius = UDim.new(0,4)})
	new("UIStroke", {Parent = holder, Color = Color3.fromRGB(40,40,40), Thickness = 1})
	
	local label = new("TextLabel", {
		Parent = holder,
		Text = items[1] or "",
		Size = UDim2.new(1, -28, 1, 0),
		Position = UDim2.new(0,6,0,0),
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Color3.new(1,1,1),
		Font = Enum.Font.SourceSans,
		TextSize = 13,
	})
	local arrow = new("TextLabel", {
		Parent = holder,
		Size = UDim2.new(0,22,1,0),
		Position = UDim2.new(1, -24,0,0),
		BackgroundTransparency = 1,
		Text = "▾",
		TextColor3 = Color3.fromRGB(180,180,180),
		Font = Enum.Font.SourceSans,
		TextSize = 16,
	})
	
	local list = new("Frame", {
		Parent = holder,
		Position = UDim2.new(0,0,1,6),
		Size = UDim2.new(1,0,0,0),
		BackgroundColor3 = Color3.fromRGB(18,18,18),
		Visible = false,
		ClipsDescendants = true,
	})
	new("UIStroke", {Parent = list, Color = Color3.fromRGB(40,40,40), Thickness = 1})
	local layout = new("UIListLayout", {Parent = list, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,2)})

	for i,item in ipairs(items) do
		local it = new("TextButton", {
			Parent = list,
			Size = UDim2.new(1, -8, 0, 28),
			Position = UDim2.new(0,4,0,0),
			Text = item,
			BackgroundTransparency = 1,
			TextColor3 = Color3.new(1,1,1),
			Font = Enum.Font.SourceSans,
			TextSize = 13,
		})
		it.MouseButton1Click:Connect(function()
			label.Text = item
			list.Visible = false
			list:TweenSize(UDim2.new(1,0,0,0),"Out","Quad",0.12,true)
		end)
	end

	holder.MouseButton1Click:Connect(function()
		list.Visible = not list.Visible
		if list.Visible then
			local total = #items * 32
			list:TweenSize(UDim2.new(1,0,0,total),"Out","Quad",0.12,true)
		else
			list:TweenSize(UDim2.new(1,0,0,0),"Out","Quad",0.12,true)
		end
	end)

	return holder
end
local function makeTabButton(parent, text)
	local btn = new("TextButton", {
		Parent = parent,
		Size = UDim2.new(0, 100, 1, 0),
		Text = text,
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(195,154,249),
		Font = Enum.Font.SourceSans,
		TextSize = 13,
	})
	return btn
end

function BankrollUI:Create()
	local player = Players.LocalPlayer
	local guiParent = player and player:WaitForChild("PlayerGui") or nil
	if not guiParent then return end
	local isTouch = UserInputService.TouchEnabled

	local screenGui = new("ScreenGui", {
		Parent = guiParent,
		Name = "BankrollMafiaUI",
		DisplayOrder = 50,
	})
	local main = new("Frame", {
		Parent = screenGui,
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = isTouch and UDim2.new(0.92, 0, 0.88, 0) or UDim2.new(0, 820, 0, 640),
		BackgroundColor3 = Color3.fromRGB(16,16,16),
	})
	new("UICorner", {Parent = main, CornerRadius = UDim.new(0,6)})
	new("UIStroke", {Parent = main, Color = Color3.fromRGB(45,45,45), Thickness = 1})

	local title = new("TextLabel", {
		Parent = main,
		Size = UDim2.new(1, -30, 0, 36),
		Position = UDim2.new(0, 15, 0, 12),
		BackgroundTransparency = 1,
		Text = "bankroll mafia",
		TextSize = 18,
		Font = Enum.Font.SourceSansBold,
		TextColor3 = Color3.fromRGB(195,154,249),
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	local container = new("Frame", {
		Parent = main,
		Size = UDim2.new(1, -30, 1, -120),
		Position = UDim2.new(0, 15, 0, 56),
		BackgroundTransparency = 1,
	})
	local leftCol = new("Frame", {
		Parent = container,
		Size = UDim2.new(0.48, 0, 1, 0),
		Position = UDim2.new(0,0,0,0),
		BackgroundColor3 = Color3.fromRGB(11,11,11),
	})
	new("UICorner", {Parent = leftCol, CornerRadius = UDim.new(0,4)})
	new("UIStroke", {Parent = leftCol, Color = Color3.fromRGB(30,30,30), Thickness = 1})

	local rightCol = new("Frame", {
		Parent = container,
		Size = UDim2.new(0.48, 0, 1, 0),
		Position = UDim2.new(0.52, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(11,11,11),
	})
	new("UICorner", {Parent = rightCol, CornerRadius = UDim.new(0,4)})
	new("UIStroke", {Parent = rightCol, Color = Color3.fromRGB(30,30,30), Thickness = 1})

	local function makeSection(parent, titleText)
		local sec = new("Frame", {
			Parent = parent,
			Size = UDim2.new(1, -18, 0, 160),
			Position = UDim2.new(0, 9, 0, 8),
			BackgroundTransparency = 1,
		})
		local hdr = new("TextLabel", {
			Parent = sec,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.new(0,0,0,0),
			BackgroundTransparency = 1,
			Text = titleText,
			TextSize = 13,
			Font = Enum.Font.SourceSans,
			TextColor3 = Color3.fromRGB(195,154,249),
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		local content = new("Frame", {
			Parent = sec,
			Size = UDim2.new(1, 0, 1, -26),
			Position = UDim2.new(0,0,0,26),
			BackgroundColor3 = Color3.fromRGB(8,8,8),
		})
		new("UICorner", {Parent = content, CornerRadius = UDim.new(0,4)})
		new("UIStroke", {Parent = content, Color = Color3.fromRGB(28,28,28), Thickness = 1})
		return content
	end

	local entitySection = makeSection(leftCol, "entity esp")
	local dropRow = new("Frame", {Parent = entitySection, Size = UDim2.new(1,0,0,66), BackgroundTransparency = 1})
	local dropToggle, dropGet = makeToggle(dropRow, "drops", false)
	dropToggle.Parent = dropRow
	dropToggle.Position = UDim2.new(0,0,0,6)
	local dropDropdown = makeDropdown(entitySection, {"text, ammo"}, 1)
	dropDropdown.Position = UDim2.new(0,0,0,44)

	local bombRow = new("Frame", {Parent = entitySection, Size = UDim2.new(1,0,0,66), BackgroundTransparency = 1, Position = UDim2.new(0,0,0, 110)})
	local bombToggle, bombGet = makeToggle(bombRow, "bomb", false)
	bombToggle.Parent = bombRow
	bombToggle.Position = UDim2.new(0,0,0,6)
	local bombDropdown = makeDropdown(entitySection, {"icon, text, timer..."}, 1)
	bombDropdown.Position = UDim2.new(0,0,0,152)

	local grenadeSection = makeSection(leftCol, "grenade esp")
	grenadeSection.Position = UDim2.new(0,0,0,240)
	local gToggle1 = makeToggle(grenadeSection, "grenade trajectory", false)
	gToggle1[1].Parent = grenadeSection
	gToggle1[1].Position = UDim2.new(0,6,0,6)
	local gToggle2 = makeToggle(grenadeSection, "grenade proximity warning", false)
	gToggle2[1].Parent = grenadeSection
	gToggle2[1].Position = UDim2.new(0,6,0,44)
	local gToggle3 = makeToggle(grenadeSection, "grenades", false)
	gToggle3[1].Parent = grenadeSection
	gToggle3[1].Position = UDim2.new(0,6,0,82)

	local effectsSection = makeSection(rightCol, "effects")
	local removalDropdown = makeDropdown(effectsSection, {"smoke, flashbang..."}, 0.6)
	removalDropdown.Parent = effectsSection
	removalDropdown.Position = UDim2.new(0,8,0,6)
	local eToggle1 = makeToggle(effectsSection, "bullet impacts", false)
	eToggle1[1].Parent = effectsSection
	eToggle1[1].Position = UDim2.new(0,0,0,44)
	local eToggle2 = makeToggle(effectsSection, "bullet tracers", true)
	eToggle2[1].Parent = effectsSection
	eToggle2[1].Position = UDim2.new(0,0,0,76)
	local eToggle3 = makeToggle(effectsSection, "world hitmarkers", false)
	eToggle3[1].Parent = effectsSection
	eToggle3[1].Position = UDim2.new(0,0,0,108)
	local eToggle4 = makeToggle(effectsSection, "night mode", false)
	eToggle4[1].Parent = effectsSection
	eToggle4[1].Position = UDim2.new(0,0,0,140)

	local bottomTabs = new("Frame", {
		Parent = main,
		Size = UDim2.new(1, -30, 0, 48),
		Position = UDim2.new(0, 15, 1, -60),
		BackgroundTransparency = 1,
	})
	new("UIStroke", {Parent = bottomTabs, Color = Color3.fromRGB(30,30,30), Thickness = 1})
	local tabs = {"enemy","friendly","visuals","skins","world","misc","config"}
	local tabButtons = {}
	for i, t in ipairs(tabs) do
		local btn = makeTabButton(bottomTabs, t)
		btn.Position = UDim2.new((i-1)/#tabs, 6, 0, 0)
		btn.Size = UDim2.new(1/#tabs, -8, 1, 0)
		btn.TextColor3 = Color3.fromRGB(200,200,200)
		if t == "visuals" then
			btn.TextColor3 = Color3.fromRGB(195,154,249)
		end
		tabButtons[t] = btn
	end

	return {
		ScreenGui = screenGui,
		GetToggles = function()
			return {
				Drops = dropGet(),
				Bomb = bombGet(),
				GrenadeTrajectory = gToggle1[2] and gToggle1[2] or function() return false end,
				BulletTracers = eToggle2 and eToggle2[2] or function() return false end,
			}
		end,
		Destroy = function()
			if screenGui and screenGui.Parent then
				screenGui:Destroy()
			end
		end,
	}
end

return BankrollUI
