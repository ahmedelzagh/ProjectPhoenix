local QBCore = exports["qb-core"]:GetCoreObject()

-- You can add any server-side logic here, such as:
-- - Additional purchase restrictions
-- - Logging purchases
-- - Gang/job requirements
-- - Special pricing conditions
-- etc.

-- Example: Log black market purchases
RegisterNetEvent('qb-blackmarket:server:logPurchase', function(item, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    print(string.format("[Black Market] %s (%s) purchased %s for $%s", 
        Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
        Player.PlayerData.citizenid,
        item,
        price
    ))
end)

-- Example: Add gang requirement check
QBCore.Functions.CreateCallback('qb-blackmarket:server:canAccess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then 
        cb(false)
        return 
    end
    
    -- Add your access requirements here
    -- For example: require certain gang membership, police check, etc.
    
    cb(true)
end)

