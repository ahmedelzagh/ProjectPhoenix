local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-phone:server:addImageToGallery', function(image)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    exports.oxmysql:insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)',{Player.PlayerData.citizenid,image})
    
    -- Send Discord notification with photographer name
    local WebHook = Config.Webhook
    if WebHook and WebHook ~= '' then
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        local embedData = {
            {
                ['title'] = "Phone Photo Taken",
                ['color'] = 3447003,
                ['description'] = "**Photographer:** " .. playerName,
                ['image'] = {
                    ['url'] = image
                },
                ['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
        PerformHttpRequest(WebHook, function() end, 'POST', json.encode({username = 'QB Phone', embeds = embedData}), { ['Content-Type'] = 'application/json' })
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