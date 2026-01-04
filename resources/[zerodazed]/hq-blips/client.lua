-- HQ Blips for inactive MLOs
-- These blips mark HQ locations that aren't active yet

local blips = {}

local HQLocations = {
    {
        name = "House Grove",
        coords = vector3(-162.59, -1642.26, 34.13),
        sprite = 84,      -- House icon
        color = 2,        -- Green (Families color)
        scale = 0.8
    },
    {
        name = "House Ballas",
        coords = vector3(84.19, -1962.47, 21.13),
        sprite = 84,      -- House icon
        color = 27,       -- Purple (Ballas color)
        scale = 0.8
    },
    {
        name = "House Vagos",
        coords = vector3(357.79, -1989.48, 24.28),
        sprite = 84,      -- House icon
        color = 46,       -- Yellow (Vagos color)
        scale = 0.8
    },
    {
        name = "Lost HQ",
        coords = vector3(982.73, -104.22, 74.85),
        sprite = 84,      -- House icon
        color = 1,        -- Red (Lost MC color)
        scale = 0.8
    }
}

local function CreateBlips()
    for i = 1, #HQLocations do
        local hq = HQLocations[i]
        local blip = AddBlipForCoord(hq.coords.x, hq.coords.y, hq.coords.z)
        
        SetBlipSprite(blip, hq.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, hq.scale)
        SetBlipColour(blip, hq.color)
        SetBlipAsShortRange(blip, false)  -- Show on map from far away
        SetBlipCategory(blip, 1)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(hq.name)
        EndTextCommandSetBlipName(blip)
        
        blips[#blips + 1] = blip
    end
end

-- Create blips when resource starts
CreateThread(function()
    Wait(1000) -- Wait a bit for everything to load
    CreateBlips()
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

