local cAPI = {
    owner = "ella",
    version = "1.0.1"
}
table.freeze(cAPI)

loadstring(game:HttpGet("https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/slideout.luau?token=GHSAT0AAAAAAC7BVHG25TLVUCKAOOEWTWZQZ6XJBMA"))()

print("Thank you for using the cAPI fork based on CloudyAPI, currently running " .. cAPI.version)

local libs = {
    {
        ['name'] = "Getconnections",
        ['url'] = "https://raw.githubusercontent.com/luau-executors/functions/refs/heads/main/getconnections.luau?token="
    }
}

local function load_library(lib_name)
    for _, lib in ipairs(libs) do
        if lib.name == lib_name then
            local response = request({ Url = lib.url, Method = "GET" })
            if response.Success then
                local func, err = loadstring(response.Body)
                if not func then
                    warn("Failed to load library " .. lib.name .. ": " .. err)
                end
                func()  -- Execute the library code
                return true  -- Indicate success
            else
                warn("Failed to fetch library " .. lib.name .. ": " .. response.StatusCode)
            end
        end
    end
    warn("Library not found: " .. lib_name)
end

load_library("Getconnections")

for idx, con in next, getconnections(game:GetService("LogService").MessageOut) do
     con:Disable()
end
