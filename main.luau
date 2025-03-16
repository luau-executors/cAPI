local cAPI = {
    owner = "ella",
    version = "1.0.1"
}
table.freeze(cAPI)

print("Thank you for using the cAPI, currently running " .. cAPI.version)

loadstring(game:HttpGet("https://raw.githubusercontent.com/luau-executors/cAPI/refs/heads/main/getconnections.luau"))()

cenv = {}

for idx, con in next, getconnections(game:GetService("LogService").MessageOut) do
     con:Disable()
end
