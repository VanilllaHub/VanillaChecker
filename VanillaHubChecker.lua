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
local success, keyData = pcall(fetch, "https://raw.githubusercontent.com/VanillaHub/VanillaChecker/main/keys.txt")
if not success then
    LP:Kick("❌ VanillaHub: Could not reach key server. Try again.")
    return
end
-- Fetch expired keys
local expSuccess, expData = pcall(fetch, "https://raw.githubusercontent.com/VanillaHub/VanillaChecker/main/expired.txt")
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
    [13822889] = {
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla1.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla2.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla3.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla4.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla5.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla6.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla7.lua",
    },
    [606849621] = {},
    [185655149] = {},
}
local scripts = gameScripts[game.PlaceId]
if not scripts or #scripts == 0 then
    LP:Kick("❌ VanillaHub: This game is not supported!")
    return
end
-- Key valid + correct game — load scripts
for i, url in ipairs(scripts) do
    local ok, src = pcall(fetch, url)
    if ok and src then
        local fn, err = loadstring(src)
        if fn then
            local runOk, runErr = pcall(fn)
            if not runOk then
                warn("[VanillaHub] Vanilla"..i.." error: "..tostring(runErr))
            end
        else
            warn("[VanillaHub] Failed to compile Vanilla"..i..": "..tostring(err))
        end
    else
        warn("[VanillaHub] Failed to fetch Vanilla"..i)
    end
    task.wait(0.3)
end
getgenv().VHKey = nil
