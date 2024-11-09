-- an project that's easy to use

assert(plugin, "Please run this as a plugin")

local dm="http://localhost"

local port=3043

local url=`{dm}:{tostring(port)}/updatePresence`

local update=require(script.Parent.Modules.UpdatePresence)

local check=require(script.Parent.Modules.ServerPing)

local image="roblox_studio"

local details="Developing"

local state=""

local players=game:GetService("Players"):GetPlayers()

local imageText="Roblox Studio Logo"

local s=check(`{dm}:{tostring(port)}/`)

local suc=true

if not s[1] then
	suc=false
	warn("Please start the server, or allow the http requests")
end

repeat
	task.wait(2)
	local success=check(`{dm}:{tostring(port)}/`)
	if not success[1] then warn("Please start the server, or allow the http requests"); end
	suc=success[1]
until suc

local StudioService=game:GetService('StudioService')

task.spawn(function()
	while task.wait(2) do
		players=game:GetService("Players"):GetPlayers()
		
		local pcount=0
		
		for _, z in players do
			pcount+=1
		end
		
		if pcount > 1 then
			state="With a team: yes"
		else
			state="With a team: no"
		end
		
		local activeScript = StudioService.ActiveScript
		if activeScript~=nil then
			local scriptType = activeScript.ClassName
			details=`Editing {scriptType} "{activeScript.Name}"`
			--update(image,	imageText,	details,	state,	url)
		elseif game:GetService('RunService'):IsRunMode() then
			details="Testing the game."
		else
			details="Developing"
		end
		
		local success=update(image,	imageText,	details,	state,	url)
		
		if not success then
			warn("Failed to update presence. Please start the server, or allow the http requests.")
		end
	end
end)
