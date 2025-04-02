-- KRNL-Compatible Fake Reflection Script
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")

-- Function to create the reflection
local function createReflection()
    if not character then return end

    -- Clone the character
    local reflection = character:Clone()
    reflection.Parent = game.Workspace
    reflection.Name = "FakeReflection"

    -- Remove scripts from the cloned character to prevent issues
    for _, obj in pairs(reflection:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Transparency = 0.5 -- Adjust transparency
            obj.Color = Color3.fromRGB(50, 50, 50) -- Darker shade for a reflection look
        end
    end

    -- Disable physics and collisions for smoother effect
    for _, part in pairs(reflection:GetChildren()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
        end
    end

    -- Function to update the reflection position in real time
    runService.RenderStepped:Connect(function()
        if character and character:FindFirstChild("HumanoidRootPart") and reflection:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local refHrp = reflection.HumanoidRootPart

            -- Position reflection below the character, flipped
            refHrp.CFrame = hrp.CFrame * CFrame.new(0, -hrp.Size.Y * 2 - 0.5, 0) * CFrame.Angles(math.rad(180), 0, 0)
        end
    end)
end

-- Run the function when the script is executed
createReflection()
