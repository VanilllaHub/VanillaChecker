-- VanillaHub Protected Loader
local KEY = getgenv().VHKey
local LP = game:GetService("Players").LocalPlayer
local function fetch(url)
    return game:HttpGet(url)
end

-- No key provided
if not KEY then
    LP:Kick("❌ VanillaHub: No key provided!")
    return
end

-- Check if valid
local validKeys = {
    "VANILLA-ABC123",
}

local keyValid = false
for _, k in ipairs(validKeys) do
    if k == KEY:gsub("%s+", "") then
        keyValid = true
        break
    end
end

if not keyValid then
    LP:Kick("❌ VanillaHub: Invalid or Expired Key!")
    return
end

-- Load correct game script
if game.PlaceId == 13822889 then -- 🌳 Lumber Tycoon 2
    local scripts = {
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla1.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla2.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla3.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla4.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla5.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla6.lua",
        "https://raw.githubusercontent.com/VanillaHub/VanillaHub.Lt2/main/Vanilla7.lua",
    }
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
elseif game.PlaceId == 606849621 then -- Jailbreak
    loadstring(fetch("https://raw.githubusercontent.com/kode-sec/Butter/refs/heads/main/Jailbreak.lua"))()
elseif game.PlaceId == 185655149 then -- Bloxburg
    loadstring(fetch("https://raw.githubusercontent.com/kode-sec/Butter/refs/heads/main/Bloxburg.lua"))()
else
    LP:Kick("❌ VanillaHub: This game is not supported!")
end

getgenv().VHKey = nil
