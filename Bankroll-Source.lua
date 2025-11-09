--[[
    Bankroll UI Library (Simulated)
    
    This script defines a basic framework for a high-quality Roblox UI that mimics the
    style and structure of the requested image (dark theme, bottom tab bar,
    and left/right sections).
    
    It includes the core methods: AddWindow, AddTab, AddSection, and placeholder
    methods for controls (AddToggle, AddListbox) to complete the visual look.
    
    NOTE: The UI is created inside a local function and returned as a module
    so it can be executed using loadstring(game:HttpGet(...)) like in the example.
]]

return (function()
    
    -- --- UI Configuration ---
    local FONT = Enum.Font.SourceSans
    local FONT_SIZE = Enum.FontSize.Size18
    local UI_COLORS = {
        BG = Color3.fromRGB(15, 15, 20),           -- Main Window Dark Background
        ACCENT_PURPLE = Color3.fromRGB(150, 0, 255), -- Pink/Purple accent color
        HEADER_BG = Color3.fromRGB(10, 10, 15),
        TAB_BAR_BG = Color3.fromRGB(10, 10, 15),
        TEXT = Color3.fromRGB(255, 255, 255),
        CONTROL_BG = Color3.fromRGB(30, 30, 35),
        SECTION_DIVIDER = Color3.fromRGB(50, 50, 55),
        CONTROL_ON = Color3.fromRGB(150, 0, 255), -- Toggle ON
        CONTROL_OFF = Color3.fromRGB(50, 50, 55),  -- Toggle OFF
    }
    
    -- --- Utility Functions ---
    local function New(class)
        return function(parent)
            local instance = Instance.new(class)
            instance.Parent = parent
            return instance
        end
    end
    
    local NewFrame = New("Frame")
    local NewScreenGui = New("ScreenGui")
    local NewTextLabel = New("TextLabel")
    local NewTextButton = New("TextButton")
    local NewUIListLayout = New("UIListLayout")
    local NewUIPadding = New("UIPadding")
    local NewUICorner = New("UICorner")

    -- --- 1. Control Class Placeholders (Visuals Only) ---

    local Control = {}
    Control.__index = Control

    -- Creates a Toggle control visual
    function Control.AddToggle(parent, text, is_on)
        local frame = NewFrame(parent)
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 0, 30)
        
        local label = NewTextLabel(frame)
        label.Text = text
        label.TextColor3 = UI_COLORS.TEXT
        label.TextSize = 14
        label.Font = FONT
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Position = UDim2.new(0, 5, 0, 0)
        label.Size = UDim2.new(0.9, 0, 1, 0)

        -- Visual Toggle Box
        local box = NewFrame(frame)
        box.BackgroundColor3 = is_on and UI_COLORS.CONTROL_ON or UI_COLORS.CONTROL_OFF
        box.BorderSizePixel = 0
        box.Size = UDim2.new(0, 15, 0, 15)
        box.Position = UDim2.new(1, -20, 0.5, -7)
        box.AnchorPoint = Vector2.new(1, 0.5)
        
        NewUICorner(box).CornerRadius = UDim.new(0, 2)
        
        return frame
    end
    
    -- Creates a Dropdown/Listbox visual placeholder
    function Control.AddListbox(parent, text, value)
        local frame = NewFrame(parent)
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 0, 60)
        
        -- Text Label (e.g., "drops")
        local title = NewTextLabel(frame)
        title.Text = text
        title.TextColor3 = UI_COLORS.TEXT
        title.TextSize = 14
        title.Font = FONT
        title.BackgroundTransparency = 1
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Position = UDim2.new(0, 5, 0, 0)
        title.Size = UDim2.new(0.5, 0, 0.5, 0)
        
        -- Value Display (e.g., "text, ammo")
        local value_display = NewTextButton(frame)
        value_display.Text = value
        value_display.TextColor3 = UI_COLORS.TEXT
        value_display.TextSize = 12
        value_display.Font = FONT
        value_display.BackgroundColor3 = UI_COLORS.CONTROL_BG
        value_display.Size = UDim2.new(1, -10, 0, 25)
        value_display.Position = UDim2.new(0.5, -5, 1, -25)
        value_display.AnchorPoint = Vector2.new(0.5, 1)

        -- Arrow (visual only)
        local arrow = NewTextLabel(value_display)
        arrow.Text = "˅" -- Unicode down arrow
        arrow.TextColor3 = UI_COLORS.TEXT
        arrow.TextSize = 12
        arrow.Font = FONT
        arrow.BackgroundTransparency = 1
        arrow.Size = UDim2.new(0, 10, 1, 0)
        arrow.Position = UDim2.new(1, -15, 0, 0)
        arrow.TextXAlignment = Enum.TextXAlignment.Right
        
        NewUICorner(value_display).CornerRadius = UDim.new(0, 2)
        
        return frame
    end
    
    -- --- 2. Section Class ---

    local Section = {}
    Section.__index = Section

    function Section.new(parent, title_text, alignment)
        local self = setmetatable({}, Section)
        
        local is_left = (alignment == "left")
        
        -- Main Section Frame
        local frame = NewFrame(parent)
        frame.BackgroundColor3 = UI_COLORS.BG
        frame.BorderSizePixel = 0
        frame.Size = UDim2.new(0.5, is_left and -5 or -5, 1, 0)
        frame.Position = UDim2.new(is_left and 0 or 0.5, 0, 0, 0)
        
        -- Section Title (e.g., "entity esp")
        local title = NewTextLabel(frame)
        title.Text = title_text:upper()
        title.TextColor3 = UI_COLORS.TEXT
        title.TextSize = 14
        title.Font = FONT
        title.BackgroundTransparency = 1
        title.Size = UDim2.new(1, 0, 0, 20)
        title.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Control Container
        local control_container = NewFrame(frame)
        control_container.BackgroundTransparency = 1
        control_container.Size = UDim2.new(1, 0, 1, -20)
        control_container.Position = UDim2.new(0, 0, 0, 20)
        
        local layout = NewUIListLayout(control_container)
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.FillDirection = Enum.FillDirection.Vertical
        
        local padding = NewUIPadding(control_container)
        padding.PaddingTop = UDim.new(0, 5)
        padding.PaddingBottom = UDim.new(0, 5)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        
        self.Frame = frame
        self.ControlContainer = control_container
        
        -- Add control methods to the section instance
        self.AddToggle = function(text, is_on)
            return Control.AddToggle(self.ControlContainer, text, is_on)
        end
        self.AddListbox = function(text, value)
            return Control.AddListbox(self.ControlContainer, text, value)
        end
        
        return self
    end

    -- --- 3. Tab Class ---

    local Tab = {}
    Tab.__index = Tab

    function Tab.new(parent, name)
        local self = setmetatable({}, Tab)
        
        -- Frame to hold all sections/content for this specific tab
        local content_frame = NewFrame(parent)
        content_frame.BackgroundTransparency = 1
        content_frame.Size = UDim2.new(1, 0, 1, 0)
        content_frame.Visible = false -- Hidden by default
        
        self.Name = name
        self.ContentFrame = content_frame
        
        return self
    end
    
    function Tab:AddSection(title, alignment)
        -- Alignment must be "left" or "right"
        return Section.new(self.ContentFrame, title, alignment)
    end

    -- --- 4. Window Class ---

    local Window = {}
    Window.__index = Window

    function Window.new(parent_gui, title)
        local self = setmetatable({}, Window)
        self.ActiveTab = nil
        self.Tabs = {}
        
        -- Main Frame (The main UI container)
        local frame = NewFrame(parent_gui)
        frame.BackgroundColor3 = UI_COLORS.BG
        frame.BorderSizePixel = 0
        frame.Size = UDim2.new(0, 700, 0, 400)
        frame.Position = UDim2.new(0.5, -350, 0.5, -200)
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        
        -- Header (Draggable)
        local header = NewFrame(frame)
        header.BackgroundColor3 = UI_COLORS.HEADER_BG
        header.BorderSizePixel = 0
        header.Size = UDim2.new(1, 0, 0, 25)
        
        local header_title = NewTextLabel(header)
        header_title.Text = title:lower()
        header_title.TextColor3 = UI_COLORS.TEXT
        header_title.TextSize = 14
        header_title.Font = FONT
        header_title.BackgroundTransparency = 1
        header_title.Size = UDim2.new(1, 0, 1, 0)
        
        -- Content Area (Contains the active tab's sections)
        local content_area = NewFrame(frame)
        content_area.BackgroundTransparency = 1
        content_area.Size = UDim2.new(1, 0, 1, -55)
        content_area.Position = UDim2.new(0, 0, 0, 25)
        
        local content_padding = NewUIPadding(content_area)
        content_padding.PaddingLeft = UDim.new(0, 10)
        content_padding.PaddingRight = UDim.new(0, 10)
        content_padding.PaddingTop = UDim.new(0, 10)
        content_padding.PaddingBottom = UDim.new(0, 10)
        
        -- Tab Bar at the Bottom
        local tab_bar = NewFrame(frame)
        tab_bar.BackgroundColor3 = UI_COLORS.TAB_BAR_BG
        tab_bar.BorderSizePixel = 0
        tab_bar.Size = UDim2.new(1, 0, 0, 30)
        tab_bar.Position = UDim2.new(0, 0, 1, -30)

        local tab_layout = NewUIListLayout(tab_bar)
        tab_layout.FillDirection = Enum.FillDirection.Horizontal
        tab_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tab_layout.Padding = UDim.new(0, 5)
        
        -- --- Draggable Logic ---
        local dragging = false
        local drag_start = Vector2.new(0, 0)
        local drag_input = nil
        
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                drag_start = input.Position
                drag_input = input
                input.Handled = true
            end
        end)
        
        header.InputEnded:Connect(function(input)
            if input == drag_input then
                dragging = false
                drag_input = nil
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == drag_input and dragging then
                local delta = input.Position - drag_start
                frame.Position = frame.Position + UDim2.new(0, delta.X, 0, delta.Y)
                drag_start = input.Position
            end
        end)
        -- --- End Draggable Logic ---
        
        self.Frame = frame
        self.ContentArea = content_area
        self.TabBar = tab_bar
        self.Title = title

        -- Initial Corner Radius
        NewUICorner(frame).CornerRadius = UDim.new(0, 5)
        
        return self
    end

    -- --- 5. Tab Management and Activation ---

    function Window:ActivateTab(tab_name)
        for _, tab in ipairs(self.Tabs) do
            local isActive = (tab.Name == tab_name)
            tab.ContentFrame.Visible = isActive
            tab.TabBarButton.TextStrokeTransparency = isActive and 0.5 or 1
            tab.TabBarButton.TextColor3 = isActive and UI_COLORS.ACCENT_PURPLE or UI_COLORS.TEXT
        end
        self.ActiveTab = tab_name
    end

    function Window:AddTab(name)
        local tab = Tab.new(self.ContentArea, name)
        
        -- Tab Bar Button
        local button = NewTextButton(self.TabBar)
        button.Text = name:upper()
        button.TextColor3 = UI_COLORS.TEXT
        button.TextStrokeTransparency = 1
        button.TextSize = 14
        button.Font = FONT
        button.BackgroundTransparency = 1
        button.Size = UDim2.new(0, 50, 1, 0)
        
        button.MouseButton1Click:Connect(function()
            self:ActivateTab(name)
        end)
        
        tab.TabBarButton = button
        table.insert(self.Tabs, tab)
        
        if #self.Tabs == 1 then
            self:ActivateTab(name) -- Activate first tab added
        end
        
        return tab
    end

    -- --- 6. The main Bankroll UI Module ---

    local Bankroll = {}
    Bankroll.__index = Bankroll

    function Bankroll.new()
        local self = setmetatable({}, Bankroll)
        self.ScreenGui = NewScreenGui(game.Players.LocalPlayer.PlayerGui)
        self.ScreenGui.Name = "BankrollUIScript"
        self.ScreenGui.ResetOnSpawn = false
        return self
    end

    function Bankroll:AddWindow(title)
        local window = Window.new(self.ScreenGui, title)
        return window
    end

    -- Return the module constructor
    return Bankroll.new()

end)()

local Bankroll = getfenv()._

local window = Bankroll:AddWindow("Bankroll Mafia")

-- Tab Bar items (matching the image's bottom bar: enemy, friendly, world, extra, aim, visuals, skins, misc, config)
local mainTab = window:AddTab("main")
window:AddTab("enemy")
local visualsTab = window:AddTab("visuals")
window:AddTab("skins")
window:AddTab("misc")
window:AddTab("config")

-- We will use the 'visuals' tab for the main content shown in the image

-- Adding Sections to the 'visuals' tab
local leftSection = visualsTab:AddSection("entity esp", "left")
local rightSection = visualsTab:AddSection("effects", "right")
