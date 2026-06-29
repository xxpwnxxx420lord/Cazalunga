local module = {}

local lplr : Player = game.Players.LocalPlayer

function module:return_limb(part: String)
    return lplr.Character[part]
end

function module:GetService(Service: string)
    return cloneref(game:GetService(Service))
end

function module:teleport(time: IntValue, cframe: CFrame)   
    local ts: TweenService = module:GetService("TweenService")
    local Tween1nfo = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    ts:Create(module:return_limb("HumanoidRootPart"), Tween1nfo, {CFrame = cframe}):Play()
end



return module