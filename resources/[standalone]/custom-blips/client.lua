-- Custom Blips System
-- Generic blip resource for adding custom map markers
-- Configure blips in config.lua

local blips = {}

local function CreateBlip(blipConfig)
    if not blipConfig.name or not blipConfig.coords or not blipConfig.color then
        print("^1[Custom Blips]^7 Error: Blip missing required fields (name, coords, color)")
        return nil
    end
    
    local blip = AddBlipForCoord(blipConfig.coords.x, blipConfig.coords.y, blipConfig.coords.z)
    
    -- Use config values or defaults
    local sprite = blipConfig.sprite or Config.DefaultBlip.sprite
    local display = blipConfig.display or Config.DefaultBlip.display
    local scale = blipConfig.scale or Config.DefaultBlip.scale
    local shortRange = blipConfig.shortRange ~= nil and blipConfig.shortRange or Config.DefaultBlip.shortRange
    local category = blipConfig.category or Config.DefaultBlip.category
    local alpha = blipConfig.alpha or Config.DefaultBlip.alpha
    
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, blipConfig.color)
    SetBlipAsShortRange(blip, shortRange)
    SetBlipCategory(blip, category)
    SetBlipAlpha(blip, alpha)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(blipConfig.name)
    EndTextCommandSetBlipName(blip)
    
    return blip
end

local function CreateAllBlips()
    if not Config.EnableBlips then
        return
    end
    
    for i = 1, #Config.Blips do
        local blip = CreateBlip(Config.Blips[i])
        if blip then
            blips[#blips + 1] = blip
        end
    end
end

-- Create blips when resource starts
CreateThread(function()
    Wait(1000) -- Wait a bit for everything to load
    CreateAllBlips()
end)

-- Clean up blips when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for i = 1, #blips do
            if DoesBlipExist(blips[i]) then
                RemoveBlip(blips[i])
            end
        end
    end
end)

