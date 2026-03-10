-- [[ VanilllaHub / VanillaChecker ]]
local KEY = getgenv().VanillaChecker
local LP = game:GetService("Players").LocalPlayer

local function fetch(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    return success and result or nil
end

-- 1. Check for Key presence
if not KEY or KEY == "" then
    LP:Kick("VanilllaHub: Please provide a key in the script!")
    return
end

-- 2. Validate Key against your GitHub
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

-- 3. Game Detection
if game.PlaceId == 13822889 then -- 🌳 Lumber Tycoon 2
    loadstring(fetch("https://raw.githubusercontent.com/VanilllaHub/VanillaHub.Lt2/main/VanillaHub.Lt2.lua"))()
elseif game.PlaceId == 606849621 then -- 🏎️ Jailbreak
    LP:Kick("VanilllaHub: Jailbreak support coming soon!")
elseif game.PlaceId == 185655149 then -- 🏠 Bloxburg
    LP:Kick("VanilllaHub: Bloxburg support coming soon!")
else
    LP:Kick("VanilllaHub: This game is not supported.")
end

-- Cleanup
getgenv().VanillaChecker = nil
