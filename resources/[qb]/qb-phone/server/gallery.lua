local QBCore = exports['qb-core']:GetCoreObject()

-- Base64 decode function (simple implementation)
local function base64Decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

RegisterNetEvent('qb-phone:server:addImageToGallery', function(base64Image)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Extract base64 data (remove data:image/jpeg;base64, prefix if present)
    local base64Data = base64Image
    if base64Image:match("^data:image/") then
        base64Data = base64Image:match("base64,(.+)$")
    end
    
    -- Upload to Discord with photographer info
    local imageUrl = nil
    local WebHook = Config.Webhook
    if WebHook and WebHook ~= '' then
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
        -- Create multipart/form-data for Discord webhook
        local boundary = "----WebKitFormBoundary" .. math.random(1000000000, 9999999999)
        local formData = ""
        
        -- Add payload_json (embed with photographer info)
        local embedData = {
            {
                ['title'] = "Phone Photo Taken",
                ['color'] = 3447003,
                ['description'] = "**Photographer:** " .. playerName,
                ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
        local payloadJson = json.encode({username = 'QB Phone', embeds = embedData})
        
        formData = formData .. "--" .. boundary .. "\r\n"
        formData = formData .. "Content-Disposition: form-data; name=\"payload_json\"\r\n"
        formData = formData .. "Content-Type: application/json\r\n\r\n"
        formData = formData .. payloadJson .. "\r\n"
        
        -- Add file (decode base64 to binary)
        formData = formData .. "--" .. boundary .. "\r\n"
        formData = formData .. "Content-Disposition: form-data; name=\"files[0]\"; filename=\"photo.jpg\"\r\n"
        formData = formData .. "Content-Type: image/jpeg\r\n\r\n"
        
        -- Decode base64 to binary
        local binaryData = base64Decode(base64Data)
        formData = formData .. binaryData .. "\r\n"
        formData = formData .. "--" .. boundary .. "--\r\n"
        
        -- Upload to Discord
        PerformHttpRequest(WebHook, function(errCode, resultData, resultHeaders)
            if resultData then
                local response = json.decode(resultData)
                if response and response.attachments and response.attachments[1] then
                    imageUrl = response.attachments[1].proxy_url
                end
            end
            -- Save to database
            local finalUrl = imageUrl or ("data:image/jpeg;base64," .. base64Data)
            exports.oxmysql:insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)',{Player.PlayerData.citizenid, finalUrl})
        end, 'POST', formData, {
            ['Content-Type'] = 'multipart/form-data; boundary=' .. boundary
        })
    else
        -- No webhook, use data URI
        local dataUri = "data:image/jpeg;base64," .. base64Data
        exports.oxmysql:insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)',{Player.PlayerData.citizenid, dataUri})
    end
end)
RegisterNetEvent('qb-phone:server:getImageFromGallery', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local images = exports.oxmysql:executeSync('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC',{Player.PlayerData.citizenid})
    TriggerClientEvent('qb-phone:refreshImages', src, images)
end)

RegisterNetEvent('qb-phone:server:RemoveImageFromGallery', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local image = data.image
    exports.oxmysql:execute('DELETE FROM phone_gallery WHERE citizenid = ? AND image = ?',{Player.PlayerData.citizenid,image})
end)