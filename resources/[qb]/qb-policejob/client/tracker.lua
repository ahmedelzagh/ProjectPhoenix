-- Cooldown to prevent spam notifications
local lastAnkletCheck = 0
local ankletCooldown = 5000 -- 5 seconds cooldown (increased to prevent spam during teleports)
local lastPlayerCoords = nil
local teleportCooldown = 3000 -- 3 seconds after teleport to suppress notifications

RegisterNetEvent('police:client:CheckDistance', function()
    -- Add cooldown to prevent spam notifications from accidental triggers
    local currentTime = GetGameTimer()
    if currentTime - lastAnkletCheck < ankletCooldown then
        return
    end
    
    -- Check if player just teleported (large position change)
    local currentCoords = GetEntityCoords(PlayerPedId())
    if lastPlayerCoords then
        local distance = #(currentCoords - lastPlayerCoords)
        if distance > 50.0 then -- Likely a teleport
            lastAnkletCheck = currentTime + teleportCooldown
            lastPlayerCoords = currentCoords
            return -- Suppress notification during/after teleport
        end
    end
    lastPlayerCoords = currentCoords
    lastAnkletCheck = currentTime
    
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SetTracker", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error", 3000)
    end
end)

-- Track player position to detect teleports
CreateThread(function()
    while true do
        Wait(1000)
        local currentCoords = GetEntityCoords(PlayerPedId())
        if lastPlayerCoords then
            local distance = #(currentCoords - lastPlayerCoords)
            if distance > 50.0 then
                -- Player likely teleported, reset cooldown
                lastAnkletCheck = GetGameTimer() + teleportCooldown
            end
        end
        lastPlayerCoords = currentCoords
    end
end)

RegisterNetEvent('police:client:SetTracker', function(bool)
    local trackerClothingData = {
        outfitData = {
            ["accessory"]   = { item = -1, texture = 0},  -- Nek / Das
        }
    }

    if bool then
        trackerClothingData.outfitData = {
            ["accessory"] = { item = 13, texture = 0}
        }

        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    else
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    end
end)

RegisterNetEvent('police:client:SendTrackerLocation', function(requestId)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    TriggerServerEvent('police:server:SendTrackerLocation', coords, requestId)
end)

RegisterNetEvent('police:client:TrackerMessage', function(msg, coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    QBCore.Functions.Notify(msg, 'police')
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Lang:t('info.ankle_location'))
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)