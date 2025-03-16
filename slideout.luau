-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Player GUI
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "NotificationGUI"
gui.ResetOnSpawn = false

-- Notification Frame
local notification = Instance.new("Frame", gui)
notification.Name = "Notification"
notification.AnchorPoint = Vector2.new(1, 0) -- Top-right corner
notification.Position = UDim2.new(1, -10, 0, 10) -- 10 pixels from the top-right edge
notification.Size = UDim2.new(0, 300, 0, 80) -- Width: 300, Height: 80
notification.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Light black
notification.BackgroundTransparency = 0.2 -- Slightly transparent
notification.BorderSizePixel = 0 -- No border

-- Rounded Corners
local corner = Instance.new("UICorner", notification)
corner.CornerRadius = UDim.new(0, 12) -- Rounded corners

-- Title ("cAPI")
local title = Instance.new("TextLabel", notification)
title.Name = "Title"
title.Text = "cAPI"
title.TextColor3 = Color3.new(1, 1, 1) -- White text
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Position = UDim2.new(0, 60, 0, 10) -- Offset from left and top
title.Size = UDim2.new(0, 200, 0, 20) -- Width: 200, Height: 20
title.BackgroundTransparency = 1 -- Transparent background
title.TextXAlignment = Enum.TextXAlignment.Left -- Left-aligned text

-- Subtitle ("Loaded")
local subtitle = Instance.new("TextLabel", notification)
subtitle.Name = "Subtitle"
subtitle.Text = "Loaded"
subtitle.TextColor3 = Color3.new(0.8, 0.8, 0.8) -- Light gray text
subtitle.TextSize = 14
subtitle.Font = Enum.Font.Gotham
subtitle.Position = UDim2.new(0, 60, 0, 35) -- Below the title
subtitle.Size = UDim2.new(0, 200, 0, 20) -- Width: 200, Height: 20
subtitle.BackgroundTransparency = 1 -- Transparent background
subtitle.TextXAlignment = Enum.TextXAlignment.Left -- Left-aligned text

-- Checkmark Icon
local checkmark = Instance.new("ImageLabel", notification)
checkmark.Name = "Checkmark"
checkmark.Image = "rbxassetid://12348387864" -- Checkmark asset ID
checkmark.Size = UDim2.new(0, 40, 0, 40) -- Size of the icon
checkmark.Position = UDim2.new(0, 10, 0.5, -20) -- Centered vertically, 10px from left
checkmark.BackgroundTransparency = 1 -- Transparent background
checkmark.ScaleType = Enum.ScaleType.Fit -- Ensure the icon fits

-- Animation: Slide in
notification.Position = UDim2.new(1, 350, 0, 10) -- Start off-screen to the right
local slideIn = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
    Position = UDim2.new(1, -10, 0, 10) -- Slide to the final position
})
slideIn:Play()

-- Animation: Slide out after a delay
task.wait(3) -- Wait 3 seconds before sliding out
local slideOut = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
    Position = UDim2.new(1, 350, 0, 10) -- Slide off-screen to the right
})
slideOut:Play()

-- Destroy the notification after the animation
slideOut.Completed:Wait()
notification:Destroy()
