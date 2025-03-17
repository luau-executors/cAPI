local API = {
    owner = "ella",
    version = "1.0.1",
    name = "cAPI"
}
table.freeze(API)

local HttpService = game:GetService("HttpService")


getgenv().DrawingLibrary = "https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/DrawingLib.luau"
getgenv().Animation = "https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/slideout.luau"

print("✅ Thank you for using the cAPI fork based on CloudyAPI, currently running " .. API.version)

loadstring(game:HttpGet(DrawingLibrary))()
loadstring(game:HttpGet(Animation))()

for idx, con in next, getconnections(game:GetService("LogService").MessageOut) do
     con:Disable()
end

queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/slideout.luau'))()")

--[[
    Custom Environment / Functions
]]

getgenv().cAPI = {}

getgenv().is_cAPI_closure = function(func)
    for _, v in pairs(cAPI) do
        if rawequal(v, func) then -- Use rawequal to prevent metatable issues
            return true
        end
    end
    return false
end

getgenv().cAPI.iy = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

getgenv().cAPI.SUNC = function()
    loadstring(game:HttpGet("https://gitlab.com/sens3/nebunu/-/raw/main/HummingBird8's_sUNC_yes_i_moved_to_gitlab_because_my_github_acc_got_brickedd/sUNCm0m3n7.lua"))()
end

getgenv().cAPI.Dex = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end

getgenv().identifyexecutor = function()
    return API.name, API.version
end

getgenv().whatexecutorname = identifyexecutor
getgenv().executorname = identifyexecutor

local oldr = request 
getgenv().request = function(options)
	if options.Headers then
		options.Headers["User-Agent"] = "cAPI/RobloxApp/2.1"
	else
		options.Headers = {["User-Agent"] = "cAPI/RobloxApp/2.1"}
	end
	local response = oldr(options)
	return response
end 

--[[
    Version Checking
]]

print("This instance is protected by " .. API.name, API.version)
