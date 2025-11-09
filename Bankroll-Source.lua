--!strict
local UILibrary = {}

-- Configuration for colors and fonts
UILibrary.Config = {
    PrimaryColor = Color3.fromRGB(30, 30, 30),
    AccentColor = Color3.fromRGB(150, 75, 200), -- A purple-ish accent
    TextColor = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.SourceSans,
    FontSize = Enum.FontSize.Size18,
    Padding = 10,
    HeaderHeight = 30,
    ItemHeight = 25,
    CornerRadius = 5,
}

-- Function to create a base UI element with scaling and aspect ratio
local function createBaseElement(name: string, parent: Instance, size: UDim2, position: UDim2, order: number?)
    local element = Instance.new("Frame")
    element.Name = name
    element.Parent = parent
    element.Size = size
    element.Position = position
    element.BackgroundTransparency = 1
    if order then
        element.ZIndex = order
    end

    local aspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    aspectRatioConstraint.Parent = element
    aspectRatioConstraint.AspectRatio = size.X.Scale / size.Y.Scale
    aspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width -- Maintain width and scale height

    return element
end

-- Function to create a main window/frame
function UILibrary.createWindow(title: string, parent: Instance, size: UDim2, position: UDim2): Frame
    local window = createBaseElement("Window", parent, size, position, 1)
    window.BackgroundColor3 = UILibrary.Config.PrimaryColor
    window.BorderSizePixel = 0
    window.ClipsDescendants = true

    local header = createBaseElement("Header", window, UDim2.new(1, 0, 0, UILibrary.Config.HeaderHeight), UDim2.new(0, 0, 0, 0))
    header.BackgroundColor3 = UILibrary.Config.PrimaryColor
    header.BorderSizePixel = 0

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Name = "Title"
    headerLabel.Parent = header
    headerLabel.Size = UDim2.new(1, -UILibrary.Config.Padding * 2, 1, 0)
    headerLabel.Position = UDim2.new(0, UILibrary.Config.Padding, 0, 0)
    headerLabel.BackgroundColor3 = UILibrary.Config.PrimaryColor
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = title
    headerLabel.TextColor3 = UILibrary.Config.TextColor
    headerLabel.Font = UILibrary.Config.Font
    headerLabel.TextSize = UILibrary.Config.FontSize.Value
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.TextYAlignment = Enum.TextYAlignment.Center

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    corner.Parent = window

    return window
end

-- Function to create a section/group within a window
function UILibrary.createSection(name: string, parent: Frame, height: UDim): Frame
    local section = createBaseElement("Section_" .. name, parent, UDim2.new(1, -UILibrary.Config.Padding * 2, height.Scale, height.Offset), UDim2.new(0, UILibrary.Config.Padding, 0, 0))
    section.BackgroundColor3 = UILibrary.Config.PrimaryColor
    section.BorderSizePixel = 0

    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Name = "SectionTitle"
    sectionLabel.Parent = section
    sectionLabel.Size = UDim2.new(1, 0, 0, UILibrary.Config.ItemHeight)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Text = name
    sectionLabel.TextColor3 = UILibrary.Config.TextColor
    sectionLabel.Font = UILibrary.Config.Font
    sectionLabel.TextSize = UILibrary.Config.FontSize.Value
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.TextYAlignment = Enum.TextYAlignment.Center
    sectionLabel.Position = UDim2.new(0, 0, 0, 0)

    -- Layout for items within the section
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = section
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, UILibrary.Config.Padding)
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

    -- Set the section title to the first item
    sectionLabel.LayoutOrder = 1

    return section
end

-- Function to create a toggle switch
function UILibrary.createToggle(label: string, parent: Frame, defaultValue: boolean): Frame
    local toggleFrame = createBaseElement("Toggle_" .. label, parent, UDim2.new(1, 0, 0, UILibrary.Config.ItemHeight), UDim2.new(0, 0, 0, 0))
    toggleFrame.BackgroundTransparency = 1

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Parent = toggleFrame
    toggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    toggleLabel.Position = UDim2.new(0, 0, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = label
    toggleLabel.TextColor3 = UILibrary.Config.TextColor
    toggleLabel.Font = UILibrary.Config.Font
    toggleLabel.TextSize = UILibrary.Config.FontSize.Value
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.TextYAlignment = Enum.TextYAlignment.Center

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "Button"
    toggleButton.Parent = toggleFrame
    toggleButton.Size = UDim2.new(0.15, 0, 0.8, 0)
    toggleButton.Position = UDim2.new(0.85, 0, 0.1, 0)
    toggleButton.BackgroundColor3 = UILibrary.Config.AccentColor
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    corner.Parent = toggleButton

    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Parent = toggleButton
    indicator.Size = UDim2.new(0.4, 0, 0.8, 0)
    indicator.Position = UDim2.new(0.05, 0, 0.1, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    indicator.BorderSizePixel = 0

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius - 1)
    indicatorCorner.Parent = indicator

    local value = defaultValue or false
    local connection: RBXScriptConnection? = nil

    local function updateToggleVisual()
        if value then
            indicator:TweenPosition(UDim2.new(0.55, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            toggleButton.BackgroundColor3 = UILibrary.Config.AccentColor
        else
            indicator:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end

    updateToggleVisual()

    toggleButton.MouseButton1Click:Connect(function()
        value = not value
        updateToggleVisual()
        if connection then
            connection:Fire(value)
        end
    end)

    function toggleFrame:GetValue(): boolean
        return value
    end

    function toggleFrame:SetValue(newValue: boolean)
        value = newValue
        updateToggleVisual()
    end

    function toggleFrame:OnChanged(callback: (newValue: boolean) -> ()): RBXScriptConnection
        connection = toggleFrame.Changed:Connect(callback)
        return connection
    end

    return toggleFrame
end

-- Function to create a dropdown
function UILibrary.createDropdown(label: string, parent: Frame, options: {string}, defaultValue: string): Frame
    local dropdownFrame = createBaseElement("Dropdown_" .. label, parent, UDim2.new(1, 0, 0, UILibrary.Config.ItemHeight), UDim2.new(0, 0, 0, 0))
    dropdownFrame.BackgroundTransparency = 1

    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Name = "Label"
    dropdownLabel.Parent = dropdownFrame
    dropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
    dropdownLabel.Position = UDim2.new(0, 0, 0, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Text = label
    dropdownLabel.TextColor3 = UILibrary.Config.TextColor
    dropdownLabel.Font = UILibrary.Config.Font
    dropdownLabel.TextSize = UILibrary.Config.FontSize.Value
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.TextYAlignment = Enum.TextYAlignment.Center

    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Parent = dropdownFrame
    dropdownButton.Size = UDim2.new(0.45, 0, 0.9, 0)
    dropdownButton.Position = UDim2.new(0.55, 0, 0.05, 0)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownButton.BorderSizePixel = 0
    dropdownButton.TextColor3 = UILibrary.Config.TextColor
    dropdownButton.Font = UILibrary.Config.Font
    dropdownButton.TextSize = UILibrary.Config.FontSize.Value
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Center
    dropdownButton.TextYAlignment = Enum.TextYAlignment.Center

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    buttonCorner.Parent = dropdownButton

    local currentSelection = defaultValue or options[1]
    dropdownButton.Text = currentSelection

    local isOpen = false
    local dropdownList: Frame? = nil

    local function createList()
        if dropdownList then dropdownList:Destroy() end

        dropdownList = createBaseElement("DropdownList", parent, UDim2.new(dropdownButton.Size.X.Scale, 0, 0, #options * UILibrary.Config.ItemHeight), dropdownButton.AbsolutePosition)
        dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        dropdownList.BorderSizePixel = 0
        dropdownList.Position = UDim2.new(
            dropdownFrame.Position.X.Scale + dropdownButton.Position.X.Scale, dropdownFrame.Position.X.Offset + dropdownButton.Position.X.Offset,
            dropdownFrame.Position.Y.Scale + dropdownButton.Position.Y.Scale, dropdownFrame.Position.Y.Offset + dropdownButton.Position.Y.Offset + UILibrary.Config.ItemHeight
        )
        dropdownList.ZIndex = 3 -- Ensure it's on top

        local listCorner = Instance.new("UICorner")
        listCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
        listCorner.Parent = dropdownList

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = dropdownList
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 2)
        UIListLayout.FillDirection = Enum.FillDirection.Vertical
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

        for i, optionText in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = "Option_" .. optionText
            optionButton.Parent = dropdownList
            optionButton.Size = UDim2.new(1, 0, 0, UILibrary.Config.ItemHeight)
            optionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            optionButton.BorderSizePixel = 0
            optionButton.TextColor3 = UILibrary.Config.TextColor
            optionButton.Font = UILibrary.Config.Font
            optionButton.TextSize = UILibrary.Config.FontSize.Value
            optionButton.Text = optionText
            optionButton.TextXAlignment = Enum.TextXAlignment.Center
            optionButton.TextYAlignment = Enum.TextYAlignment.Center
            optionButton.LayoutOrder = i

            optionButton.MouseButton1Click:Connect(function()
                currentSelection = optionText
                dropdownButton.Text = currentSelection
                if dropdownList then dropdownList:Destroy() end
                isOpen = false
            end)

            optionButton.MouseEnter:Connect(function()
                optionButton.BackgroundColor3 = UILibrary.Config.AccentColor
            end)
            optionButton.MouseLeave:Connect(function()
                optionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end)
        end
    end

    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            createList()
        else
            if dropdownList then dropdownList:Destroy() end
        end
    end)

    function dropdownFrame:GetValue(): string
        return currentSelection
    end

    function dropdownFrame:SetValue(newValue: string)
        if table.find(options, newValue) then
            currentSelection = newValue
            dropdownButton.Text = currentSelection
        end
    end

    return dropdownFrame
end

-- Function to create a basic slider (you would need more advanced logic for actual sliding)
function UILibrary.createSlider(label: string, parent: Frame, min: number, max: number, defaultValue: number): Frame
    local sliderFrame = createBaseElement("Slider_" .. label, parent, UDim2.new(1, 0, 0, UILibrary.Config.ItemHeight), UDim2.new(0, 0, 0, 0))
    sliderFrame.BackgroundTransparency = 1

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "Label"
    sliderLabel.Parent = sliderFrame
    sliderLabel.Size = UDim2.new(0.4, 0, 1, 0)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = label
    sliderLabel.TextColor3 = UILibrary.Config.TextColor
    sliderLabel.Font = UILibrary.Config.Font
    sliderLabel.TextSize = UILibrary.Config.FontSize.Value
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.TextYAlignment = Enum.TextYAlignment.Center

    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Parent = sliderFrame
    sliderTrack.Size = UDim2.new(0.55, 0, 0.3, 0)
    sliderTrack.Position = UDim2.new(0.45, 0, 0.35, 0)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderTrack.BorderSizePixel = 0

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    trackCorner.Parent = sliderTrack

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Parent = sliderTrack
    sliderFill.Size = UDim2.new(0, 0, 1, 0) -- Will be updated
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = UILibrary.Config.AccentColor
    sliderFill.BorderSizePixel = 0

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    fillCorner.Parent = sliderFill

    local sliderThumb = Instance.new("Frame")
    sliderThumb.Name = "Thumb"
    sliderThumb.Parent = sliderTrack
    sliderThumb.Size = UDim2.new(0, 15, 0, 15)
    sliderThumb.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    sliderThumb.BorderSizePixel = 0
    sliderThumb.ZIndex = 2

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
    thumbCorner.Parent = sliderThumb

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Parent = sliderFrame
    valueLabel.Size = UDim2.new(0.1, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.9, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = UILibrary.Config.TextColor
    valueLabel.Font = UILibrary.Config.Font
    valueLabel.TextSize = UILibrary.Config.FontSize.Value
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.TextYAlignment = Enum.TextYAlignment.Center

    local currentValue = defaultValue or min
    local isDragging = false
    local connection: RBXScriptConnection? = nil

    local function updateSliderVisual()
        local normalizedValue = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(normalizedValue, 0, 1, 0)
        sliderThumb.Position = UDim2.new(normalizedValue, -sliderThumb.Size.X.Offset / 2, 0, (sliderTrack.Size.Y.Offset - sliderThumb.Size.Y.Offset) / 2)
        valueLabel.Text = tostring(math.floor(currentValue))
    end

    updateSliderVisual()

    sliderThumb.MouseButton1Down:Connect(function()
        isDragging = true
    end)

    sliderTrack.MouseButton1Down:Connect(function(x, y)
        isDragging = true
        local relativeX = x - sliderTrack.AbsolutePosition.X
        local newNormalizedValue = math.clamp(relativeX / sliderTrack.AbsoluteSize.X, 0, 1)
        currentValue = min + (max - min) * newNormalizedValue
        updateSliderVisual()
        if connection then
            connection:Fire(currentValue)
        end
    end)

    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.MouseUp:Connect(function()
        isDragging = false
    end)

    mouse.Move:Connect(function()
        if isDragging then
            local relativeX = mouse.X - sliderTrack.AbsolutePosition.X
            local newNormalizedValue = math.clamp(relativeX / sliderTrack.AbsoluteSize.X, 0, 1)
            currentValue = min + (max - min) * newNormalizedValue
            updateSliderVisual()
            if connection then
                connection:Fire(currentValue)
            end
        end
    end)

    function sliderFrame:GetValue(): number
        return currentValue
    end

    function sliderFrame:SetValue(newValue: number)
        currentValue = math.clamp(newValue, min, max)
        updateSliderVisual()
    end

    function sliderFrame:OnChanged(callback: (newValue: number) -> ()): RBXScriptConnection
        connection = sliderFrame.Changed:Connect(callback)
        return connection
    end

    return sliderFrame
end

return UILibrary
