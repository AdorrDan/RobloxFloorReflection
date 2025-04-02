-- Fake Reflection Script for KRNL
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")

-- Function to create and update reflection
local function createReflection()
    if not character then return end

    -- Clone the character
    local reflection = character:Clone()
    reflection.Parent = game.Workspace
    reflection.Name = "FakeReflection"

    -- Remove scripts from the clone
    for _, v in pairs(reflection:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") then
            v:Destroy()
        end
    end

    -- Change reflection appearance
    for _, part in pairs(reflection:GetChildren()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.Glass
            part.Color = Color3.new(0, 0, 0) -- Darker color for better effect
            part.Transparency = 0.4 -- Adjust transparency for a reflection look
        end
    end

    -- Update reflection position every frame
    runService.RenderStepped:Connect(function()
        if character and character:FindFirstChild("HumanoidRootPart") and reflection:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local refHrp = reflection.HumanoidRootPart
            
            -- Position reflection below character
            refHrp.CFrame = hrp.CFrame * CFrame.new(0, -hrp.Size.Y * 2, 0) * CFrame.Angles(math.rad(180), 0, 0)
        end
    end)
end

-- Run the function to create the reflection
createReflection()