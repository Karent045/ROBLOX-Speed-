--// Stylish Speed GUI (для твоей игры)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui -- В своей игре можно использовать StarterGui

-- Окно
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 140)
frame.Position = UDim2.new(0.5, -125, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = screenGui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "For Karent | Speed Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- Поле ввода
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 30)
textBox.Position = UDim2.new(0.1, 0, 0, 40)
textBox.PlaceholderText = "Enter speed..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.Parent = frame

local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 8)
tbCorner.Parent = textBox

-- Кнопка
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 30)
button.Position = UDim2.new(0.1, 0, 0, 80)
button.Text = "Activate"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = button

-- Анимация кнопки при нажатии
button.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(textBox.Text)
    if newSpeed then
        humanoid.WalkSpeed = newSpeed
        -- Анимация цвета кнопки при активации
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 200, 120)})
        tween:Play()
        tween.Completed:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 120, 255)}):Play()
        end)
    else
        button.Text = "Invalid!"
        task.wait(0.5)
        button.Text = "Activate"
    end
end)

-- Скрытие/показ окна по Shift
local menuVisible = true
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftShift then
        menuVisible = not menuVisible
        local goal = {}
        if menuVisible then
            frame.Visible = true
            goal.Size = UDim2.new(0, 250, 0, 140)
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal):Play()
        else
            goal.Size = UDim2.new(0, 250, 0, 0)
            local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), goal)
            tween:Play()
            tween.Completed:Connect(function()
                if not menuVisible then
                    frame.Visible = false
                end
            end)
        end
    end
end)
