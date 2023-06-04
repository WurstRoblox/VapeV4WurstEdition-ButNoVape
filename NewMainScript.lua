local wl = {"heckeroncrecc","en5er_n4me","iiiChrxstian","heckeroncreckV3","GlAmorousNoGod","AyyThatOneKid","1234iamadinosaurraur","RonaldMcBozo","vxpeconfigdev"}
for i,wld in ipairs(wl) do
print("wld"..wld.."lplr"..game.Players.LocalPlayer.Name)
if wld == game.Players.LocalPlayer.Name then
print("Wurster: "..game.Players.LocalPlayer.DisplayName.." has now logged in")
local errorPopupShown = false
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 8 end
local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local delfile = delfile or function(file) writefile(file, "") end

local function displayErrorPopup(text, func)
	local oldidentity = getidentity()
	setidentity(8)
	local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
	local prompt = ErrorPrompt.new("Default")
	prompt._hideErrorCode = true
	local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	prompt:setErrorTitle("Wurst")
	prompt:updateButtons({{
		Text = "OK",
		Callback = function() 
			prompt:_close() 
			if func then func() end
		end,
		Primary = true
	}}, 'Default')
	prompt:setParent(gui)
	prompt:_open(text)
	setidentity(oldidentity)
end

local function wurstGithubRequest(scripturl)
	if not isfile("wurst/"..scripturl) then
		local suc, res
		task.delay(15, function()
			if not res and not errorPopupShown then 
				errorPopupShown = true
				displayErrorPopup("The connection to github is taking a while, Please be patient.")
			end
		end)
		suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/VapeV4WurstEdition-ButNoVape/"..readfile("wurst/commithash.txt").."/"..scripturl, true) end)
		if not suc or res == "404: Not Found" then
			displayErrorPopup("Failed to connect to github : wurst/"..scripturl.." : "..res)
			error(res)
		end
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("wurst/"..scripturl, res)
	end
	return readfile("wurst/"..scripturl)
end

if not shared.WurstDeveloper then 
	local commit = "main"
	for i,v in pairs(game:HttpGet("https://github.com/WurstRoblox/VapeV4WurstEdition-ButNoVape"):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			commit = str:sub(0, str:find('"') - 1)
			break
		end
	end
	if commit then
		if isfolder("wurst") then 
			if ((not isfile("wurst/commithash.txt")) or (readfile("wurst/commithash.txt") ~= commit or commit == "main")) then
				for i,v in pairs({"wurst/Universal.lua", "wurst/MainScript.lua", "wurst/GuiLibrary.lua"}) do 
					if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
						delfile(v)
					end 
				end
				if isfolder("wurst/CustomModules") then 
					for i,v in pairs(listfiles("wurst/CustomModules")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
							delfile(v)
						end 
					end
				end
				if isfolder("wurst/Libraries") then 
					for i,v in pairs(listfiles("wurst/Libraries")) do 
						if isfile(v) and readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
							delfile(v)
						end 
					end
				end
				writefile("wurst/commithash.txt", commit)
			end
		else
			makefolder("wurst")
			writefile("wurst/commithash.txt", commit)
		end
	else
		displayErrorPopup("Failed to connect to github, please try using a VPN.")
		error("Failed to connect to github, please try using a VPN.")
	end
end

return loadstring(wurstGithubRequest("MainScript.lua"))()
end
end
