local API = {
    owner = "ella",
    version = "1.0.1",
    name = "cAPI"
}
table.freeze(API)

local HttpService = game:GetService("HttpService")

local function try(fn, ...)
	return (pcall(fn, ...))
end

DrawingLibrary = "https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/DrawingLib.luau"
LoadingAnimation = "https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/slideout.luau"

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

getgenv().cAPI.iy = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

getgenv().cAPI.SUNC = function()
    loadstring(game:HttpGet("https://gitlab.com/sens3/nebunu/-/raw/main/HummingBird8's_sUNC_yes_i_moved_to_gitlab_because_my_github_acc_got_brickedd/sUNCm0m3n7.lua"))()
end

getgenv().cAPI.Dex = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end

getgenv().getapicredits = function()
	return "cAPI built by Ella, Sources used: MoreUNC functions, xAPI functions, Salad Functions"
end

--[[
	Identification
]]

getgenv().identifyexecutor = function()
    return API.name, API.version
end

getgenv().executorname = identifyexecutor
getgenv().whatexecutorname = identifyexecutor

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
	Http Stuff
]]


getgenv().httppost = function(URL, body, contenttype) 
    return game:HttpPostAsync(URL, body, contenttype)
end

--[[
	Important Stuff (do not change)
]]

getgenv().type_check = function(argument_position: number, value: any, allowed_types: {any}, optional: boolean?) --xAPI source
	local formatted_arguments = table.concat(allowed_types, " or ")

	if value == nil and not optional and not table.find(allowed_types, "nil") then
		error(("missing argument #%d (expected %s)"):format(argument_position, formatted_arguments), 0)
	elseif value == nil and optional == true then
		return value
	end

	if not (table.find(allowed_types, typeof(value)) or table.find(allowed_types, type(value)) or table.find(allowed_types, value)) and not table.find(allowed_types, "any") then
		error(("invalid argument #%d (expected %s, got %s)"):format(argument_position, formatted_arguments, typeof(value)), 0)
	end

	return value
end

getgenv().cclosure = function(f)
    return coroutine.wrap(function(...)
        while true do
            coroutine.yield(f(...))
        end
    end)
end

local function setreadonly(obj, value)
    local mt = getmetatable(obj)
    
    if mt and type(mt) == "table" then
        if value == true then
            mt.__oldindex = mt.__newindex
            mt.__newindex = cclosure(function() error("attempt to modify a readonly table", 0) end)
        else
            if mt.__oldindex then
                mt.__newindex = mt.__oldindex
                mt.__oldindex = nil
            elseif mt.__readonly then
                mt.__newindex = nil
                mt.__readonly = nil
            end
        end
    elseif not mt then
        setmetatable(obj, {
            __newindex = cclosure(function() error("attempt to modify a readonly table", 0) end),
            __readonly = true
        })
    else
        error("unable to safely freeze table")
    end
end

getgenv().getthreadidentity = function()
	local securityChecks = {
		{
			name = "None",
			number = 0,
			canAccess = try(function() return game.Name end)
		},
		{
			name = "PluginSecurity",
			number = 1,
			canAccess = try(function() return game:GetService("CoreGui").Name end)
		},
		{
			name = "LocalUserSecurity",
			number = 3,
			canAccess = try(function() return game.DataCost end)
		},
		{
			name = "WritePlayerSecurity",
			number = 4,
			canAccess = try(Instance.new, "Player")
		},
		{
			name = "RobloxScriptSecurity",
			number = 5,
			canAccess = try(function() return game:GetService("CorePackages").Name end)
		},
		{
			name = "RobloxSecurity",
			number = 6,
			canAccess = try(function() return Instance.new("SurfaceAppearance").TexturePack end)
		},
		{
			name = "NotAccessibleSecurity",
			number = 7,
			canAccess = try(function() Instance.new("MeshPart").MeshId = "" end)
		}
	}
	local lasti = 1
	for i = 1, #securityChecks do
		if securityChecks[i].canAccess then
			lasti = i
		else
			return lasti
		end
	end
	return lasti
end

--[[
    Version Checking
]]

print("This instance is protected by " .. API.name, API.version)
