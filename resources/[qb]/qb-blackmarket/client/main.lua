local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local currentShop, currentData
local pedSpawned = false
local BlackMarketPed = {}

-- Functions
local function openBlackMarket(shop, data)
    local ShopItems = {}
    ShopItems.label = data.label
    ShopItems.items = Config.Products[Config.Locations[shop].products]
    ShopItems.slots = #ShopItems.items
    
    for k in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "BlackMarket_" .. shop, ShopItems)
end

local function createPed()
    if pedSpawned then return end

    for k, v in pairs(Config.Locations) do
        local pedModel = type(v.ped) == "number" and v.ped or joaat(v.ped)

        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(0)
        end

        BlackMarketPed[k] = CreatePed(0, pedModel, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
        
        if v.scenario then
            TaskStartScenarioInPlace(BlackMarketPed[k], v.scenario, 0, true)
        end
        
        FreezeEntityPosition(BlackMarketPed[k], true)
        SetEntityInvincible(BlackMarketPed[k], true)
        SetBlockingOfNonTemporaryEvents(BlackMarketPed[k], true)

        if Config.UseTarget then
            exports['qb-target']:AddTargetEntity(BlackMarketPed[k], {
                options = {
                    {
                        label = "Browse Black Market",
                        icon = "fas fa-user-secret",
                        action = function()
                            openBlackMarket(k, Config.Locations[k])
                        end,
                    }
                },
                distance = 2.0
            })
        end
    end

    pedSpawned = true
end

local function deletePeds()
    if not pedSpawned then return end

    for _, v in pairs(BlackMarketPed) do
        if Config.UseTarget then
            exports['qb-target']:RemoveTargetEntity(v)
        end
        DeletePed(v)
    end
    
    pedSpawned = false
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    createPed()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    PlayerData = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    createPed()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)

-- Non-target interaction (if UseTarget is false)
if not Config.UseTarget then
    CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            for k, v in pairs(Config.Locations) do
                local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                
                if dist < 3.0 then
                    sleep = 0
                    DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[E] " .. v.label)
                    
                    if IsControlJustPressed(0, 38) then -- E key
                        openBlackMarket(k, Config.Locations[k])
                    end
                end
            end

            Wait(sleep)
        end
    end)
end

-- Helper function for 3D text
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

