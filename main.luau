local root: string = "https://raw.githubusercontent.com/xxpwnxxx420lord/Cazalunga/master"
local assets: string = root.."/assets/"
local modules: string = root.."/modules/"

function return_Module(asset: string)  
    local req = request({Url = modules..asset, Method = "GET"})

    if req.StatusCode ~= 200 then
        return error("["..modules..asset.."] Failed to load, please check your internet.")
    end

    local chunk, err = loadstring(req.Body)
    if not chunk then
        error("["..modules..asset.."] Probally has an error inside of it")
    end

    return chunk()
end

local Icons: ModuleScript = return_Module("iconpack.luau")
local Global: ModuleScript = return_Module("global.luau")

local Theme = {
    SchemeColor = Color3.fromRGB(234, 140, 85),
    Background = Color3.fromRGB(129, 23, 27),
    Header = Color3.fromRGB(173, 46, 36),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(84, 8, 4)
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() -- I pruposely chose kevo UI, because i couldn't be fucked in the complicated UIs who even cares nobody is going to use this other than to skid
local Window = Library.CreateLib("Sell a lemon", Theme)

local FarmTab = Window:NewTab("Farm")
local LI = FarmTab:NewSection("Low-Income")
local AB = FarmTab:NewSection("Auto Buy")

function findtycoon() -- this only works if you have a sign in the lemonade stand, also this is a shit method to detect the tycoon but it works
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent.Name == "Part4" and v.Parent.Parent.Name == "Billboard" then
            return v.Parent.Parent.Parent.Parent.Parent.Parent.Name
        end
    end
end

-- Low Income
Lemon = LI:NewToggle("Auto Lemon", "Collects every lemon", function(state)
    while state do
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local targets = {}

        for _, tree in ipairs(workspace:GetDescendants()) do
            if not state then break end
            if tree.Name == "LemonTree" and tree:IsA("Model") then
                for _, obj in ipairs(tree:GetDescendants()) do
                    if obj:IsA("Part") then
                        local cd = obj:FindFirstChildOfClass("ClickDetector")
                        if cd then
                            table.insert(targets, {part = obj, cd = cd})
                        end
                    end
                end
            end
        end

        for i = 1, #targets do
            if not state then break end
            local data = targets[i]
            if data.part and data.cd then
                hrp.CFrame = data.part.CFrame + Vector3.new(0, 3, 0)
                fireclickdetector(data.cd)
                task.wait(0.15)
            end
        end
        task.wait()
    end
end)
Auto_Phone = LI:NewToggle("Auto Accept Phone", "Automatically accepts phone offer", function(state) -- I have NO idea if this works to be honest with you
    while state do
        local remote = workspace[findtycoon()].Remotes.PhoneOffer
        local arguments = {
            [1] = "Accept"
        }
        remote:FireServer(unpack(arguments))
        task.wait(.1)
    end
end)

-- Auto Buy
AB:NewToggle("Auto Upgrade Lemonade Stand", "Pretty self Explainatory", function (state)
    while state do
        local remote = workspace[findtycoon()].Purchases["Lemon Stand"]["Lemon Stand"]["Lemon Stand"].Upgrade
        local arguments = {
            [1] = 1
        }
        local results = remote:InvokeServer(unpack(arguments))
        task.wait(.1)
    end
end)
