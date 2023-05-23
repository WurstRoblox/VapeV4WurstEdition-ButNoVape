local function wurstGithubRequest(scripturl)
	if not isfile("wurst/"..scripturl) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/VapeV4WurstEdition-ButNoVape/"..readfile("wurst/commithash.txt").."/"..scripturl, true) end)
		if not suc or res == "404: Not Found" then return nil end
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("wurst/"..scripturl, res)
	end
	return readfile("wurst/"..scripturl)
end

shared.CustomSaveWurst = 292439477
if pcall(function() readfile("wurst/CustomModules/292439477.lua") end) then
	loadstring(readfile("wurst/CustomModules/292439477.lua"))()
else
	local publicrepo = wurstGithubRequest("CustomModules/292439477.lua")
	if publicrepo then
		loadstring(publicrepo)()
	end
end