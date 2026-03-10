-- VanillaHub Protected Loader
local KEY = getgenv().VHKey
local LP = game:GetService("Players").LocalPlayer
local function fetch(url)
    return game:HttpGet(url)
end

-- No key provided
if not KEY then
    LP:Kick("Key Has Expired!")
    return
end

-- Fetch keys
local success, keyData = pcall(fetch, "https://raw.githubusercontent.com/SadieSin/VanillaHub-Protected/main/keys.txt")
if not success then
    LP:Kick("❌ VanillaHub: Could not reach key server. Try again.")
    return
end

-- Fetch expired keys
local expSuccess, expData = pcall(fetch, "https://raw.githubusercontent.com/SadieSin/VanillaHub-Protected/main/expired.txt")

-- Check if expired
if expSuccess and expData then
    for line in expData:gmatch("[^\n]+") do
        if line:gsub("%s+", "") == KEY:gsub("%s+", "") then
            LP:Kick("Key Has Expired!")
            return
        end
    end
end

-- Check if valid
local keyValid = false
for line in keyData:gmatch("[^\n]+") do
    if line:gsub("%s+", "") == KEY:gsub("%s+", "") then
        keyValid = true
        break
    end
end

if not keyValid then
    LP:Kick("Key Has Expired!")
    return
end

-- Game script map
local gameScripts = {
    [13822889]  = "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/LT2.lua",
    [] = "",
    [] = "",
}

local scriptUrl = gameScripts[game.PlaceId]

if not scriptUrl then
    LP:Kick("❌ VanillaHub: This game is not supported!")
    return
end

-- Key valid + correct game — load script
local ok, src = pcall(fetch, scriptUrl)
if ok and src then
    local fn, err = loadstring(src)
    if fn then
        local runOk, runErr = pcall(fn)
        if not runOk then
            warn("[VanillaHub] Script error: " .. tostring(runErr))
        end
    else
        warn("[VanillaHub] Failed to compile script: " .. tostring(err))
    end
else
    warn("[VanillaHub] Failed to fetch script")
end

getgenv().VHKey = nil
