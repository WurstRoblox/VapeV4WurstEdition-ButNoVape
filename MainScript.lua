repeat task.wait() until game:IsLoaded()
local GuiLibrary
local baseDirectory = (shared.WurstPrivate and "wurstprivate/" or "wurst/")
local wurstInjected = true
local oldRainbow = false
local errorPopupShown = false
local redownloadedAssets = false
local profilesLoaded = false
local teleportedServers = false
local gameCamera = workspace.CurrentCamera
local textService = game:GetService("TextService")
local playersService = game:GetService("Players")
local inputService = game:GetService("UserInputService")
local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 0 end
local wurstAssetTable = {
	["wurst/assets/AddItem.png"] = "rbxassetid://13350763121",
	["wurst/assets/AddRemoveIcon1.png"] = "rbxassetid://13350764147",
	["wurst/assets/ArrowIndicator.png"] = "rbxassetid://13350766521",
	["wurst/assets/BackIcon.png"] = "rbxassetid://13350767223",
	["wurst/assets/BindBackground.png"] = "rbxassetid://13350767577",
	["wurst/assets/BlatantIcon.png"] = "rbxassetid://13350767943",
	["wurst/assets/CircleListBlacklist.png"] = "rbxassetid://13350768647",
	["wurst/assets/CircleListWhitelist.png"] = "rbxassetid://13350769066",
	["wurst/assets/ColorSlider1.png"] = "rbxassetid://13350769439",
	["wurst/assets/ColorSlider2.png"] = "rbxassetid://13350769842",
	["wurst/assets/CombatIcon.png"] = "rbxassetid://13350770192",
	["wurst/assets/DownArrow.png"] = "rbxassetid://13350770749",
	["wurst/assets/ExitIcon1.png"] = "rbxassetid://13350771140",
	["wurst/assets/FriendsIcon.png"] = "rbxassetid://13350771464",
	["wurst/assets/HoverArrow.png"] = "rbxassetid://13350772201",
	["wurst/assets/HoverArrow2.png"] = "rbxassetid://13350772588",
	["wurst/assets/HoverArrow3.png"] = "rbxassetid://13350773014",
	["wurst/assets/HoverArrow4.png"] = "rbxassetid://13350773643",
	["wurst/assets/InfoNotification.png"] = "rbxassetid://13350774006",
	["wurst/assets/KeybindIcon.png"] = "rbxassetid://13350774323",
	["wurst/assets/LegitModeIcon.png"] = "rbxassetid://13436400428",
	["wurst/assets/MoreButton1.png"] = "rbxassetid://13350775005",
	["wurst/assets/MoreButton2.png"] = "rbxassetid://13350775731",
	["wurst/assets/MoreButton3.png"] = "rbxassetid://13350776241",
	["wurst/assets/NotificationBackground.png"] = "rbxassetid://13350776706",
	["wurst/assets/NotificationBar.png"] = "rbxassetid://13350777235",
	["wurst/assets/OnlineProfilesButton.png"] = "rbxassetid://13350777717",
	["wurst/assets/PencilIcon.png"] = "rbxassetid://13350778187",
	["wurst/assets/PinButton.png"] = "rbxassetid://13350778654",
	["wurst/assets/ProfilesIcon.png"] = "rbxassetid://13350779149",
	["wurst/assets/RadarIcon1.png"] = "rbxassetid://13350779545",
	["wurst/assets/RadarIcon2.png"] = "rbxassetid://13350779992",
	["wurst/assets/RainbowIcon1.png"] = "rbxassetid://13350780571",
	["wurst/assets/RainbowIcon2.png"] = "rbxassetid://13350780993",
	["wurst/assets/RightArrow.png"] = "rbxassetid://13350781908",
	["wurst/assets/SearchBarIcon.png"] = "rbxassetid://13350782420",
	["wurst/assets/SettingsWheel1.png"] = "rbxassetid://13350782848",
	["wurst/assets/SettingsWheel2.png"] = "rbxassetid://13350783258",
	["wurst/assets/SliderArrow1.png"] = "rbxassetid://13350783794",
	["wurst/assets/SliderArrowSeperator.png"] = "rbxassetid://13350784477",
	["wurst/assets/SliderButton1.png"] = "rbxassetid://13350785680",
	["wurst/assets/TargetIcon.png"] = "rbxassetid://13350786128",
	["wurst/assets/TargetIcon1.png"] = "rbxassetid://13350786776",
	["wurst/assets/TargetIcon2.png"] = "rbxassetid://13350787228",
	["wurst/assets/TargetIcon3.png"] = "rbxassetid://13350787729",
	["wurst/assets/TargetIcon4.png"] = "rbxassetid://13350788379",
	["wurst/assets/TargetInfoIcon1.png"] = "rbxassetid://13350788860",
	["wurst/assets/TargetInfoIcon2.png"] = "rbxassetid://13350789239",
	["wurst/assets/TextBoxBKG.png"] = "rbxassetid://13350789732",
	["wurst/assets/TextBoxBKG2.png"] = "rbxassetid://13350790229",
	["wurst/assets/TextGUIIcon1.png"] = "rbxassetid://13350790634",
	["wurst/assets/TextGUIIcon2.png"] = "rbxassetid://13350791175",
	["wurst/assets/TextGUIIcon3.png"] = "rbxassetid://13350791758",
	["wurst/assets/TextGUIIcon4.png"] = "rbxassetid://13350792279",
	["wurst/assets/ToggleArrow.png"] = "rbxassetid://13350792786",
	["wurst/assets/UpArrow.png"] = "rbxassetid://13350793386",
	["wurst/assets/UtilityIcon.png"] = "rbxassetid://13350793918",
	["wurst/assets/WarningNotification.png"] = "rbxassetid://13350794868",
	["wurst/assets/WindowBlur.png"] = "rbxassetid://13350795660",
	["wurst/assets/WorldIcon.png"] = "rbxassetid://13350796199",
	["wurst/assets/WurstIcon.png"] = "rbxassetid://13350808582",
	["wurst/assets/RenderIcon.png"] = "rbxassetid://13350832775",
	["wurst/assets/WurstLogo1.png"] = "rbxassetid://13471784136",
	["wurst/assets/WurstLogo3.png"] = "rbxassetid://13350872035",
	["wurst/assets/WurstLogo2.png"] = "rbxassetid://13350876307",
	["wurst/assets/WurstLogo4.png"] = "rbxassetid://13350877564"
}
if inputService:GetPlatform() ~= Enum.Platform.Windows then 
	--mobile exploit fix
	getgenv().getsynasset = nil
	getgenv().getcustomasset = nil
	-- why is this needed
	getsynasset = nil
	getcustomasset = nil
end
local getcustomasset = getsynasset or getcustomasset or function(location) return wurstAssetTable[location] or "" end
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local delfile = delfile or function(file) writefile(file, "") end

local function displayErrorPopup(text, funclist)
	local oldidentity = getidentity()
	setidentity(8)
	local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
	local prompt = ErrorPrompt.new("Default")
	prompt._hideErrorCode = true
	local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	prompt:setErrorTitle("Wurst")
	local funcs
	if funclist then 
		funcs = {}
		local num = 0
		for i,v in pairs(funclist) do 
			num = num + 1
			table.insert(funcs, {
				Text = i,
				Callback = function() 
					prompt:_close() 
					v()
				end,
				Primary = num == #funclist
			})
		end
	end
	prompt:updateButtons(funcs or {{
		Text = "OK",
		Callback = function() 
			prompt:_close() 
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

local function downloadWurstAsset(path)
	if not isfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary.MainGui
			repeat task.wait() until isfile(path)
			textlabel:Destroy()
		end)
		local suc, req = pcall(function() return wurstGithubRequest(path:gsub("wurst/assets", "assets")) end)
        if suc and req then
		    writefile(path, req)
        else
            return ""
        end
	end
	return getcustomasset(path) 
end

assert(not shared.WurstExecuted, "Wurst Already Injected")
shared.WurstExecuted = true

for i,v in pairs({baseDirectory:gsub("/", ""), "wurst", "wurst/Libraries", "wurst/CustomModules", "wurst/Profiles", baseDirectory.."Profiles", "wurst/assets"}) do 
	if not isfolder(v) then makefolder(v) end
end
task.spawn(function()
	local success, assetver = pcall(function() return wurstGithubRequest("assetsversion.txt") end)
	if not isfile("wurst/assetsversion.txt") then writefile("wurst/assetsversion.txt", "0") end
	if success and assetver > readfile("wurst/assetsversion.txt") then
		redownloadedAssets = true
		if isfolder("wurst/assets") and not shared.WurstDeveloper then
			if delfolder then
				delfolder("wurst/assets")
				makefolder("wurst/assets")
			end
		end
		writefile("wurst/assetsversion.txt", assetver)
	end
end)
if not isfile("wurst/CustomModules/cachechecked.txt") then
	local isNotCached = false
	for i,v in pairs({"wurst/Universal.lua", "wurst/MainScript.lua", "wurst/GuiLibrary.lua"}) do 
		if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
			isNotCached = true
		end 
	end
	if isfolder("wurst/CustomModules") then 
		for i,v in pairs(listfiles("wurst/CustomModules")) do 
			if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
				isNotCached = true
			end 
		end
	end
	if isNotCached and not shared.WurstDeveloper then
		displayErrorPopup("Wurst has detected uncached files, If you have CustomModules click no, else click yes.", {No = function() end, Yes = function()
			for i,v in pairs({"wurst/Universal.lua", "wurst/MainScript.lua", "wurst/GuiLibrary.lua"}) do 
				if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
					delfile(v)
				end 
			end
			for i,v in pairs(listfiles("wurst/CustomModules")) do 
				if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
					local last = v:split('\\')
					last = last[#last]
					local suc, publicrepo = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/VapeV4WurstEdition-ButNoVape/"..readfile("wurst/commithash.txt").."/CustomModules/"..last) end)
					if suc and publicrepo and publicrepo ~= "404: Not Found" then
						writefile("wurst/CustomModules/"..last, "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..publicrepo)
					end
				end 
			end
		end})
	end
	writefile("wurst/CustomModules/cachechecked.txt", "verified")
end

GuiLibrary = loadstring(wurstGithubRequest("GuiLibrary.lua"))()
shared.GuiLibrary = GuiLibrary

local saveSettingsLoop = coroutine.create(function()
	if inputService.TouchEnabled then return end
	repeat
		GuiLibrary.SaveSettings()
        task.wait(10)
	until not wurstInjected or not GuiLibrary
end)

task.spawn(function()
	local image = Instance.new("ImageLabel")
	image.Image = downloadWurstAsset("wurst/assets/CombatIcon.png")
	image.Position = UDim2.new()
	image.BackgroundTransparency = 1
	image.Size = UDim2.fromOffset(100, 100)
	image.ImageTransparency = 0.999
	image.Parent = GuiLibrary.MainGui
    image:GetPropertyChangedSignal("IsLoaded"):Connect(function()
        image:Destroy()
        image = nil
    end)
	task.spawn(function()
		task.wait(15)
		if image and image.ContentImageSize == Vector2.zero and (not errorPopupShown) and (not redownloadedAssets) and (not isfile("wurst/assets/check3.txt")) then 
            errorPopupShown = true
            displayErrorPopup("Assets failed to load, Try another executor (executor : "..(identifyexecutor and identifyexecutor() or "Unknown")..")", {OK = function()
                writefile("wurst/assets/check3.txt", "")
            end})
        end
	end)
end)

local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
	Name = "Combat", 
	Icon = "wurst/assets/CombatIcon.png", 
	IconSize = 15
})
local Blatant = GuiLibrary.CreateWindow({
	Name = "Blatant", 
	Icon = "wurst/assets/BlatantIcon.png", 
	IconSize = 16
})
local Render = GuiLibrary.CreateWindow({
	Name = "Render", 
	Icon = "wurst/assets/RenderIcon.png", 
	IconSize = 17
})
local Utility = GuiLibrary.CreateWindow({
	Name = "Utility", 
	Icon = "wurst/assets/UtilityIcon.png", 
	IconSize = 17
})
local World = GuiLibrary.CreateWindow({
	Name = "World", 
	Icon = "wurst/assets/WorldIcon.png", 
	IconSize = 16
})
local Friends = GuiLibrary.CreateWindow2({
	Name = "Friends", 
	Icon = "wurst/assets/FriendsIcon.png", 
	IconSize = 17
})
local Targets = GuiLibrary.CreateWindow2({
	Name = "Targets", 
	Icon = "wurst/assets/FriendsIcon.png", 
	IconSize = 17
})
local Profiles = GuiLibrary.CreateWindow2({
	Name = "Profiles", 
	Icon = "wurst/assets/ProfilesIcon.png", 
	IconSize = 19
})
GUI.CreateDivider()
GUI.CreateButton({
	Name = "Combat", 
	Function = function(callback) Combat.SetVisible(callback) end, 
	Icon = "wurst/assets/CombatIcon.png", 
	IconSize = 15
})
GUI.CreateButton({
	Name = "Blatant", 
	Function = function(callback) Blatant.SetVisible(callback) end, 
	Icon = "wurst/assets/BlatantIcon.png", 
	IconSize = 16
})
GUI.CreateButton({
	Name = "Render", 
	Function = function(callback) Render.SetVisible(callback) end, 
	Icon = "wurst/assets/RenderIcon.png", 
	IconSize = 17
})
GUI.CreateButton({
	Name = "Utility", 
	Function = function(callback) Utility.SetVisible(callback) end, 
	Icon = "wurst/assets/UtilityIcon.png", 
	IconSize = 17
})
GUI.CreateButton({
	Name = "World", 
	Function = function(callback) World.SetVisible(callback) end, 
	Icon = "wurst/assets/WorldIcon.png", 
	IconSize = 16
})
GUI.CreateDivider("MISC")
GUI.CreateButton({
	Name = "Friends", 
	Function = function(callback) Friends.SetVisible(callback) end, 
})
GUI.CreateButton({
	Name = "Targets", 
	Function = function(callback) Targets.SetVisible(callback) end, 
})
GUI.CreateButton({
	Name = "Profiles", 
	Function = function(callback) Profiles.SetVisible(callback) end, 
})

local FriendsTextListTable = {
	Name = "FriendsList", 
	TempText = "Username [Alias]", 
	Color = Color3.fromRGB(5, 133, 104)
}
local FriendsTextList = Friends.CreateCircleTextList(FriendsTextListTable)
FriendsTextList.FriendRefresh = Instance.new("BindableEvent")
FriendsTextList.FriendColorRefresh = Instance.new("BindableEvent")
local TargetsTextList = Targets.CreateCircleTextList({
	Name = "TargetsList", 
	TempText = "Username [Alias]", 
	Color = Color3.fromRGB(5, 133, 104)
})
local oldFriendRefresh = FriendsTextList.RefreshValues
FriendsTextList.RefreshValues = function(...)
	FriendsTextList.FriendRefresh:Fire()
	return oldFriendRefresh(...)
end
local oldTargetRefresh = TargetsTextList.RefreshValues
TargetsTextList.RefreshValues = function(...)
	FriendsTextList.FriendRefresh:Fire()
	return oldTargetRefresh(...)
end
Friends.CreateToggle({
	Name = "Use Friends",
	Function = function(callback) 
		FriendsTextList.FriendRefresh:Fire()
	end,
	Default = true
})
Friends.CreateToggle({
	Name = "Use Alias",
	Function = function(callback) end,
	Default = true,
})
Friends.CreateToggle({
	Name = "Spoof alias",
	Function = function(callback) end,
})
local friendRecolorToggle = Friends.CreateToggle({
	Name = "Recolor visuals",
	Function = function(callback) FriendsTextList.FriendColorRefresh:Fire() end,
	Default = true
})
local friendWindowFrame
Friends.CreateColorSlider({
	Name = "Friends Color", 
	Function = function(h, s, v) 
		local cachedColor = Color3.fromHSV(h, s, v)
		local addCircle = FriendsTextList.Object:FindFirstChild("AddButton", true)
		if addCircle then 
			addCircle.ImageColor3 = cachedColor
		end
		friendWindowFrame = friendWindowFrame or FriendsTextList.ScrollingObject and FriendsTextList.ScrollingObject:FindFirstChild("ScrollingFrame")
		if friendWindowFrame then 
			for i,v in pairs(friendWindowFrame:GetChildren()) do 
				local friendCircle = v:FindFirstChild("FriendCircle")
				local friendText = v:FindFirstChild("ItemText")
				if friendCircle and friendText then 
					friendCircle.BackgroundColor3 = friendText.TextColor3 == Color3.fromRGB(160, 160, 160) and cachedColor or friendCircle.BackgroundColor3
				end
			end
		end
		FriendsTextListTable.Color = cachedColor
		if friendRecolorToggle.Enabled then
			FriendsTextList.FriendColorRefresh:Fire()
		end
	end
})
local ProfilesTextList = {RefreshValues = function() end}
ProfilesTextList = Profiles.CreateTextList({
	Name = "ProfilesList",
	TempText = "Type name", 
	NoSave = true,
	AddFunction = function(profileName)
		GuiLibrary.Profiles[profileName] = {Keybind = "", Selected = false}
		local profiles = {}
		for i,v in pairs(GuiLibrary.Profiles) do 
			table.insert(profiles, i)
		end
		table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
		ProfilesTextList.RefreshValues(profiles)
	end, 
	RemoveFunction = function(profileIndex, profileName) 
		if profileName ~= "default" and profileName ~= GuiLibrary.CurrentProfile then 
			pcall(function() delfile(baseDirectory.."Profiles/"..profileName..(shared.CustomSaveWurst or game.PlaceId)..".wurstprofile.txt") end)
			GuiLibrary.Profiles[profileName] = nil
		else
			table.insert(ProfilesTextList.ObjectList, profileName)
			ProfilesTextList.RefreshValues(ProfilesTextList.ObjectList)
		end
	end, 
	CustomFunction = function(profileObject, profileName) 
		if GuiLibrary.Profiles[profileName] == nil then
			GuiLibrary.Profiles[profileName] = {Keybind = ""}
		end
		profileObject.MouseButton1Click:Connect(function()
			GuiLibrary.SwitchProfile(profileName)
		end)
		local newsize = UDim2.new(0, 20, 0, 21)
		local bindbkg = Instance.new("TextButton")
		bindbkg.Text = ""
		bindbkg.AutoButtonColor = false
		bindbkg.Size = UDim2.new(0, 20, 0, 21)
		bindbkg.Position = UDim2.new(1, -50, 0, 6)
		bindbkg.BorderSizePixel = 0
		bindbkg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindbkg.BackgroundTransparency = 0.95
		bindbkg.Visible = GuiLibrary.Profiles[profileName].Keybind ~= ""
		bindbkg.Parent = profileObject
		local bindimg = Instance.new("ImageLabel")
		bindimg.Image = downloadWurstAsset("wurst/assets/KeybindIcon.png")
		bindimg.BackgroundTransparency = 1
		bindimg.Size = UDim2.new(0, 12, 0, 12)
		bindimg.Position = UDim2.new(0, 4, 0, 5)
		bindimg.ImageTransparency = 0.2
		bindimg.Active = false
		bindimg.Visible = (GuiLibrary.Profiles[profileName].Keybind == "")
		bindimg.Parent = bindbkg
		local bindtext = Instance.new("TextLabel")
		bindtext.Active = false
		bindtext.BackgroundTransparency = 1
		bindtext.TextSize = 16
		bindtext.Parent = bindbkg
		bindtext.Font = Enum.Font.SourceSans
		bindtext.Size = UDim2.new(1, 0, 1, 0)
		bindtext.TextColor3 = Color3.fromRGB(85, 85, 85)
		bindtext.Visible = (GuiLibrary.Profiles[profileName].Keybind ~= "")
		local bindtext2 = Instance.new("TextLabel")
		bindtext2.Text = "PRESS A KEY TO BIND"
		bindtext2.Size = UDim2.new(0, 150, 0, 33)
		bindtext2.Font = Enum.Font.SourceSans
		bindtext2.TextSize = 17
		bindtext2.TextColor3 = Color3.fromRGB(201, 201, 201)
		bindtext2.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
		bindtext2.BorderSizePixel = 0
		bindtext2.Visible = false
		bindtext2.Parent = profileObject
		local bindround = Instance.new("UICorner")
		bindround.CornerRadius = UDim.new(0, 4)
		bindround.Parent = bindbkg
		bindbkg.MouseButton1Click:Connect(function()
			if not GuiLibrary.KeybindCaptured then
				GuiLibrary.KeybindCaptured = true
				task.spawn(function()
					bindtext2.Visible = true
					repeat task.wait() until GuiLibrary.PressedKeybindKey ~= ""
					local key = (GuiLibrary.PressedKeybindKey == GuiLibrary.Profiles[profileName].Keybind and "" or GuiLibrary.PressedKeybindKey)
					if key == "" then
						GuiLibrary.Profiles[profileName].Keybind = key
						newsize = UDim2.new(0, 20, 0, 21)
						bindbkg.Size = newsize
						bindbkg.Visible = true
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = true
						bindtext.Visible = false
						bindtext.Text = key
					else
						local textsize = textService:GetTextSize(key, 16, bindtext.Font, Vector2.new(99999, 99999))
						newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
						GuiLibrary.Profiles[profileName].Keybind = key
						bindbkg.Visible = true
						bindbkg.Size = newsize
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = false
						bindtext.Visible = true
						bindtext.Text = key
					end
					GuiLibrary.PressedKeybindKey = ""
					GuiLibrary.KeybindCaptured = false
					bindtext2.Visible = false
				end)
			end
		end)
		bindbkg.MouseEnter:Connect(function() 
			bindimg.Image = downloadWurstAsset("wurst/assets/PencilIcon.png") 
			bindimg.Visible = true
			bindtext.Visible = false
			bindbkg.Size = UDim2.new(0, 20, 0, 21)
			bindbkg.Position = UDim2.new(1, -50, 0, 6)
		end)
		bindbkg.MouseLeave:Connect(function() 
			bindimg.Image = downloadWurstAsset("wurst/assets/KeybindIcon.png")
			if GuiLibrary.Profiles[profileName].Keybind ~= "" then
				bindimg.Visible = false
				bindtext.Visible = true
				bindbkg.Size = newsize
				bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
			end
		end)
		profileObject.MouseEnter:Connect(function()
			bindbkg.Visible = true
		end)
		profileObject.MouseLeave:Connect(function()
			bindbkg.Visible = GuiLibrary.Profiles[profileName] and GuiLibrary.Profiles[profileName].Keybind ~= ""
		end)
		if GuiLibrary.Profiles[profileName].Keybind ~= "" then
			bindtext.Text = GuiLibrary.Profiles[profileName].Keybind
			local textsize = textService:GetTextSize(GuiLibrary.Profiles[profileName].Keybind, 16, bindtext.Font, Vector2.new(99999, 99999))
			newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
			bindbkg.Size = newsize
			bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
		end
		if profileName == GuiLibrary.CurrentProfile then
			profileObject.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
			profileObject.ImageButton.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
			profileObject.ItemText.TextColor3 = Color3.new(1, 1, 1)
			profileObject.ItemText.TextStrokeTransparency = 0.75
			bindbkg.BackgroundTransparency = 0.9
			bindtext.TextColor3 = Color3.fromRGB(214, 214, 214)
		end
	end
})

local OnlineProfilesButton = Instance.new("TextButton")
OnlineProfilesButton.Name = "OnlineProfilesButton"
OnlineProfilesButton.LayoutOrder = 1
OnlineProfilesButton.AutoButtonColor = false
OnlineProfilesButton.Size = UDim2.new(0, 45, 0, 29)
OnlineProfilesButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesButton.Active = false
OnlineProfilesButton.Text = ""
OnlineProfilesButton.ZIndex = 1
OnlineProfilesButton.Font = Enum.Font.SourceSans
OnlineProfilesButton.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesButton.Position = UDim2.new(0, 166, 0, 6)
OnlineProfilesButton.Parent = ProfilesTextList.Object
local OnlineProfilesButtonBKG = Instance.new("UIStroke")
OnlineProfilesButtonBKG.Color = Color3.fromRGB(38, 37, 38)
OnlineProfilesButtonBKG.Thickness = 1
OnlineProfilesButtonBKG.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OnlineProfilesButtonBKG.Parent = OnlineProfilesButton
local OnlineProfilesButtonImage = Instance.new("ImageLabel")
OnlineProfilesButtonImage.BackgroundTransparency = 1
OnlineProfilesButtonImage.Position = UDim2.new(0, 14, 0, 7)
OnlineProfilesButtonImage.Size = UDim2.new(0, 17, 0, 16)
OnlineProfilesButtonImage.Image = downloadWurstAsset("wurst/assets/OnlineProfilesButton.png")
OnlineProfilesButtonImage.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesButtonImage.ZIndex = 1
OnlineProfilesButtonImage.Active = false
OnlineProfilesButtonImage.Parent = OnlineProfilesButton
local OnlineProfilesbuttonround1 = Instance.new("UICorner")
OnlineProfilesbuttonround1.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonround1.Parent = OnlineProfilesButton
local OnlineProfilesbuttonTargetInfoMainInfoCorner = Instance.new("UICorner")
OnlineProfilesbuttonTargetInfoMainInfoCorner.CornerRadius = UDim.new(0, 5)
OnlineProfilesbuttonTargetInfoMainInfoCorner.Parent = OnlineProfilesButtonBKG
local OnlineProfilesFrame = Instance.new("Frame")
OnlineProfilesFrame.Size = UDim2.new(0, 660, 0, 445)
OnlineProfilesFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
OnlineProfilesFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesFrame.Parent = GuiLibrary.MainGui.ScaledGui.OnlineProfiles
local OnlineProfilesExitButton = Instance.new("ImageButton")
OnlineProfilesExitButton.Name = "OnlineProfilesExitButton"
OnlineProfilesExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
OnlineProfilesExitButton.Size = UDim2.new(0, 24, 0, 24)
OnlineProfilesExitButton.AutoButtonColor = false
OnlineProfilesExitButton.Image = downloadWurstAsset("wurst/assets/ExitIcon1.png")
OnlineProfilesExitButton.Visible = true
OnlineProfilesExitButton.Position = UDim2.new(1, -31, 0, 8)
OnlineProfilesExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
OnlineProfilesExitButton.Parent = OnlineProfilesFrame
local OnlineProfilesExitButtonround = Instance.new("UICorner")
OnlineProfilesExitButtonround.CornerRadius = UDim.new(0, 16)
OnlineProfilesExitButtonround.Parent = OnlineProfilesExitButton
OnlineProfilesExitButton.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
OnlineProfilesExitButton.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(OnlineProfilesExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
end)
local OnlineProfilesFrameShadow = Instance.new("ImageLabel")
OnlineProfilesFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
OnlineProfilesFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
OnlineProfilesFrameShadow.Image = downloadWurstAsset("wurst/assets/WindowBlur.png")
OnlineProfilesFrameShadow.BackgroundTransparency = 1
OnlineProfilesFrameShadow.ZIndex = -1
OnlineProfilesFrameShadow.Size = UDim2.new(1, 6, 1, 6)
OnlineProfilesFrameShadow.ImageColor3 = Color3.new()
OnlineProfilesFrameShadow.ScaleType = Enum.ScaleType.Slice
OnlineProfilesFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
OnlineProfilesFrameShadow.Parent = OnlineProfilesFrame
local OnlineProfilesFrameIcon = Instance.new("ImageLabel")
OnlineProfilesFrameIcon.Size = UDim2.new(0, 19, 0, 16)
OnlineProfilesFrameIcon.Image = downloadWurstAsset("wurst/assets/ProfilesIcon.png")
OnlineProfilesFrameIcon.Name = "WindowIcon"
OnlineProfilesFrameIcon.BackgroundTransparency = 1
OnlineProfilesFrameIcon.Position = UDim2.new(0, 10, 0, 13)
OnlineProfilesFrameIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
OnlineProfilesFrameIcon.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText = Instance.new("TextLabel")
OnlineProfilesFrameText.Size = UDim2.new(0, 155, 0, 41)
OnlineProfilesFrameText.BackgroundTransparency = 1
OnlineProfilesFrameText.Name = "WindowTitle"
OnlineProfilesFrameText.Position = UDim2.new(0, 36, 0, 0)
OnlineProfilesFrameText.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText.Font = Enum.Font.SourceSans
OnlineProfilesFrameText.TextSize = 17
OnlineProfilesFrameText.Text = "Public Profiles"
OnlineProfilesFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
OnlineProfilesFrameText.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText2 = Instance.new("TextLabel")
OnlineProfilesFrameText2.TextSize = 15
OnlineProfilesFrameText2.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText2.Text = "YOUR PROFILES"
OnlineProfilesFrameText2.Font = Enum.Font.SourceSans
OnlineProfilesFrameText2.BackgroundTransparency = 1
OnlineProfilesFrameText2.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText2.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText2.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText2.Position = UDim2.new(0, 10, 0, 48)
OnlineProfilesFrameText2.Parent = OnlineProfilesFrame
local OnlineProfilesFrameText3 = Instance.new("TextLabel")
OnlineProfilesFrameText3.TextSize = 15
OnlineProfilesFrameText3.TextColor3 = Color3.fromRGB(85, 84, 85)
OnlineProfilesFrameText3.Text = "PUBLIC PROFILES"
OnlineProfilesFrameText3.Font = Enum.Font.SourceSans
OnlineProfilesFrameText3.BackgroundTransparency = 1
OnlineProfilesFrameText3.TextXAlignment = Enum.TextXAlignment.Left
OnlineProfilesFrameText3.TextYAlignment = Enum.TextYAlignment.Top
OnlineProfilesFrameText3.Size = UDim2.new(1, 0, 0, 20)
OnlineProfilesFrameText3.Position = UDim2.new(0, 231, 0, 48)
OnlineProfilesFrameText3.Parent = OnlineProfilesFrame
local OnlineProfilesBorder1 = Instance.new("Frame")
OnlineProfilesBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder1.BorderSizePixel = 0
OnlineProfilesBorder1.Size = UDim2.new(1, 0, 0, 1)
OnlineProfilesBorder1.Position = UDim2.new(0, 0, 0, 41)
OnlineProfilesBorder1.Parent = OnlineProfilesFrame
local OnlineProfilesBorder2 = Instance.new("Frame")
OnlineProfilesBorder2.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
OnlineProfilesBorder2.BorderSizePixel = 0
OnlineProfilesBorder2.Size = UDim2.new(0, 1, 1, -41)
OnlineProfilesBorder2.Position = UDim2.new(0, 220, 0, 41)
OnlineProfilesBorder2.Parent = OnlineProfilesFrame
local OnlineProfilesList = Instance.new("ScrollingFrame")
OnlineProfilesList.BackgroundTransparency = 1
OnlineProfilesList.Size = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Position = UDim2.new(0, 230, 0, 122)
OnlineProfilesList.CanvasSize = UDim2.new(0, 408, 0, 319)
OnlineProfilesList.Parent = OnlineProfilesFrame
local OnlineProfilesListGrid = Instance.new("UIGridLayout")
OnlineProfilesListGrid.CellSize = UDim2.new(0, 134, 0, 144)
OnlineProfilesListGrid.CellPadding = UDim2.new(0, 4, 0, 4)
OnlineProfilesListGrid.Parent = OnlineProfilesList
local OnlineProfilesFrameCorner = Instance.new("UICorner")
OnlineProfilesFrameCorner.CornerRadius = UDim.new(0, 4)
OnlineProfilesFrameCorner.Parent = OnlineProfilesFrame
OnlineProfilesButton.MouseButton1Click:Connect(function()
	GuiLibrary.MainGui.ScaledGui.OnlineProfiles.Visible = true
	GuiLibrary.MainGui.ScaledGui.ClickGui.Visible = false
	if not profilesLoaded then
		local onlineprofiles = {}
		local saveplaceid = tostring(shared.CustomSaveWurst or game.PlaceId)
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/WurstPedofiles/main/Profiles/"..saveplaceid.."/profilelist.txt", true))
        end)
		for i,v in pairs(success and result or {}) do 
			onlineprofiles[i] = v
		end
		for i2,v2 in pairs(onlineprofiles) do
			local profileurl = "https://raw.githubusercontent.com/WurstRoblox/WurstPedofiles/main/Profiles/"..saveplaceid.."/"..v2.OnlineProfileName
			local profilebox = Instance.new("Frame")
			profilebox.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profilebox.Parent = OnlineProfilesList
			local profiletext = Instance.new("TextLabel")
			profiletext.TextSize = 15
			profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
			profiletext.Size = UDim2.new(0, 100, 0, 20)
			profiletext.Position = UDim2.new(0, 18, 0, 25)
			profiletext.Font = Enum.Font.SourceSans
			profiletext.TextXAlignment = Enum.TextXAlignment.Left
			profiletext.TextYAlignment = Enum.TextYAlignment.Top
			profiletext.BackgroundTransparency = 1
			profiletext.Text = i2
			profiletext.Parent = profilebox
			local profiledownload = Instance.new("TextButton")
			profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			profiledownload.Size = UDim2.new(0, 69, 0, 31)
			profiledownload.Font = Enum.Font.SourceSans
			profiledownload.TextColor3 = Color3.fromRGB(200, 200, 200)
			profiledownload.TextSize = 15
			profiledownload.AutoButtonColor = false
			profiledownload.Text = "DOWNLOAD"
			profiledownload.Position = UDim2.new(0, 14, 0, 96)
			profiledownload.Visible = false 
			profiledownload.Parent = profilebox
			profiledownload.ZIndex = 2
			local profiledownloadbkg = Instance.new("Frame")
			profiledownloadbkg.Size = UDim2.new(0, 71, 0, 33)
			profiledownloadbkg.BackgroundColor3 = Color3.fromRGB(42, 41, 42)
			profiledownloadbkg.Position = UDim2.new(0, 13, 0, 95)
			profiledownloadbkg.ZIndex = 1
			profiledownloadbkg.Visible = false
			profiledownloadbkg.Parent = profilebox
			profilebox.MouseEnter:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(200, 200, 200)
				profiledownload.Visible = true 
				profiledownloadbkg.Visible = true
			end)
			profilebox.MouseLeave:Connect(function()
				profiletext.TextColor3 = Color3.fromRGB(137, 136, 137)
				profiledownload.Visible = false
				profiledownloadbkg.Visible = false
			end)
			profiledownload.MouseEnter:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(5, 134, 105)
			end)
			profiledownload.MouseLeave:Connect(function()
				profiledownload.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			end)
			profiledownload.MouseButton1Click:Connect(function()
				writefile(baseDirectory.."Profiles/"..v2.ProfileName..saveplaceid..".wurstprofile.txt", game:HttpGet(profileurl, true))
				GuiLibrary.Profiles[v2.ProfileName] = {Keybind = "", Selected = false}
				local profiles = {}
				for i,v in pairs(GuiLibrary.Profiles) do 
					table.insert(profiles, i)
				end
				table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
				ProfilesTextList.RefreshValues(profiles)
			end)
			local profileround = Instance.new("UICorner")
			profileround.CornerRadius = UDim.new(0, 4)
			profileround.Parent = profilebox
			local profileTargetInfoMainInfoCorner = Instance.new("UICorner")
			profileTargetInfoMainInfoCorner.CornerRadius = UDim.new(0, 4)
			profileTargetInfoMainInfoCorner.Parent = profiledownload
			local profileTargetInfoHealthBackgroundCorner = Instance.new("UICorner")
			profileTargetInfoHealthBackgroundCorner.CornerRadius = UDim.new(0, 4)
			profileTargetInfoHealthBackgroundCorner.Parent = profiledownloadbkg
		end
		profilesloaded = true
	end
end)
OnlineProfilesExitButton.MouseButton1Click:Connect(function()
	GuiLibrary.MainGui.ScaledGui.OnlineProfiles.Visible = false
	GuiLibrary.MainGui.ScaledGui.ClickGui.Visible = true
end)
GUI.CreateDivider()

local TextGUI = GuiLibrary.CreateCustomWindow({
	Name = "Text GUI", 
	Icon = "wurst/assets/TextGUIIcon1.png", 
	IconSize = 21
})
local TextGUICircleObject = {CircleList = {}}
GUI.CreateCustomToggle({
	Name = "Text GUI", 
	Icon = "wurst/assets/TextGUIIcon3.png",
	Function = function(callback) TextGUI.SetVisible(callback) end,
	Priority = 2
})	
local GUIColorSlider = {RainbowValue = false}
local TextGUIMode = {Value = "Normal"}
local TextGUISortMode = {Value = "Alphabetical"}
local TextGUIBackgroundToggle = {Enabled = false}
local TextGUIObjects = {Logo = {}, Labels = {}, ShadowLabels = {}, Backgrounds = {}}
local TextGUIConnections = {}
local TextGUIFormatted = {}
local WurstLogoFrame = Instance.new("Frame")
WurstLogoFrame.BackgroundTransparency = 1
WurstLogoFrame.Size = UDim2.new(1, 0, 1, 0)
WurstLogoFrame.Parent = TextGUI.GetCustomChildren()
local WurstLogo = Instance.new("ImageLabel")
WurstLogo.Parent = WurstLogoFrame
WurstLogo.Name = "Logo"
WurstLogo.Size = UDim2.new(0, 100, 0, 27)
WurstLogo.Position = UDim2.new(1, -140, 0, 3)
WurstLogo.BackgroundColor3 = Color3.new()
WurstLogo.BorderSizePixel = 0
WurstLogo.BackgroundTransparency = 1
WurstLogo.Visible = true
WurstLogo.Image = downloadWurstAsset("wurst/assets/WurstLogo3.png")
local WurstLogoV4 = Instance.new("ImageLabel")
WurstLogoV4.Parent = WurstLogo
WurstLogoV4.Size = UDim2.new(0, 41, 0, 24)
WurstLogoV4.Name = "Logo2"
WurstLogoV4.Position = UDim2.new(1, 0, 0, 1)
WurstLogoV4.BorderSizePixel = 0
WurstLogoV4.BackgroundColor3 = Color3.new()
WurstLogoV4.BackgroundTransparency = 1
WurstLogoV4.Image = downloadWurstAsset("wurst/assets/WurstLogo4.png")
local WurstLogoShadow = WurstLogo:Clone()
WurstLogoShadow.ImageColor3 = Color3.new()
WurstLogoShadow.ImageTransparency = 0.5
WurstLogoShadow.ZIndex = 0
WurstLogoShadow.Position = UDim2.new(0, 1, 0, 1)
WurstLogoShadow.Visible = false
WurstLogoShadow.Parent = WurstLogo
WurstLogoShadow.Logo2.ImageColor3 = Color3.new()
WurstLogoShadow.Logo2.ZIndex = 0
WurstLogoShadow.Logo2.ImageTransparency = 0.5
local WurstLogoGradient = Instance.new("UIGradient")
WurstLogoGradient.Rotation = 90
WurstLogoGradient.Parent = WurstLogo
local WurstLogoGradient2 = Instance.new("UIGradient")
WurstLogoGradient2.Rotation = 90
WurstLogoGradient2.Parent = WurstLogoV4
local WurstText = Instance.new("TextLabel")
WurstText.Parent = WurstLogoFrame
WurstText.Size = UDim2.new(1, 0, 1, 0)
WurstText.Position = UDim2.new(1, -154, 0, 35)
WurstText.TextColor3 = Color3.new(1, 1, 1)
WurstText.RichText = true
WurstText.BackgroundTransparency = 1
WurstText.TextXAlignment = Enum.TextXAlignment.Left
WurstText.TextYAlignment = Enum.TextYAlignment.Top
WurstText.BorderSizePixel = 0
WurstText.BackgroundColor3 = Color3.new()
WurstText.Font = Enum.Font.SourceSans
WurstText.Text = ""
WurstText.TextSize = 23
local WurstTextExtra = Instance.new("TextLabel")
WurstTextExtra.Name = "ExtraText"
WurstTextExtra.Parent = WurstText
WurstTextExtra.Size = UDim2.new(1, 0, 1, 0)
WurstTextExtra.Position = UDim2.new(0, 1, 0, 1)
WurstTextExtra.BorderSizePixel = 0
WurstTextExtra.Visible = false
WurstTextExtra.ZIndex = 0
WurstTextExtra.Text = ""
WurstTextExtra.BackgroundTransparency = 1
WurstTextExtra.TextTransparency = 0.5
WurstTextExtra.TextXAlignment = Enum.TextXAlignment.Left
WurstTextExtra.TextYAlignment = Enum.TextYAlignment.Top
WurstTextExtra.TextColor3 = Color3.new()
WurstTextExtra.Font = Enum.Font.SourceSans
WurstTextExtra.TextSize = 23
local WurstCustomText = Instance.new("TextLabel")
WurstCustomText.TextSize = 30
WurstCustomText.Font = Enum.Font.GothamBold
WurstCustomText.Size = UDim2.new(1, 0, 1, 0)
WurstCustomText.BackgroundTransparency = 1
WurstCustomText.Position = UDim2.new(0, 0, 0, 35)
WurstCustomText.TextXAlignment = Enum.TextXAlignment.Left
WurstCustomText.TextYAlignment = Enum.TextYAlignment.Top
WurstCustomText.Text = ""
WurstCustomText.Parent = WurstLogoFrame
local WurstCustomTextShadow = WurstCustomText:Clone()
WurstCustomTextShadow.ZIndex = -1
WurstCustomTextShadow.Size = UDim2.new(1, 0, 1, 0)
WurstCustomTextShadow.TextTransparency = 0.5
WurstCustomTextShadow.TextColor3 = Color3.new()
WurstCustomTextShadow.Position = UDim2.new(0, 1, 0, 1)
WurstCustomTextShadow.Parent = WurstCustomText
WurstCustomText:GetPropertyChangedSignal("TextXAlignment"):Connect(function()
	WurstCustomTextShadow.TextXAlignment = WurstCustomText.TextXAlignment
end)
local WurstBackground = Instance.new("Frame")
WurstBackground.BackgroundTransparency = 1
WurstBackground.BorderSizePixel = 0
WurstBackground.BackgroundColor3 = Color3.new()
WurstBackground.Size = UDim2.new(1, 0, 1, 0)
WurstBackground.Visible = false 
WurstBackground.Parent = WurstLogoFrame
WurstBackground.ZIndex = 0
local WurstBackgroundList = Instance.new("UIListLayout")
WurstBackgroundList.FillDirection = Enum.FillDirection.Vertical
WurstBackgroundList.SortOrder = Enum.SortOrder.LayoutOrder
WurstBackgroundList.Padding = UDim.new(0, 0)
WurstBackgroundList.Parent = WurstBackground
local WurstBackgroundTable = {}
local WurstScale = Instance.new("UIScale")
WurstScale.Parent = WurstLogoFrame
--why do other platforms do rendering differently
local TextGUIOffsets = {
	[Enum.Platform.Android] = {
		6,
		-10,
		15,
		12
	},
	[Enum.Platform.UWP] = {
		1,
		1,
		23,
		23
	}
}
TextGUIOffsets[Enum.Platform.IOS] = TextGUIOffsets[Enum.Platform.Android]
local function TextGUIUpdate()
	local scaledgui = wurstInjected and GuiLibrary.MainGui.ScaledGui
	if scaledgui and scaledgui.Visible then
		local formattedText = ""
		local moduleList = {}

		for i, v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
			if v.Type == "OptionsButton" and v.Api.Enabled then
                local blacklistedCheck = table.find(TextGUICircleObject.CircleList.ObjectList, v.Api.Name)
                blacklistedCheck = blacklistedCheck and TextGUICircleObject.CircleList.ObjectList[blacklistedCheck]
                if not blacklistedCheck then
					local extraText = v.Api.GetExtraText()
                    table.insert(moduleList, {Text = v.Api.Name, ExtraText = extraText ~= "" and " "..extraText or ""})
                end
			end
		end

		if TextGUISortMode.Value == "Alphabetical" then
			table.sort(moduleList, function(a, b) return a.Text:lower() < b.Text:lower() end)
		else
			table.sort(moduleList, function(a, b) 
				return textService:GetTextSize(a.Text..a.ExtraText, WurstText.TextSize, WurstText.Font, Vector2.new(1000000, 1000000)).X > textService:GetTextSize(b.Text..b.ExtraText, WurstText.TextSize, WurstText.Font, Vector2.new(1000000, 1000000)).X 
			end)
		end

		local backgroundList = {}
		local first = true
		for i, v in pairs(moduleList) do
            local newEntryText = v.Text..v.ExtraText
			if first then
				formattedText = "\n"..newEntryText
				first = false
			else
				formattedText = formattedText..'\n'..newEntryText
			end
			table.insert(backgroundList, newEntryText)
		end

		TextGUIFormatted = moduleList
		WurstTextExtra.Text = formattedText
        WurstText.Size = UDim2.fromOffset(154, (formattedText ~= "" and textService:GetTextSize(formattedText, WurstText.TextSize, WurstText.Font, Vector2.new(1000000, 1000000)) or Vector2.zero).Y)

		local offsets = TextGUIOffsets[inputService:GetPlatform()] or {
			5,
			1,
			23,
			23
		}
        if TextGUI.GetCustomChildren().Parent then
            if (TextGUI.GetCustomChildren().Parent.Position.X.Offset + TextGUI.GetCustomChildren().Parent.Size.X.Offset / 2) >= (gameCamera.ViewportSize.X / 2) then
                WurstText.TextXAlignment = Enum.TextXAlignment.Right
                WurstTextExtra.TextXAlignment = Enum.TextXAlignment.Right
                WurstTextExtra.Position = UDim2.fromOffset(offsets[1], offsets[2])
                WurstLogo.Position = UDim2.new(1, -142, 0, 8)
                WurstText.Position = UDim2.new(1, -158, 0, (WurstLogo.Visible and (TextGUIBackgroundToggle.Enabled and 41 or 35) or 5) + (WurstCustomText.Visible and 25 or 0) - offsets[3])
                WurstCustomText.Position = UDim2.fromOffset(0, WurstLogo.Visible and 35 or 0)
                WurstCustomText.TextXAlignment = Enum.TextXAlignment.Right
                WurstBackgroundList.HorizontalAlignment = Enum.HorizontalAlignment.Right
                WurstBackground.Position = WurstText.Position + UDim2.fromOffset(-56, 2 + offsets[4])
            else
                WurstText.TextXAlignment = Enum.TextXAlignment.Left
                WurstTextExtra.TextXAlignment = Enum.TextXAlignment.Left
                WurstTextExtra.Position = UDim2.fromOffset(offsets[1], offsets[2])
                WurstLogo.Position = UDim2.fromOffset(2, 8)
                WurstText.Position = UDim2.fromOffset(6, (WurstLogo.Visible and (TextGUIBackgroundToggle.Enabled and 41 or 35) or 5) + (WurstCustomText.Visible and 25 or 0) - offsets[3])
				WurstCustomText.Position = UDim2.fromOffset(0, WurstLogo.Visible and 35 or 0)
				WurstCustomText.TextXAlignment = Enum.TextXAlignment.Left
                WurstBackgroundList.HorizontalAlignment = Enum.HorizontalAlignment.Left
                WurstBackground.Position = WurstText.Position + UDim2.fromOffset(-1, 2 + offsets[4])
            end
        end
        
		if TextGUIMode.Value == "Drawing" then 
			for i,v in pairs(TextGUIObjects.Labels) do 
				v.Visible = false
				v:Remove()
				TextGUIObjects.Labels[i] = nil
			end
			for i,v in pairs(TextGUIObjects.ShadowLabels) do 
				v.Visible = false
				v:Remove()
				TextGUIObjects.ShadowLabels[i] = nil
			end
			for i,v in pairs(backgroundList) do 
				local textdraw = Drawing.new("Text")
				textdraw.Text = v
				textdraw.Size = 23 * WurstScale.Scale
				textdraw.ZIndex = 2
				textdraw.Position = WurstText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstText.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				textdraw.Visible = true
				local textdraw2 = Drawing.new("Text")
				textdraw2.Text = textdraw.Text
				textdraw2.Size = 23 * WurstScale.Scale
				textdraw2.Position = textdraw.Position + Vector2.new(1, 1)
				textdraw2.Color = Color3.new()
				textdraw2.Transparency = 0.5
				textdraw2.Visible = WurstTextExtra.Visible
				table.insert(TextGUIObjects.Labels, textdraw)
				table.insert(TextGUIObjects.ShadowLabels, textdraw2)
			end
		end

        for i,v in pairs(WurstBackground:GetChildren()) do
			table.clear(WurstBackgroundTable)
            if v:IsA("Frame") then v:Destroy() end
        end
        for i,v in pairs(backgroundList) do
            local textsize = textService:GetTextSize(v, WurstText.TextSize, WurstText.Font, Vector2.new(1000000, 1000000))
            local backgroundFrame = Instance.new("Frame")
            backgroundFrame.BorderSizePixel = 0
            backgroundFrame.BackgroundTransparency = 0.62
            backgroundFrame.BackgroundColor3 = Color3.new()
            backgroundFrame.Visible = true
            backgroundFrame.ZIndex = 0
            backgroundFrame.LayoutOrder = i
            backgroundFrame.Size = UDim2.fromOffset(textsize.X + 8, textsize.Y)
            backgroundFrame.Parent = WurstBackground
            local backgroundLineFrame = Instance.new("Frame")
            backgroundLineFrame.Size = UDim2.new(0, 2, 1, 0)
            backgroundLineFrame.Position = (WurstBackgroundList.HorizontalAlignment == Enum.HorizontalAlignment.Left and UDim2.new() or UDim2.new(1, -2, 0, 0))
            backgroundLineFrame.BorderSizePixel = 0
            backgroundLineFrame.Name = "ColorFrame"
            backgroundLineFrame.Parent = backgroundFrame
            local backgroundLineExtra = Instance.new("Frame")
            backgroundLineExtra.BorderSizePixel = 0
            backgroundLineExtra.BackgroundTransparency = 0.96
            backgroundLineExtra.BackgroundColor3 = Color3.new()
            backgroundLineExtra.ZIndex = 0
            backgroundLineExtra.Size = UDim2.new(1, 0, 0, 2)
            backgroundLineExtra.Position = UDim2.new(0, 0, 1, -1)
            backgroundLineExtra.Parent = backgroundFrame
			table.insert(WurstBackgroundTable, backgroundFrame)
        end
		
		GuiLibrary.UpdateUI(GUIColorSlider.Hue, GUIColorSlider.Sat, GUIColorSlider.Value)
	end
end

TextGUI.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):Connect(TextGUIUpdate)
GuiLibrary.UpdateHudEvent.Event:Connect(TextGUIUpdate)
WurstScale:GetPropertyChangedSignal("Scale"):Connect(function()
	local childrenobj = TextGUI.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (gameCamera.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(WurstScale.Scale - 1) or 0), (check and 0 or -6 * (WurstScale.Scale - 1)), 1, -6 * (WurstScale.Scale - 1))
	TextGUIUpdate()
end)
TextGUIMode = TextGUI.CreateDropdown({
	Name = "Mode",
	List = {"Normal", "Drawing"},
	Function = function(val)
		WurstLogoFrame.Visible = val == "Normal"
		for i,v in pairs(TextGUIConnections) do 
			v:Disconnect()
		end
		for i,v in pairs(TextGUIObjects) do 
			for i2,v2 in pairs(v) do 
				v2.Visible = false
				v2:Remove()
				v[i2] = nil
			end
		end
		if val == "Drawing" then
			local WurstLogoDrawing = Drawing.new("Image")
			WurstLogoDrawing.Data = readfile("wurst/assets/WurstLogo3.png")
			WurstLogoDrawing.Size = WurstLogo.AbsoluteSize
			WurstLogoDrawing.Position = WurstLogo.AbsolutePosition + Vector2.new(0, 36)
			WurstLogoDrawing.ZIndex = 2
			WurstLogoDrawing.Visible = WurstLogo.Visible
			local WurstLogoV4Drawing = Drawing.new("Image")
			WurstLogoV4Drawing.Data = readfile("wurst/assets/WurstLogo4.png")
			WurstLogoV4Drawing.Size = WurstLogoV4.AbsoluteSize
			WurstLogoV4Drawing.Position = WurstLogoV4.AbsolutePosition + Vector2.new(0, 36)
			WurstLogoV4Drawing.ZIndex = 2
			WurstLogoV4Drawing.Visible = WurstLogo.Visible
			local WurstLogoShadowDrawing = Drawing.new("Image")
			WurstLogoShadowDrawing.Data = readfile("wurst/assets/WurstLogo3.png")
			WurstLogoShadowDrawing.Size = WurstLogo.AbsoluteSize
			WurstLogoShadowDrawing.Position = WurstLogo.AbsolutePosition + Vector2.new(1, 37)
			WurstLogoShadowDrawing.Transparency = 0.5
			WurstLogoShadowDrawing.Visible = WurstLogo.Visible and WurstLogoShadow.Visible
			local WurstLogo4Drawing = Drawing.new("Image")
			WurstLogo4Drawing.Data = readfile("wurst/assets/WurstLogo4.png")
			WurstLogo4Drawing.Size = WurstLogoV4.AbsoluteSize
			WurstLogo4Drawing.Position = WurstLogoV4.AbsolutePosition + Vector2.new(1, 37)
			WurstLogo4Drawing.Transparency = 0.5
			WurstLogo4Drawing.Visible = WurstLogo.Visible and WurstLogoShadow.Visible
			local WurstCustomDrawingText = Drawing.new("Text")
			WurstCustomDrawingText.Size = 30
			WurstCustomDrawingText.Text = WurstCustomText.Text
			WurstCustomDrawingText.Color = WurstCustomText.TextColor3
			WurstCustomDrawingText.ZIndex = 2
			WurstCustomDrawingText.Position = WurstCustomText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstCustomText.AbsoluteSize.X - WurstCustomDrawingText.TextBounds.X), 32)
			WurstCustomDrawingText.Visible = WurstCustomText.Visible
			local WurstCustomDrawingShadow = Drawing.new("Text")
			WurstCustomDrawingShadow.Size = 30
			WurstCustomDrawingShadow.Text = WurstCustomText.Text
			WurstCustomDrawingShadow.Transparency = 0.5
			WurstCustomDrawingShadow.Color = Color3.new()
			WurstCustomDrawingShadow.Position = WurstCustomDrawingText.Position + Vector2.new(1, 1)
			WurstCustomDrawingShadow.Visible = WurstCustomText.Visible and WurstTextExtra.Visible
			pcall(function()
				WurstLogoShadowDrawing.Color = Color3.new()
				WurstLogo4Drawing.Color = Color3.new()
				WurstLogoDrawing.Color = WurstLogoGradient.Color.Keypoints[1].Value
			end)
			table.insert(TextGUIObjects.Logo, WurstLogoDrawing)
			table.insert(TextGUIObjects.Logo, WurstLogoV4Drawing)
			table.insert(TextGUIObjects.Logo, WurstLogoShadowDrawing)
			table.insert(TextGUIObjects.Logo, WurstLogo4Drawing)
			table.insert(TextGUIObjects.Logo, WurstCustomDrawingText)
			table.insert(TextGUIObjects.Logo, WurstCustomDrawingShadow)
			table.insert(TextGUIConnections, WurstLogo:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				WurstLogoDrawing.Position = WurstLogo.AbsolutePosition + Vector2.new(0, 36)
				WurstLogoShadowDrawing.Position = WurstLogo.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(TextGUIConnections, WurstLogo:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				WurstLogoDrawing.Size = WurstLogo.AbsoluteSize
				WurstLogoShadowDrawing.Size = WurstLogo.AbsoluteSize
				WurstCustomDrawingText.Size = 30 * WurstScale.Scale
				WurstCustomDrawingShadow.Size = 30 * WurstScale.Scale
			end))
			table.insert(TextGUIConnections, WurstLogoV4:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				WurstLogoV4Drawing.Position = WurstLogoV4.AbsolutePosition + Vector2.new(0, 36)
				WurstLogo4Drawing.Position = WurstLogoV4.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(TextGUIConnections, WurstLogoV4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				WurstLogoV4Drawing.Size = WurstLogoV4.AbsoluteSize
				WurstLogo4Drawing.Size = WurstLogoV4.AbsoluteSize
			end))
			table.insert(TextGUIConnections, WurstCustomText:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				WurstCustomDrawingText.Position = WurstCustomText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstCustomText.AbsoluteSize.X - WurstCustomDrawingText.TextBounds.X), 32)
				WurstCustomDrawingShadow.Position = WurstCustomDrawingText.Position + Vector2.new(1, 1)
			end))
			table.insert(TextGUIConnections, WurstLogoShadow:GetPropertyChangedSignal("Visible"):Connect(function()
				WurstLogoShadowDrawing.Visible = WurstLogoShadow.Visible
				WurstLogo4Drawing.Visible = WurstLogoShadow.Visible
			end))
			table.insert(TextGUIConnections, WurstTextExtra:GetPropertyChangedSignal("Visible"):Connect(function()
				for i,textdraw in pairs(TextGUIObjects.ShadowLabels) do 
					textdraw.Visible = WurstTextExtra.Visible
				end
				WurstCustomDrawingShadow.Visible = WurstCustomText.Visible and WurstTextExtra.Visible
			end))
			table.insert(TextGUIConnections, WurstLogo:GetPropertyChangedSignal("Visible"):Connect(function()
				WurstLogoDrawing.Visible = WurstLogo.Visible
				WurstLogoV4Drawing.Visible = WurstLogo.Visible
				WurstLogoShadowDrawing.Visible = WurstLogo.Visible and WurstTextExtra.Visible
				WurstLogo4Drawing.Visible = WurstLogo.Visible and WurstTextExtra.Visible
			end))
			table.insert(TextGUIConnections, WurstCustomText:GetPropertyChangedSignal("Visible"):Connect(function()
				WurstCustomDrawingText.Visible = WurstCustomText.Visible
				WurstCustomDrawingShadow.Visible = WurstCustomText.Visible and WurstTextExtra.Visible
			end))
			table.insert(TextGUIConnections, WurstCustomText:GetPropertyChangedSignal("Text"):Connect(function()
				WurstCustomDrawingText.Text = WurstCustomText.Text
				WurstCustomDrawingShadow.Text = WurstCustomText.Text
				WurstCustomDrawingText.Position = WurstCustomText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstCustomText.AbsoluteSize.X - WurstCustomDrawingText.TextBounds.X), 32)
				WurstCustomDrawingShadow.Position = WurstCustomDrawingText.Position + Vector2.new(1, 1)
			end))
			table.insert(TextGUIConnections, WurstCustomText:GetPropertyChangedSignal("TextColor3"):Connect(function()
				WurstCustomDrawingText.Color = WurstCustomText.TextColor3
			end))
			table.insert(TextGUIConnections, WurstText:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				for i,textdraw in pairs(TextGUIObjects.Labels) do 
					textdraw.Position = WurstText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstText.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				end
				for i,textdraw in pairs(TextGUIObjects.ShadowLabels) do 
					textdraw.Position = Vector2.new(1, 1) + (WurstText.AbsolutePosition + Vector2.new(WurstText.TextXAlignment == Enum.TextXAlignment.Right and (WurstText.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6))
				end
			end))
			table.insert(TextGUIConnections, WurstLogoGradient:GetPropertyChangedSignal("Color"):Connect(function()
				pcall(function()
					WurstLogoDrawing.Color = WurstLogoGradient.Color.Keypoints[1].Value
				end)
			end))
		end
	end
})
TextGUISortMode = TextGUI.CreateDropdown({
	Name = "Sort",
	List = {"Alphabetical", "Length"},
	Function = function(val)
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
local TextGUIFonts = {"SourceSans"}
local TextGUIFonts2 = {"GothamBold"}
for i,v in pairs(Enum.Font:GetEnumItems()) do 
	if v.Name ~= "SourceSans" then
		table.insert(TextGUIFonts, v.Name)
	end
	if v.Name ~= "GothamBold" then
		table.insert(TextGUIFonts2, v.Name)
	end
end
TextGUI.CreateDropdown({
	Name = "Font",
	List = TextGUIFonts,
	Function = function(val)
		WurstText.Font = Enum.Font[val]
		WurstTextExtra.Font = Enum.Font[val]
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
TextGUI.CreateDropdown({
	Name = "CustomTextFont",
	List = TextGUIFonts2,
	Function = function(val)
		WurstText.Font = Enum.Font[val]
		WurstTextExtra.Font = Enum.Font[val]
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
TextGUI.CreateSlider({
	Name = "Scale",
	Min = 1,
	Max = 50,
	Default = 10,
	Function = function(val)
		WurstScale.Scale = val / 10
	end
})
TextGUI.CreateToggle({
	Name = "Shadow", 
	Function = function(callback) 
        WurstTextExtra.Visible = callback 
        WurstLogoShadow.Visible = callback 
    end,
	HoverText = "Renders shadowed text."
})
TextGUI.CreateToggle({
	Name = "Watermark", 
	Function = function(callback) 
		WurstLogo.Visible = callback
		GuiLibrary.UpdateHudEvent:Fire()
	end,
	HoverText = "Renders a wurst watermark"
})
TextGUIBackgroundToggle = TextGUI.CreateToggle({
	Name = "Render background", 
	Function = function(callback)
		WurstBackground.Visible = callback
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
TextGUI.CreateToggle({
	Name = "Hide Modules",
	Function = function(callback) 
		if TextGUICircleObject.Object then
			TextGUICircleObject.Object.Visible = callback
		end
	end
})
TextGUICircleObject = TextGUI.CreateCircleWindow({
	Name = "Blacklist",
	Type = "Blacklist",
	UpdateFunction = function()
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
TextGUICircleObject.Object.Visible = false
local TextGUIGradient = TextGUI.CreateToggle({
	Name = "Gradient Logo",
	Function = function() 
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
TextGUI.CreateToggle({
	Name = "Alternate Text",
	Function = function() 
		GuiLibrary.UpdateHudEvent:Fire()
	end
})
local CustomText = {Value = "", Object = nil}
TextGUI.CreateToggle({
	Name = "Add custom text", 
	Function = function(callback) 
		WurstCustomText.Visible = callback
		CustomText.Object.Visible = callback
		GuiLibrary.UpdateHudEvent:Fire()
	end,
	HoverText = "Renders a custom label"
})
CustomText = TextGUI.CreateTextBox({
	Name = "Custom text",
	FocusLost = function(enter)
		WurstCustomText.Text = CustomText.Value
		WurstCustomTextShadow.Text = CustomText.Value
	end
})
CustomText.Object.Visible = false
local TargetInfo = GuiLibrary.CreateCustomWindow({
	Name = "Target Info",
	Icon = "wurst/assets/TargetInfoIcon1.png",
	IconSize = 16
})
local TargetInfoDisplayNames = TargetInfo.CreateToggle({
	Name = "Use Display Name",
	Function = function() end,
	Default = true
})
local TargetInfoBackground = {Enabled = false}
local TargetInfoMainFrame = Instance.new("Frame")
TargetInfoMainFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
TargetInfoMainFrame.BorderSizePixel = 0
TargetInfoMainFrame.BackgroundTransparency = 1
TargetInfoMainFrame.Size = UDim2.new(0, 220, 0, 72)
TargetInfoMainFrame.Position = UDim2.new(0, 0, 0, 5)
TargetInfoMainFrame.Parent = TargetInfo.GetCustomChildren()
local TargetInfoMainInfo = Instance.new("Frame")
TargetInfoMainInfo.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
TargetInfoMainInfo.Size = UDim2.new(0, 220, 0, 80)
TargetInfoMainInfo.BackgroundTransparency = 0.25
TargetInfoMainInfo.Position = UDim2.new(0, 0, 0, 0)
TargetInfoMainInfo.Name = "MainInfo"
TargetInfoMainInfo.Parent = TargetInfoMainFrame
local TargetInfoName = Instance.new("TextLabel")
TargetInfoName.TextSize = 17
TargetInfoName.Font = Enum.Font.SourceSans
TargetInfoName.TextColor3 = Color3.fromRGB(162, 162, 162)
TargetInfoName.Position = UDim2.new(0, 72, 0, 7)
TargetInfoName.TextStrokeTransparency = 1
TargetInfoName.BackgroundTransparency = 1
TargetInfoName.Size = UDim2.new(0, 80, 0, 16)
TargetInfoName.TextScaled = true
TargetInfoName.Text = "Target name"
TargetInfoName.ZIndex = 2
TargetInfoName.TextXAlignment = Enum.TextXAlignment.Left
TargetInfoName.TextYAlignment = Enum.TextYAlignment.Top
TargetInfoName.Parent = TargetInfoMainInfo
local TargetInfoNameShadow = TargetInfoName:Clone()
TargetInfoNameShadow.Size = UDim2.new(1, 0, 1, 0)
TargetInfoNameShadow.TextTransparency = 0.5
TargetInfoNameShadow.TextColor3 = Color3.new()
TargetInfoNameShadow.ZIndex = 1
TargetInfoNameShadow.Position = UDim2.new(0, 1, 0, 1)
TargetInfoName:GetPropertyChangedSignal("Text"):Connect(function()
	TargetInfoNameShadow.Text = TargetInfoName.Text
end)
TargetInfoNameShadow.Parent = TargetInfoName
local TargetInfoHealthBackground = Instance.new("Frame")
TargetInfoHealthBackground.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
TargetInfoHealthBackground.Size = UDim2.new(0, 138, 0, 4)
TargetInfoHealthBackground.Position = UDim2.new(0, 72, 0, 29)
TargetInfoHealthBackground.Parent = TargetInfoMainInfo
local TargetInfoHealthBackgroundShadow = Instance.new("ImageLabel")
TargetInfoHealthBackgroundShadow.AnchorPoint = Vector2.new(0.5, 0.5)
TargetInfoHealthBackgroundShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
TargetInfoHealthBackgroundShadow.Image = downloadWurstAsset("wurst/assets/WindowBlur.png")
TargetInfoHealthBackgroundShadow.BackgroundTransparency = 1
TargetInfoHealthBackgroundShadow.ImageTransparency = 0.6
TargetInfoHealthBackgroundShadow.ZIndex = -1
TargetInfoHealthBackgroundShadow.Size = UDim2.new(1, 6, 1, 6)
TargetInfoHealthBackgroundShadow.ImageColor3 = Color3.new()
TargetInfoHealthBackgroundShadow.ScaleType = Enum.ScaleType.Slice
TargetInfoHealthBackgroundShadow.SliceCenter = Rect.new(10, 10, 118, 118)
TargetInfoHealthBackgroundShadow.Parent = TargetInfoHealthBackground
local TargetInfoHealth = Instance.new("Frame")
TargetInfoHealth.BackgroundColor3 = Color3.fromRGB(40, 137, 109)
TargetInfoHealth.Size = UDim2.new(1, 0, 1, 0)
TargetInfoHealth.ZIndex = 3
TargetInfoHealth.BorderSizePixel = 0
TargetInfoHealth.Parent = TargetInfoHealthBackground
local TargetInfoHealthExtra = Instance.new("Frame")
TargetInfoHealthExtra.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
TargetInfoHealthExtra.Size = UDim2.new(0, 0, 1, 0)
TargetInfoHealthExtra.ZIndex = 4
TargetInfoHealthExtra.BorderSizePixel = 0
TargetInfoHealthExtra.AnchorPoint = Vector2.new(1, 0)
TargetInfoHealthExtra.Position = UDim2.new(1, 0, 0, 0)
TargetInfoHealthExtra.Parent = TargetInfoHealth
local TargetInfoImage = Instance.new("ImageLabel")
TargetInfoImage.Size = UDim2.new(0, 61, 0, 61)
TargetInfoImage.BackgroundTransparency = 1
TargetInfoImage.Image = 'rbxthumb://type=AvatarHeadShot&id='..playersService.LocalPlayer.UserId..'&w=420&h=420'
TargetInfoImage.Position = UDim2.new(0, 5, 0, 10)
TargetInfoImage.Parent = TargetInfoMainInfo
local TargetInfoMainInfoCorner = Instance.new("UICorner")
TargetInfoMainInfoCorner.CornerRadius = UDim.new(0, 4)
TargetInfoMainInfoCorner.Parent = TargetInfoMainInfo
local TargetInfoHealthBackgroundCorner = Instance.new("UICorner")
TargetInfoHealthBackgroundCorner.CornerRadius = UDim.new(0, 2048)
TargetInfoHealthBackgroundCorner.Parent = TargetInfoHealthBackground
local TargetInfoHealthCorner = Instance.new("UICorner")
TargetInfoHealthCorner.CornerRadius = UDim.new(0, 2048)
TargetInfoHealthCorner.Parent = TargetInfoHealth
local TargetInfoHealthCorner2 = Instance.new("UICorner")
TargetInfoHealthCorner2.CornerRadius = UDim.new(0, 2048)
TargetInfoHealthCorner2.Parent = TargetInfoHealthExtra
local TargetInfoHealthExtraCorner = Instance.new("UICorner")
TargetInfoHealthExtraCorner.CornerRadius = UDim.new(0, 4)
TargetInfoHealthExtraCorner.Parent = TargetInfoImage
TargetInfoBackground = TargetInfo.CreateToggle({
	Name = "Use Background",
	Function = function(callback) 
		TargetInfoMainInfo.BackgroundTransparency = callback and 0.25 or 1
		TargetInfoName.TextColor3 = callback and Color3.fromRGB(162, 162, 162) or Color3.new(1, 1, 1)
		TargetInfoName.Size = UDim2.new(0, 80, 0, callback and 16 or 18)
		TargetInfoHealthBackground.Size = UDim2.new(0, 138, 0, callback and 4 or 7)
	end,
	Default = true
})
local TargetInfoHealthTween
TargetInfo.GetCustomChildren().Parent:GetPropertyChangedSignal("Size"):Connect(function()
	TargetInfoMainInfo.Position = UDim2.fromOffset(0, TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.fromOffset(220, 0) and -5 or 40)
end)
shared.WurstTargetInfo = {
	UpdateInfo = function(tab, targetsize) 
		if TargetInfo.GetCustomChildren().Parent then
			local hasTarget = false
			for _, v in pairs(shared.WurstTargetInfo.Targets) do
				hasTarget = true
				TargetInfoImage.Image = 'rbxthumb://type=AvatarHeadShot&id='..v.Player.UserId..'&w=420&h=420'
				TargetInfoHealth:TweenSize(UDim2.new(math.clamp(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				TargetInfoHealthExtra:TweenSize(UDim2.new(math.clamp((v.Humanoid.Health / v.Humanoid.MaxHealth) - 1, 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
				if TargetInfoHealthTween then TargetInfoHealthTween:Cancel() end
				TargetInfoHealthTween = game:GetService("TweenService"):Create(TargetInfoHealth, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromHSV(math.clamp(v.Humanoid.Health / v.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)})
				TargetInfoHealthTween:Play()
				TargetInfoName.Text = (TargetInfoDisplayNames.Enabled and v.Player.DisplayName or v.Player.Name)
				break
			end
			TargetInfoMainInfo.Visible = hasTarget or (TargetInfo.GetCustomChildren().Parent.Size ~= UDim2.new(0, 220, 0, 0))
		end
	end,
	Targets = {},
	Object = TargetInfo
}
task.spawn(function()
	repeat
		if shared.WurstTargetInfo then
			shared.WurstTargetInfo.UpdateInfo()
		end
		task.wait()
	until not wurstInjected
end)
GUI.CreateCustomToggle({
	Name = "Target Info", 
	Icon = "wurst/assets/TargetInfoIcon2.png", 
	Function = function(callback) TargetInfo.SetVisible(callback) end,
	Priority = 1
})
local GeneralSettings = GUI.CreateDivider2("General Settings")
local ModuleSettings = GUI.CreateDivider2("Module Settings")
local GUISettings = GUI.CreateDivider2("GUI Settings")
local TeamsByColorToggle = {Enabled = false}
TeamsByColorToggle = ModuleSettings.CreateToggle({
	Name = "Teams by color", 
	Function = function() if TeamsByColorToggle.Refresh then TeamsByColorToggle.Refresh:Fire() end end,
	Default = true,
	HoverText = "Ignore players on your team designated by the game"
})
TeamsByColorToggle.Refresh = Instance.new("BindableEvent")
local MiddleClickInput
ModuleSettings.CreateToggle({
	Name = "MiddleClick friends", 
	Function = function(callback) 
		if callback then
			MiddleClickInput = inputService.InputBegan:Connect(function(input1)
				if input1.UserInputType == Enum.UserInputType.MouseButton3 then
					local entityLibrary = shared.wurstentity
					if entityLibrary then 
						local rayparams = RaycastParams.new()
						rayparams.FilterType = Enum.RaycastFilterType.Whitelist
						local chars = {}
						for i,v in pairs(entityLibrary.entityList) do 
							table.insert(chars, v.Character)
						end
						rayparams.FilterDescendantsInstances = chars
						local mouseunit = playersService.LocalPlayer:GetMouse().UnitRay
						local ray = workspace:Raycast(mouseunit.Origin, mouseunit.Direction * 10000, rayparams)
						if ray then 
							for i,v in pairs(entityLibrary.entityList) do 
								if ray.Instance:IsDescendantOf(v.Character) then 
									local found = table.find(FriendsTextList.ObjectList, v.Player.Name)
									if not found then
										table.insert(FriendsTextList.ObjectList, v.Player.Name)
										table.insert(FriendsTextList.ObjectListEnabled, true)
										FriendsTextList.RefreshValues(FriendsTextList.ObjectList)
									else
										table.remove(FriendsTextList.ObjectList, found)
										table.remove(FriendsTextList.ObjectListEnabled, found)
										FriendsTextList.RefreshValues(FriendsTextList.ObjectList)
									end
									break
								end
							end
						end
					end
				end
			end)
		else
			if MiddleClickInput then MiddleClickInput:Disconnect() end
		end
	end,
	HoverText = "Click middle mouse button to add the player you are hovering over as a friend"
})
ModuleSettings.CreateToggle({
	Name = "Lobby Check",
	Function = function() end,
	Default = true,
	HoverText = "Temporarily disables certain features in server lobbies."
})
GUIColorSlider = GUI.CreateColorSlider("GUI Theme", function(h, s, v) 
	GuiLibrary.UpdateUI(h, s, v) 
end)
local BlatantModeToggle = GUI.CreateToggle({
	Name = "Bruh mode",
	Function = function() end,
	HoverText = "Required for certain features."
})
local windowSortOrder = {
	CombatButton = 1,
	BlatantButton = 2,
	RenderButton = 3,
	UtilityButton = 4,
	WorldButton = 5,
	FriendsButton = 6,
	TargetsButton = 7,
	ProfilesButton = 8
}
local windowSortOrder2 = {"Combat", "Blatant", "Render", "Utility", "World"}

local function getWurstSaturation(val)
	local sat = 0.9
	if val < 0.03 then 
		sat = 0.75 + (0.15 * math.clamp(val / 0.03, 0, 1))
	end
	if val > 0.59 then 
		sat = 0.9 - (0.4 * math.clamp((val - 0.59) / 0.07, 0, 1))
	end
	if val > 0.68 then 
		sat = 0.5 + (0.4 * math.clamp((val - 0.68) / 0.14, 0, 1))
	end
	if val > 0.89 then 
		sat = 0.9 - (0.15 * math.clamp((val - 0.89) / 0.1, 0, 1))
	end
	return sat
end

GuiLibrary.UpdateUI = function(h, s, val, bypass)
	pcall(function()
		local rainbowGUICheck = GUIColorSlider.RainbowValue
		local mainRainbowSaturation = rainbowGUICheck and getWurstSaturation(h) or s
		local mainRainbowGradient = h + (rainbowGUICheck and (-0.05) or 0)
		mainRainbowGradient = mainRainbowGradient % 1
        local mainRainbowGradientSaturation = TextGUIGradient.Enabled and getWurstSaturation(mainRainbowGradient) or mainRainbowSaturation

		GuiLibrary.ObjectsThatCanBeSaved.GUIWindow.Object.Logo1.Logo2.ImageColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
		WurstText.TextColor3 = Color3.fromHSV(TextGUIGradient.Enabled and mainRainbowGradient or h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
		WurstCustomText.TextColor3 = WurstText.TextColor3
		WurstLogoGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)),
			ColorSequenceKeypoint.new(1, WurstText.TextColor3)
		})
		WurstLogoGradient2.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(h, TextGUIGradient.Enabled and rainbowGUICheck and mainRainbowSaturation or 0, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(TextGUIGradient.Enabled and mainRainbowGradient or h, TextGUIGradient.Enabled and rainbowGUICheck and mainRainbowSaturation or 0, 1))
		})

		local newTextGUIText = "\n"
		local backgroundTable = {}
		for i, v in pairs(TextGUIFormatted) do
			local rainbowcolor = h + (rainbowGUICheck and (-0.025 * (i + (TextGUIGradient.Enabled and 2 or 0))) or 0)
			rainbowcolor = rainbowcolor % 1
			local newcolor = Color3.fromHSV(rainbowcolor, rainbowGUICheck and getWurstSaturation(rainbowcolor) or mainRainbowSaturation, rainbowGUICheck and 1 or val)
			newTextGUIText = newTextGUIText..'<font color="rgb('..math.floor(newcolor.R * 255)..","..math.floor(newcolor.G * 255)..","..math.floor(newcolor.B * 255)..')">'..v.Text..'</font><font color="rgb(170, 170, 170)">'..v.ExtraText..'</font>\n'
			backgroundTable[i] = newcolor
		end

		if TextGUIMode.Value == "Drawing" then 
			for i,v in pairs(TextGUIObjects.Labels) do 
				if backgroundTable[i] then 
					v.Color = backgroundTable[i]
				end
			end
		end

		if TextGUIBackgroundToggle.Enabled then
			for i, v in pairs(WurstBackgroundTable) do
				v.ColorFrame.BackgroundColor3 = backgroundTable[v.LayoutOrder] or Color3.new()
			end
		end
		WurstText.Text = newTextGUIText

		if (not GuiLibrary.MainGui.ScaledGui.ClickGui.Visible) and (not bypass) then return end
		GuiLibrary.MainGui.ScaledGui.ClickGui.SearchBar.LegitMode.ImageColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
		local buttonColorIndex = 0
		for i, v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
			if v.Type == "TargetFrame" then
				if v.Object2.Visible then
					v.Object.TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				end
			elseif v.Type == "TargetButton" then
				if v.Api.Enabled then
					v.Object.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				end
			elseif v.Type == "CircleListFrame" then
				if v.Object2.Visible then
					v.Object.TextButton.Frame.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				end
			elseif (v.Type == "Button" or v.Type == "ButtonMain") and v.Api.Enabled then
				buttonColorIndex = buttonColorIndex + 1
				local rainbowcolor = h + (rainbowGUICheck and (-0.025 * windowSortOrder[i]) or 0)
				rainbowcolor = rainbowcolor % 1
				local newcolor = Color3.fromHSV(rainbowcolor, rainbowGUICheck and getWurstSaturation(rainbowcolor) or mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.Object.ButtonText.TextColor3 = newcolor
				if v.Object:FindFirstChild("ButtonIcon") then
					v.Object.ButtonIcon.ImageColor3 = newcolor
				end
			elseif v.Type == "OptionsButton" then
				if v.Api.Enabled then
					local newcolor = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
					if (not oldrainbow) then
						local mainRainbowGradient = table.find(windowSortOrder2, v.Object.Parent.Parent.Name)
						mainRainbowGradient = mainRainbowGradient and (mainRainbowGradient - 1) > 0 and GuiLibrary.ObjectsThatCanBeSaved[windowSortOrder2[mainRainbowGradient - 1].."Window"].SortOrder or 0
						local rainbowcolor = h + (rainbowGUICheck and (-0.025 * (mainRainbowGradient + v.SortOrder)) or 0)
						rainbowcolor = rainbowcolor % 1
						newcolor = Color3.fromHSV(rainbowcolor, rainbowGUICheck and getWurstSaturation(rainbowcolor) or mainRainbowSaturation, rainbowGUICheck and 1 or val)
					end
					v.Object.BackgroundColor3 = newcolor
				end
			elseif v.Type == "ExtrasButton" then
				if v.Api.Enabled then
					local rainbowcolor = h + (rainbowGUICheck and (-0.025 * buttonColorIndex) or 0)
					rainbowcolor = rainbowcolor % 1
					local newcolor = Color3.fromHSV(rainbowcolor, rainbowGUICheck and getWurstSaturation(rainbowcolor) or mainRainbowSaturation, rainbowGUICheck and 1 or val)
					v.Object.ImageColor3 = newcolor
				end
			elseif (v.Type == "Toggle" or v.Type == "ToggleMain") and v.Api.Enabled then
				v.Object.ToggleFrame1.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
			elseif v.Type == "Slider" or v.Type == "SliderMain" then
				v.Object.Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.Object.Slider.FillSlider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
			elseif v.Type == "TwoSlider" then
				v.Object.Slider.FillSlider.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.Object.Slider.ButtonSlider.ImageColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.Object.Slider.ButtonSlider2.ImageColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
			end
		end

		local rainbowcolor = h + (rainbowGUICheck and (-0.025 * buttonColorIndex) or 0)
		rainbowcolor = rainbowcolor % 1
		GuiLibrary.ObjectsThatCanBeSaved.GUIWindow.Object.Children.Extras.MainButton.ImageColor3 = (GUI.GetVisibleIcons() > 0 and Color3.fromHSV(rainbowcolor, getWurstSaturation(rainbowcolor), 1) or Color3.fromRGB(199, 199, 199))

		for i, v in pairs(ProfilesTextList.ScrollingObject.ScrollingFrame:GetChildren()) do
			if v:IsA("TextButton") and v.ItemText.Text == GuiLibrary.CurrentProfile then
				v.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.ImageButton.BackgroundColor3 = Color3.fromHSV(h, mainRainbowSaturation, rainbowGUICheck and 1 or val)
				v.ItemText.TextColor3 = Color3.new(1, 1, 1)
				v.ItemText.TextStrokeTransparency = 0.75
			end
		end
	end)
end

GUISettings.CreateToggle({
	Name = "Blur Background", 
	Function = function(callback) 
		GuiLibrary.MainBlur.Size = (callback and 25 or 0) 
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary.MainGui.ScaledGui.ClickGui.Visible and callback) 
	end,
	Default = true,
	HoverText = "Blur the background of the GUI"
})
local welcomeMessage = GUISettings.CreateToggle({
	Name = "GUI bind indicator", 
	Function = function() end, 
	Default = true,
	HoverText = 'Displays a message indicating your GUI keybind upon injecting.\nI.E "Press TAB to open GUI"'
})
GUISettings.CreateToggle({
	Name = "Old Rainbow", 
	Function = function(callback) oldrainbow = callback end,
	HoverText = "Reverts to old rainbow"
})
GUISettings.CreateToggle({
	Name = "Show Tooltips", 
	Function = function(callback) GuiLibrary.ToggleTooltips = callback end,
	Default = true,
	HoverText = "Toggles visibility of these"
})
local GUIRescaleToggle = GUISettings.CreateToggle({
	Name = "Rescale", 
	Function = function(callback) 
		task.spawn(function()
			GuiLibrary.MainRescale.Scale = (callback and math.clamp(gameCamera.ViewportSize.X / 1920, 0.5, 1) or 0.99)
			task.wait(0.01)
			GuiLibrary.MainRescale.Scale = (callback and math.clamp(gameCamera.ViewportSize.X / 1920, 0.5, 1) or 1)
		end)
	end,
	Default = true,
	HoverText = "Rescales the GUI"
})
gameCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if GUIRescaleToggle.Enabled then
		GuiLibrary.MainRescale.Scale = math.clamp(gameCamera.ViewportSize.X / 1920, 0.5, 1)
	end
end)
GUISettings.CreateToggle({
	Name = "Notifications", 
	Function = function(callback) 
		GuiLibrary.Notifications = callback 
	end,
	Default = true,
	HoverText = "Shows notifications"
})
local ToggleNotifications
ToggleNotifications = GUISettings.CreateToggle({
	Name = "Toggle Alert", 
	Function = function(callback) GuiLibrary.ToggleNotifications = callback end,
	Default = true,
	HoverText = "Notifies you if a module is enabled/disabled."
})
ToggleNotifications.Object.BackgroundTransparency = 0
ToggleNotifications.Object.BorderSizePixel = 0
ToggleNotifications.Object.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUISettings.CreateSlider({
	Name = "Rainbow Speed",
	Function = function(val)
		GuiLibrary.RainbowSpeed = math.max((val / 10) - 0.4, 0)
	end,
	Min = 1,
	Max = 100,
	Default = 10
})

local GUIbind = GUI.CreateGUIBind()
local teleportConnection = playersService.LocalPlayer.OnTeleport:Connect(function(State)
    if (not teleportedServers) and (not shared.WurstIndependent) then
		teleportedServers = true
		local teleportScript = [[
			shared.WurstSwitchServers = true 
			if shared.WurstDeveloper then 
				loadstring(readfile("wurst/NewMainScript.lua"))() 
			else 
				loadstring(game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/VapeV4WurstEdition-ButNoVape/"..readfile("wurst/commithash.txt").."/NewMainScript.lua", true))() 
			end
		]]
		if shared.WurstDeveloper then
			teleportScript = 'shared.WurstDeveloper = true\n'..teleportScript
		end
		if shared.WurstPrivate then
			teleportScript = 'shared.WurstPrivate = true\n'..teleportScript
		end
		if shared.WurstCustomProfile then 
			teleportScript = "shared.WurstCustomProfile = '"..shared.WurstCustomProfile.."'\n"..teleportScript
		end
		GuiLibrary.SaveSettings()
		queueonteleport(teleportScript)
    end
end)

GuiLibrary.SelfDestruct = function()
	task.spawn(function()
		coroutine.close(saveSettingsLoop)
	end)

	if wurstInjected then 
		GuiLibrary.SaveSettings()
	end
	wurstInjected = false
	inputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None

	for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
		if (v.Type == "Button" or v.Type == "OptionsButton" or v.Type == "LegitModule") and v.Api.Enabled then
			v.Api.ToggleButton(false)
		end
	end

	for i,v in pairs(TextGUIConnections) do 
		v:Disconnect()
	end
	for i,v in pairs(TextGUIObjects) do 
		for i2,v2 in pairs(v) do 
			v2.Visible = false
			v2:Destroy()
			v[i2] = nil
		end
	end

	GuiLibrary.SelfDestructEvent:Fire()
	shared.WurstExecuted = nil
	shared.WurstPrivate = nil
	shared.WurstFullyLoaded = nil
	shared.WurstSwitchServers = nil
	shared.GuiLibrary = nil
	shared.WurstIndependent = nil
	shared.WurstManualLoad = nil
	shared.CustomSaveWurst = nil
	GuiLibrary.KeyInputHandler:Disconnect()
	GuiLibrary.KeyInputHandler2:Disconnect()
	if MiddleClickInput then
		MiddleClickInput:Disconnect()
	end
	teleportConnection:Disconnect()
	GuiLibrary.MainGui:Destroy()
	game:GetService("RunService"):SetRobloxGuiFocused(false)	
end

GeneralSettings.CreateButton2({
	Name = "RESET CURRENT PROFILE", 
	Function = function()
		local wurstPrivateCheck = shared.WurstPrivate
		GuiLibrary.SelfDestruct()
		if delfile then
			delfile(baseDirectory.."Profiles/"..(GuiLibrary.CurrentProfile ~= "default" and GuiLibrary.CurrentProfile or "")..(shared.CustomSaveWurst or game.PlaceId)..".wurstprofile.txt")
		else
			writefile(baseDirectory.."Profiles/"..(GuiLibrary.CurrentProfile ~= "default" and GuiLibrary.CurrentProfile or "")..(shared.CustomSaveWurst or game.PlaceId)..".wurstprofile.txt", "")
		end
		shared.WurstSwitchServers = true
		shared.WurstOpenGui = true
		shared.WurstPrivate = wurstPrivateCheck
		loadstring(wurstGithubRequest("NewMainScript.lua"))()
	end
})
GUISettings.CreateButton2({
	Name = "RESET GUI POSITIONS", 
	Function = function()
		for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
			if (v.Type == "Window" or v.Type == "CustomWindow") then
				v.Object.Position = (i == "GUIWindow" and UDim2.new(0, 6, 0, 6) or UDim2.new(0, 223, 0, 6))
			end
		end
	end
})
GUISettings.CreateButton2({
	Name = "SORT GUI", 
	Function = function()
		local sorttable = {}
		local movedown = false
		local sortordertable = {
			GUIWindow = 1,
			CombatWindow = 2,
			BlatantWindow = 3,
			RenderWindow = 4,
			UtilityWindow = 5,
			WorldWindow = 6,
			FriendsWindow = 7,
			TargetsWindow = 8,
			ProfilesWindow = 9,
			["Text GUICustomWindow"] = 10,
			TargetInfoCustomWindow = 11,
			RadarCustomWindow = 12,
		}
		local storedpos = {}
		local num = 6
		for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
			local obj = GuiLibrary.ObjectsThatCanBeSaved[i]
			if obj then
				if v.Type == "Window" and v.Object.Visible then
					local sortordernum = (sortordertable[i] or #sorttable)
					sorttable[sortordernum] = v.Object
				end
			end
		end
		for i2,v2 in pairs(sorttable) do
			if num > 1697 then
				movedown = true
				num = 6
			end
			v2.Position = UDim2.new(0, num, 0, (movedown and (storedpos[num] and (storedpos[num] + 9) or 400) or 39))
			if not storedpos[num] then
				storedpos[num] = v2.AbsoluteSize.Y
				if v2.Name == "MainWindow" then
					storedpos[num] = 400
				end
			end
			num = num + 223
		end
	end
})
GeneralSettings.CreateButton2({
	Name = "UNINJECT",
	Function = GuiLibrary.SelfDestruct
})

local function loadWurst()
	if not shared.WurstIndependent then
		loadstring(wurstGithubRequest("Universal.lua"))()
		if isfile("wurst/CustomModules/"..game.PlaceId..".lua") then
			loadstring(readfile("wurst/CustomModules/"..game.PlaceId..".lua"))()
		else
			if not shared.WurstDeveloper then
				local suc, publicrepo = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/WurstRoblox/VapeV4WurstEdition-ButNoVape/"..readfile("wurst/commithash.txt").."/CustomModules/"..game.PlaceId..".lua") end)
				if suc and publicrepo and publicrepo ~= "404: Not Found" then
					writefile("wurst/CustomModules/"..game.PlaceId..".lua", "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..publicrepo)
					loadstring(readfile("wurst/CustomModules/"..game.PlaceId..".lua"))()
				end
			end
		end
		if shared.WurstPrivate then
			if isfile("wurstprivate/CustomModules/"..game.PlaceId..".lua") then
				loadstring(readfile("wurstprivate/CustomModules/"..game.PlaceId..".lua"))()
			end	
		end
	else
		repeat task.wait() until shared.WurstManualLoad
	end
	if #ProfilesTextList.ObjectList == 0 then
		table.insert(ProfilesTextList.ObjectList, "default")
		ProfilesTextList.RefreshValues(ProfilesTextList.ObjectList)
	end
	GuiLibrary.LoadSettings(shared.WurstCustomProfile)
	local profiles = {}
	for i,v in pairs(GuiLibrary.Profiles) do 
		table.insert(profiles, i)
	end
	table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
	ProfilesTextList.RefreshValues(profiles)
	GUIbind.Reload()
	TextGUIUpdate()
	GuiLibrary.UpdateUI(GUIColorSlider.Hue, GUIColorSlider.Sat, GUIColorSlider.Value, true)
	if not shared.WurstSwitchServers then
		if BlatantModeToggle.Enabled then
			pcall(function()
				local frame = GuiLibrary.CreateNotification("Blatant Enabled", "Wurst is now in Blatant Mode.", 5.5, "assets/WarningNotification.png")
				frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
			end)
		end
		GuiLibrary.LoadedAnimation(welcomeMessage.Enabled)
	else
		shared.WurstSwitchServers = nil
	end
	if shared.WurstOpenGui then
		GuiLibrary.MainGui.ScaledGui.ClickGui.Visible = true
		GuiLibrary.MainGui.ScaledGui.LegitGui.Visible = false
		game:GetService("RunService"):SetRobloxGuiFocused(GuiLibrary.MainBlur.Size ~= 0) 
		shared.WurstOpenGui = nil
	end

	coroutine.resume(saveSettingsLoop)
	shared.WurstFullyLoaded = true
end

if shared.WurstIndependent then
	task.spawn(loadWurst)
	shared.WurstFullyLoaded = true
	return GuiLibrary
else
	loadWurst()
end
