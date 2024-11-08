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

local s=check(url)

if not s[1] then
	warn("Please run the server! Run the server and restart studio/close the place.")
	return
end

local StudioService=game:GetService('StudioService')

task.spawn(function()
	while task.wait(2) do
		players=game:GetService("Players"):GetPlayers()
		
		local pcount=0
		
		for _, z in players do
			pcount+=1
		end
		
		if pcount > 1 then
			state="Developing with a team"
		else
			state="Developing solo"
		end
		
		local activeScript = StudioService.ActiveScript
		if activeScript~=nil then
			local scriptType = activeScript.ClassName
			details=`Editing {scriptType} "{activeScript.Name}"`
			--update(image,	imageText,	details,	state,	url)
		else
			details="Developing a game :D"
		end
		
		update(image,	imageText,	details,	state,	url)
	end
end)
