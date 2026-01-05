local QBCore = exports['qb-core']:GetCoreObject()

-- Load webhook from environment variable (set in server.env.cfg)
-- Falls back to empty string if not set (will show error in console)
Config = {
    Inv = "qb", -- qb(=lj) or ox [Inventory system]
    webhook = GetConvar('ps_camera_webhook', ''), -- Set in server.env.cfg: set ps_camera_webhook "YOUR_WEBHOOK_URL"
    UsePsMDT = false,
}
local function ConfigInvInvalid()
    print('^1[Error] Your Config.Inv isnt set.. you probably had a typo\nYou have it set as= Config.Inv = "'.. Config.Inv .. '"')
end

RegisterNetEvent("ps-camera:cheatDetect", function()
    DropPlayer(source, "Cheater Detected")
end)

RegisterNetEvent("ps-camera:requestWebhook", function(Key)
    local source = source
    local event = ("ps-camera:grabbed%s"):format(Key)
    if Config.webhook == '' then
        print("^1[Error] A webhook is missing in: Config.webhook")
    else
        TriggerClientEvent(event, source, Config.webhook)
    end
end)

RegisterNetEvent("ps-camera:CreatePhoto", function(base64Image)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return end

    local coords = GetEntityCoords(GetPlayerPed(source))
    
    -- Extract base64 data (remove data:image/jpeg;base64, prefix if present)
    local base64Data = base64Image
    if base64Image:match("^data:image/") then
        base64Data = base64Image:match("base64,(.+)$")
    end
    
    TriggerClientEvent("ps-camera:getStreetName", source, base64Data, coords)
end)

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

RegisterNetEvent("ps-camera:savePhoto", function(base64Data, streetName)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return end

    local location = streetName
    local playerName = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    
    -- Upload to Discord with photographer info
    local imageUrl = nil
    if Config.webhook and Config.webhook ~= '' then
        -- Create multipart/form-data for Discord webhook
        local boundary = "----WebKitFormBoundary" .. math.random(1000000000, 9999999999)
        local formData = ""
        
        -- Add payload_json (embed with photographer info)
        local embedData = {
            {
                ['title'] = "Photo Taken",
                ['color'] = 3447003,
                ['description'] = "**Photographer:** " .. playerName .. "\n**Location:** " .. location,
                ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
        local payloadJson = json.encode({username = 'PS Camera', embeds = embedData})
        
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
        PerformHttpRequest(Config.webhook, function(errCode, resultData, resultHeaders)
            if resultData then
                local response = json.decode(resultData)
                if response and response.attachments and response.attachments[1] then
                    imageUrl = response.attachments[1].proxy_url
                end
            end
            -- Save photo item
            local finalUrl = imageUrl or ("data:image/jpeg;base64," .. base64Data)
            local info = {
                ps_image = finalUrl,
                location = location
            }
            if not (Config.Inv == "qb" or Config.Inv == "ox") then 
                ConfigInvInvalid()
                return;
            end
            
            if Config.Inv == "qb" then
                player.Functions.AddItem("photo", 1, nil, info)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['photo'], "add")
            elseif Config.Inv == "ox" then
                local ox_inventory = exports.ox_inventory
                if not ox_inventory:CanCarryItem(source, 'photo', 1) then
                    return TriggerClientEvent('QBCore:Notify', source, "Can not carry photo!", "error")
                end
                ox_inventory:AddItem(source, "photo", 1, info)
            end
            
            TriggerClientEvent("ps-camera:savePhotoClient", source, finalUrl)
            
            if Config.UsePsMDT then
                TriggerEvent("ps-camera:ps-mdt", source, finalUrl)
            end
        end, 'POST', formData, {
            ['Content-Type'] = 'multipart/form-data; boundary=' .. boundary
        })
    else
        -- No webhook, use data URI
        local dataUri = "data:image/jpeg;base64," .. base64Data
        local info = {
            ps_image = dataUri,
            location = location
        }
        if not (Config.Inv == "qb" or Config.Inv == "ox") then 
            ConfigInvInvalid()
            return;
        end
        
        if Config.Inv == "qb" then
            player.Functions.AddItem("photo", 1, nil, info)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['photo'], "add")
        elseif Config.Inv == "ox" then
            local ox_inventory = exports.ox_inventory
            if not ox_inventory:CanCarryItem(source, 'photo', 1) then
                return TriggerClientEvent('QBCore:Notify', source, "Can not carry photo!", "error")
            end
            ox_inventory:AddItem(source, "photo", 1, info)
        end
        
        TriggerClientEvent("ps-camera:savePhotoClient", source, dataUri)
        
        if Config.UsePsMDT then
            TriggerEvent("ps-camera:ps-mdt", source, dataUri)
        end
    end
end)

RegisterNetEvent("ps-camera:savePhotoClient", function(imageUrl)
    TriggerClientEvent("ps-camera:savePhotoClientCallback", -1, imageUrl)
end)


QBCore.Functions.CreateUseableItem("camera", function(source, item)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not (Config.Inv == "qb" or Config.Inv == "ox") then 
        ConfigInvInvalid()
        return;
    end

    if Config.Inv == "qb" then
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent("ps-camera:useCamera", source)
        end
    elseif Config.Inv == "ox" then
        local ox_inventory = exports.ox_inventory
        if ox_inventory:GetItem(source, item.name, nil, true) > 0 then
            TriggerClientEvent("ps-camera:useCamera", source)
        end
    end
    
end)

QBCore.Functions.CreateUseableItem("photo", function(source, item)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not (Config.Inv == "qb" or Config.Inv == "ox") then 
        ConfigInvInvalid()
        return;
    end

    if Config.Inv == "qb" then
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent("ps-camera:usePhoto", source, item.info.ps_image, item.info.location)
        end
    elseif Config.Inv == "ox" then
        local ox_inventory = exports.ox_inventory
        if ox_inventory:GetItem(source, item.name, nil, true) > 0 then
            TriggerClientEvent("ps-camera:usePhoto", source, item.metadata.ps_image, item.metadata.location)
        end
    end
end)

function UseCam(source)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if not (Config.Inv == "qb" or Config.Inv == "ox") then 
        ConfigInvInvalid()
        return;
    end

    if Config.Inv == "qb" then
        if Player.Functions.GetItemByName('dslrcamera') then
            TriggerClientEvent("ps-camera:useCamera", source)
        else
            TriggerClientEvent('QBCore:Notify', source, "U don\'t have a camera", "error")
        end
    elseif Config.Inv == "ox" then
        local ox_inventory = exports.ox_inventory
        if ox_inventory:GetItem(source, 'dslrcamera', nil, true) > 0 then
            TriggerClientEvent("ps-camera:useCamera", source)
        else
            TriggerClientEvent('QBCore:Notify', source, "U don\'t have a camera", "error")
        end
    end    
end

exports("UseCam", UseCam)
