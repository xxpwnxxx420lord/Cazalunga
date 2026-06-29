local root: string = "pls enter raw link to repo here"
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

