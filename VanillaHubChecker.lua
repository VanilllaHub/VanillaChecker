local KEY = getgenv().VanillaChecker
local LP = game:GetService("Players").LocalPlayer

local function fetch(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    return ok and res or nil
end

if not KEY or KEY == "" then
    LP:Kick("VanilllaHub: Please provide a key in the script!")
    return
end

local keyData = fetch("https://raw.githubusercontent.com/VanilllaHub/VanillaChecker/main/keys.txt")
if not keyData then
    LP:Kick("VanilllaHub: Could not reach key server!")
    return
end

local keyValid = false
for line in keyData:gmatch("[^\r\n]+") do
    if line:match("^%s*(.-)%s*$") == KEY then
        keyValid = true
        break
    end
end

if not keyValid then
    LP:Kick("VanilllaHub: Invalid or Expired Key")
    return
end

if game.PlaceId == 13822889 then
    -- Lumber Tycoon 2
    loadstring(fetch("https://raw.githubusercontent.com/VanilllaHub/VanillaHub.Lt2/main/VanillaHub.Lt2.lua"))()

elseif game.PlaceId == 537413528 then
    -- Build A Boat For Treasure
    loadstring(fetch("https://raw.githubusercontent.com/VanilllaHub/VanillaHub.Build-a-Boat/main/VanillaHub.Build-a-Boat.lua"))()

elseif game.PlaceId == 185655149 then
    -- Bloxburg
    LP:Kick("VanilllaHub: Bloxburg support coming soon!")

else
    LP:Kick("VanilllaHub: This game is not supported.")
end

getgenv().VanillaChecker = nil
