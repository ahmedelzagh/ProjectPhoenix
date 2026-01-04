Config = {}

-- Enable/Disable all blips
Config.EnableBlips = true

-- Default blip settings (can be overridden per blip)
Config.DefaultBlip = {
    sprite = 84,           -- Default sprite (house icon)
    display = 4,           -- Blip display type
    scale = 0.8,          -- Blip scale
    shortRange = false,   -- Show from far away (false) or only when close (true)
    category = 1,         -- Blip category
    alpha = 255           -- Blip alpha (transparency)
}

-- Custom Blips Configuration
-- Add any blips you want here. Each entry can override default settings.
Config.Blips = {
    -- HQ Locations (Inactive MLOs)
    {
        name = "House Grove",
        coords = vector3(-162.59, -1642.26, 34.13),
        sprite = 84,      -- House icon
        color = 2,        -- Green (Families color)
        scale = 0.8,
        shortRange = false
    },
    {
        name = "House Ballas",
        coords = vector3(84.19, -1962.47, 21.13),
        sprite = 84,      -- House icon
        color = 27,       -- Purple (Ballas color)
        scale = 0.8,
        shortRange = false
    },
    {
        name = "House Vagos",
        coords = vector3(357.79, -1989.48, 24.28),
        sprite = 84,      -- House icon
        color = 46,       -- Yellow (Vagos color)
        scale = 0.8,
        shortRange = false
    },
    {
        name = "Lost HQ",
        coords = vector3(982.73, -104.22, 74.85),
        sprite = 84,      -- House icon
        color = 1,        -- Red (Lost MC color)
        scale = 0.8,
        shortRange = false
    },
    
    -- Add more blips below as needed:
    -- {
    --     name = "Custom Location",
    --     coords = vector3(x, y, z),
    --     sprite = 50,     -- Optional: override default sprite
    --     color = 3,       -- Required: blip color
    --     scale = 0.6,     -- Optional: override default scale
    --     shortRange = true -- Optional: override default shortRange
    -- },
}

-- Blip Sprite Reference: https://docs.fivem.net/docs/game-references/blips/#blips
-- Blip Color Reference: https://docs.fivem.net/docs/game-references/blips/#blip-colors

