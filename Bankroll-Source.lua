-- BankrollLib ModuleScript
-- Bankroll Mafia style UI (tiny square checkbox toggles, rounded, aspect-ratio scaled)
local Bankroll = {}
Bankroll.Accent = Color3.fromRGB(190, 120, 255) -- pink/purple accent
Bankroll.Background = Color3.fromRGB(12,12,12)
Bankroll.Panel = Color3.fromRGB(18,18,18)
Bankroll.Text = Color3.fromRGB(210,210,210)
Bankroll.SubText = Color3.fromRGB(150,150,150)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Utility constructors
local function make(name, class, props)
	local ins = Instance.new(class)
	ins.Name = name
	if props then
		for k,v in pairs(props) do ins[k] = v end
	end
	return ins
end

-- Creates a subtle rounded panel with padding
local function createPanel(parent, size, pos)
	local f = make("Panel", "Frame", {
		BackgroundColor3 = Bankroll.Panel,
		BorderSizePixel = 0,
		Size = size,
		Position = pos,
		Active = true
	})
	local corner = make("Corner", "UICorner", {CornerRadius = UDim.new(0,8)})
	corner.Parent = f
	f.Parent = parent
	return f
end

-- Scale constants (based on a mobile-friendly target height ~380)
local BASE_WIDTH = 620
local BASE_HEIGHT = 380

-- Main window constructor
function Bankroll:CreateWindow(title)
	local UI = {}

	-- create screen gui
	local ScreenGui = make("BankrollScreen", "ScreenGui", {IgnoreGuiInset = true, ResetOnSpawn = false})
	ScreenGui.Parent = pgui

	-- container frame (we'll scale using an AspectRatioConstraint)
	local Container = make("Container", "Frame", {
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT),
		BackgroundColor3 = Bankroll.Background,
		BorderSizePixel = 0,
		Active = true,
	})
	local cornerMain = make("MainCorner", "UICorner", {CornerRadius = UDim.new(0,10)})
	cornerMain.Parent = Container
	Container.Parent = ScreenGui

	-- Keep aspect ratio: width / height = BASE_WIDTH / BASE_HEIGHT
	local asp = make("Aspect", "UIAspectRatioConstraint", {AspectRatio = BASE_WIDTH/BASE_HEIGHT, DominantAxis = Enum.DominantAxis.Width})
	asp.Parent = Container

	-- Topbar
	local Topbar = make("Topbar", "Frame", {
		Size = UDim2.new(1,0,0,36),
		BackgroundColor3 = Bankroll.Panel,
		BorderSizePixel = 0,
		Parent = Container
	})
	make("TopbarCorner", "UICorner", {CornerRadius = UDim.new(0,8)}).Parent = Topbar
	local titleLabel = make("Title", "TextLabel", {
		BackgroundTransparency = 1,
		Text = title or "bankroll mafia",
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Bankroll.Text,
		Size = UDim2.new(1,0,1,0),
		Parent = Topbar
	})

	-- Accent divider under topbar
	local Accent = make("Accent", "Frame", {
		Size = UDim2.new(1,0,0,2),
		Position = UDim2.new(0,0,0,36),
		BackgroundColor3 = Bankroll.Accent,
		BorderSizePixel = 0,
		Parent = Container
	})

	-- Content area
	local Content = make("Content", "Frame", {
		Size = UDim2.new(1,-20,1,-110),
		Position = UDim2.new(0,10,0,42),
		BackgroundTransparency = 1,
		Parent = Container
	})

	-- Left and Right columns (two-column layout)
	local leftCol = createPanel(Content, UDim2.new(0.48,0,1,0), UDim2.new(0,0,0,0))
	local rightCol = createPanel(Content, UDim2.new(0.48,0,1,0), UDim2.new(0.52,0,0,0))

	-- inner padding using ScrollingFrame for each column so sections can scroll
	local leftScroll = make("LeftScroll", "ScrollingFrame", {
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		CanvasSize = UDim2.new(0,0,0,0),
		Parent = leftCol
	})
	local rs = make("RightScroll", "ScrollingFrame", {
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		CanvasSize = UDim2.new(0,0,0,0),
		Parent = rightCol
	})

	-- layouts inside scrolls
	local leftLayout = make("LeftLayout", "UIListLayout", {Padding = UDim.new(0,12),Parent = leftScroll})
	leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	local rightLayout = make("RightLayout", "UIListLayout", {Padding = UDim.new(0,12),Parent = rs})
	rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

	-- bottom tab bar
	local TabBar = make("TabBar", "Frame", {
		Size = UDim2.new(1,0,0,44),
		Position = UDim2.new(0,0,1,-44),
		BackgroundColor3 = Bankroll.Panel,
		BorderSizePixel = 0,
		Parent = Container
	})
	make("TabCorner", "UICorner", {CornerRadius = UDim.new(0,8)}).Parent = TabBar

	local tabLayout = make("TabLayout", "UIListLayout", {
		Parent = TabBar,
	})
	tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabLayout.Padding = UDim.new(0,12)
	tabLayout.FillDirection = Enum.FillDirection.Horizontal
	tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

	-- helper: make section blocks that look like screenshot
	local function makeSection(parentScrolling, headerText, height)
		height = height or 160
		local sec = createPanel(parentScrolling, UDim2.new(1,-12,0,height), UDim2.new(0,6,0,0))
		sec.BackgroundColor3 = Bankroll.Panel
		local secCorner = sec:FindFirstChildOfClass("UICorner") or make("secCorner", "UICorner", {CornerRadius = UDim.new(0,6)}); secCorner.Parent = sec

		local header = make("Header","TextLabel",{
			Parent = sec,
			BackgroundTransparency = 1,
			Size = UDim2.new(1,-12,0,26),
			Position = UDim2.new(0,6,0,6),
			Font = Enum.Font.Gotham,
			TextSize = 13,
			Text = headerText or "",
			TextColor3 = Bankroll.Text,
			TextXAlignment = Enum.TextXAlignment.Left
		})

		-- container for items
		local items = make("Items","Frame",{Parent = sec, BackgroundTransparency = 1, Size = UDim2.new(1,-12,1,-40), Position = UDim2.new(0,6,0,36)})
		local itemsLayout = make("ItemsLayout","UIListLayout",{Parent = items, Padding = UDim.new(0,6)})
		itemsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

		-- auto adjust canvas size of parentScrolling
		spawn(function()
			task.wait()
			local layout = parentScrolling:FindFirstChildOfClass("UIListLayout")
			if layout then
				parentScrolling.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 16)
			end
		end)

		return {
			Frame = sec,
			Items = items,
			AddToggle = function(_, label, default, callback)
				local row = make("Row","Frame",{Parent = items, BackgroundTransparency = 1, Size = UDim2.new(1,0,0,24)})
				local lbl = make("Label","TextLabel",{
					Parent = row, BackgroundTransparency = 1,
					Size = UDim2.new(1, -36, 1, 0),
					Font = Enum.Font.Gotham,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = label,
					TextColor3 = Bankroll.Text
				})
				local toggle = make("Toggle","TextButton",{
					Parent = row,
					Size = UDim2.new(0,22,0,16),
					Position = UDim2.new(1,-26,0,4),
					BackgroundColor3 = default and Bankroll.Accent or Color3.fromRGB(38,38,38),
					AutoButtonColor = false,
					Text = "",
					BorderSizePixel = 0,
				})
				make("togcorner","UICorner",{CornerRadius = UDim.new(0,4), Parent = toggle})

				local state = default and true or false
				local function setState(v, instant)
					state = not (v == false)
					local goal = {BackgroundColor3 = state and Bankroll.Accent or Color3.fromRGB(38,38,38)}
					if instant then toggle.BackgroundColor3 = goal.BackgroundColor3 else
						TweenService:Create(toggle, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
					end
					if callback then pcall(callback, state) end
				end
				toggle.MouseButton1Click:Connect(function() setState(not state) end)
				setState(state, true)
				return {Set = setState, Get = function() return state end}
			end,
			AddDropdown = function(_, label, options, callback)
				local row = make("Row","Frame",{Parent = items, BackgroundTransparency = 1, Size = UDim2.new(1,0,0,28)})
				local lbl = make("Label","TextLabel",{
					Parent = row, BackgroundTransparency = 1,
					Size = UDim2.new(1,-12,1,0),
					Font = Enum.Font.Gotham,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = label,
					TextColor3 = Bankroll.SubText
				})
				local box = make("Box","TextButton",{
					Parent = row,
					Size = UDim2.new(1,0,1,0),
					BackgroundColor3 = Color3.fromRGB(20,20,20),
					Position = UDim2.new(0,0,0,0),
					BorderSizePixel = 0,
					Text = options[1] or "select",
					Font = Enum.Font.Gotham,
					TextSize = 13,
					TextColor3 = Bankroll.Text,
					AutoButtonColor = false
				})
				box.ZIndex = 2
				local bc = make("BoxCorner","UICorner",{CornerRadius = UDim.new(0,6), Parent = box})
				-- arrow
				local arrow = make("Arrow","ImageLabel",{Parent = box, Size = UDim2.new(0,14,0,14), Position = UDim2.new(1,-18,0.5,-7), BackgroundTransparency = 1, Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(644, 284), ImageRectSize = Vector2.new(36, 36)})
				arrow.ImageTransparency = 0.6

				local list = make("List","Frame",{Parent = box, Size = UDim2.new(1,0,0,#options*28), Position = UDim2.new(0,0,1,6), BackgroundColor3 = Bankroll.Panel, BorderSizePixel = 0, Visible = false})
				make("listcorner","UICorner",{CornerRadius = UDim.new(0,6), Parent = list})
				local layout = make("layout","UIListLayout",{Parent = list, Padding = UDim.new(0,4)})
				layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

				for _,opt in ipairs(options) do
					local item = make("Item","TextButton",{Parent = list, BackgroundTransparency = 1, Size = UDim2.new(1,0,0,26), Text = opt, Font = Enum.Font.Gotham, TextColor3 = Bankroll.Text, TextSize = 13, AutoButtonColor = false})
					item.MouseButton1Click:Connect(function()
						box.Text = opt
						list.Visible = false
						if callback then pcall(callback, opt) end
					end)
				end

				box.MouseButton1Click:Connect(function()
					list.Visible = not list.Visible
				end)

				return {
					Set = function(v) box.Text = v end,
					Get = function() return box.Text end
				}
			end,
		}
	end

	-- store references so user can add sections
	UI.ScreenGui = ScreenGui
	UI.Container = Container
	UI.LeftScroll = leftScroll
	UI.RightScroll = rs
	UI.Tabs = {}

	-- public: Create Tab (each Tab can host sections; switching visibility mimics bottom nav)
	function UI:CreateTab(name)
		local tabBtn = make(name.."Btn","TextButton",{
			Parent = TabBar,
			BackgroundTransparency = 1,
			Size = UDim2.new(0,96,0,28),
			Font = Enum.Font.Gotham,
			Text = name,
			TextSize = 13,
			TextColor3 = Bankroll.SubText,
			AutoButtonColor = false
		})
		local tab = {Name = name, Btn = tabBtn, Sections = {}}

		-- content frames for this tab: left & right pages
		local leftPage = make(name.."Left","Frame",{Parent = leftScroll, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1})
		local rightPage = make(name.."Right","Frame",{Parent = rs, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1})

		-- initially show first tab only
		if #UI.Tabs == 0 then
			leftPage.Visible = true; rightPage.Visible = true
			tabBtn.TextColor3 = Bankroll.Text
		else
			leftPage.Visible = false; rightPage.Visible = false
		end

		tabBtn.MouseButton1Click:Connect(function()
			for _,t in ipairs(UI.Tabs) do
				t.Left.Visible = false; t.Right.Visible = false
				t.Btn.TextColor3 = Bankroll.SubText
			end
			leftPage.Visible = true; rightPage.Visible = true
			tabBtn.TextColor3 = Bankroll.Text
		end)

		tab.Left = leftPage
		tab.Right = rightPage

		function tab:AddLeftSection(title, height)
			local s = makeSection(leftPage, title, height)
			table.insert(tab.Sections, s)
			return s
		end
		function tab:AddRightSection(title, height)
			local s = makeSection(rightPage, title, height)
			table.insert(tab.Sections, s)
			return s
		end

		table.insert(UI.Tabs, tab)
		return tab
	end

	-- expose UI object
	return UI
end

return Bankroll
