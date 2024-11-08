-- Roblox Module
export type preset = {
	details: string,
	state: string,
	largeImageKey: string,
	largeImageText: string
}

return function(image, imageText, details, state, URL)
	local presenceData: preset = {
		details = details,
		state = state,
		largeImageKey = image,
		largeImageText = imageText
	}
	
	local h=game:GetService('HttpService')
	
	h:PostAsync(URL, h:JSONEncode(presenceData), Enum.HttpContentType.ApplicationJson)
end
