-- Roblox Module
return function(url)
	local z,s = pcall(function()
		game:GetService('HttpService'):GetAsync(url)
	end)
	
	if z then
		return {z}
	elseif not z then
		return {z,s}
	end
end
