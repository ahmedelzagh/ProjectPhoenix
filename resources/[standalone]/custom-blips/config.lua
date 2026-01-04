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
    
    -- Gabz MLO Locations
    {
        name = "Bowling",
        coords = vector3(761.50, -777.73, 26.31),
        sprite = 106,     -- Activity icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Car Meet",
        coords = vector3(958.82, -1699.67, 29.56),
        sprite = 225,     -- Car icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Cat Cafe",
        coords = vector3(-580.84, -1072.79, 22.33),
        sprite = 93,      -- Shop icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Diner",
        coords = vector3(1595.98, 6448.64, 25.32),
        sprite = 93,      -- Shop icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Harmony",
        coords = vector3(1183.07, 2648.53, 37.84),
        sprite = 72,      -- Garage icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Haters",
        coords = vector3(-1117.15, -1439.43, 5.11),
        sprite = 93,      -- Shop icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Hayes",
        coords = vector3(-1435.70, -445.74, 35.60),
        sprite = 72,      -- Garage icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "PDM",
        coords = vector3(-48.21, -1105.48, 27.26),
        sprite = 225,     -- Car icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = false
    },
    {
        name = "Bennys",
        coords = vector3(-47.53, -1042.61, 28.35),
        sprite = 72,      -- Garage icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Impound",
        coords = vector3(-143.15, -1175.06, 23.77),
        sprite = 50,      -- Impound icon
        color = 1,        -- Red
        scale = 0.7,
        shortRange = true
    },
    {
        name = "LS Customs",
        coords = vector3(723.12, -1088.83, 23.23),
        sprite = 72,      -- Garage icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Records Studio",
        coords = vector3(473.30, -109.44, 62.74),
        sprite = 136,     -- Music icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Pink Cage Motel",
        coords = vector3(323.91, -203.25, 54.09),
        sprite = 475,     -- Motel icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Park Ranger",
        coords = vector3(387.32, 790.15, 187.69),
        sprite = 60,      -- Ranger icon
        color = 2,        -- Green
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Sandy Shores PD",
        coords = vector3(1835.13, 3673.42, 34.34),
        sprite = 60,      -- Police icon
        color = 29,       -- Blue (Police)
        scale = 0.7,
        shortRange = false
    },
    {
        name = "Town Hall",
        coords = vector3(-544.56, -202.78, 38.42),
        sprite = 419,     -- Building icon
        color = 5,        -- Yellow
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Tuners",
        coords = vector3(157.59, -3017.99, 7.04),
        sprite = 72,      -- Garage icon
        color = 3,        -- Blue
        scale = 0.7,
        shortRange = true
    },
    {
        name = "Vanilla Unicorn",
        coords = vector3(129.46, -1299.68, 29.23),
        sprite = 93,      -- Shop icon
        color = 27,       -- Purple
        scale = 0.7,
        shortRange = true
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

