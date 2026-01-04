Config = {}

-- 0. UI section of heating
Config.ShowHeatUI = true            -- If you want you can set to false, i wont shows heat UI.
Config.UIStyle = "PNG"              -- Currently leave this at is.
Config.OverheatText = "OVERHEAT!"   -- You can change text if you want

Config.WeaponsList = { -- If you have custom weapons or using more weapons, please in this list and in html/img/your_image.png
    "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_SNSPISTOL",
    "WEAPON_HEAVYPISTOL", "WEAPON_VINTAGEPISTOL", "WEAPON_MARKSMANPISTOL", "WEAPON_REVOLVER",
    "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_COMBATPDW", "WEAPON_MACHINEPISTOL", 
    "WEAPON_MINISMG", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", 
    "WEAPON_BULLPUPSHOTGUN", "WEAPON_MUSKET", "WEAPON_HEAVYSHOTGUN", "WEAPON_DBSHOTGUN", 
    "WEAPON_AUTOSHOTGUN", "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", 
    "WEAPON_SPECIALCARBINE", "WEAPON_BULLPUPRIFLE", "WEAPON_COMPACTRIFLE", "WEAPON_MG", 
    "WEAPON_COMBATMG", "WEAPON_GUSENBERG", "WEAPON_SNIPERRIFLE", "WEAPON_HEAVYSNIPER", 
    "WEAPON_MARKSMANRIFLE", "WEAPON_RPG", "WEAPON_GRENADELAUNCHER", "WEAPON_MINIGUN", 
    "WEAPON_RAILGUN", "WEAPON_HOMINGLAUNCHER", "WEAPON_COMPACTLAUNCHER"
}

-- 1. EDITOR VISUAL SETTINGS (DEBUG MODE)
Config.GizmoSize = 0.08   -- Meaning: Size of the colored movement arrows (X/Y/Z) in the editor.
Config.CubeSize = 0.002   -- Meaning: Size of the small white center cube in the editor.

-- 2. GLOBAL SMOKE LOGIC
-- Default rules for smoke behavior if a weapon doesn't have specific settings.
Config.SmokeLogic = {
    Interval = 80,             -- Meaning: Time in ms between smoke puffs. Lower = denser smoke, Higher = better FPS.
    MaxHeatScale = 1.2,        -- Meaning: Maximum size multiplier for the smoke when gun is hot.
    HeatUpSpeed = 0.05,        -- Meaning: How fast the smoke gets bigger while shooting.
    DefaultDuration = 5.0,     -- Meaning: How many seconds the gun smokes after you stop shooting.
    MaxSmokeOnLastShot = true, -- Meaning: If true, creates a big puff of smoke when ammo hits 0.
    -- NaturalSmokeMovement: Please this control in the game UI for each weapon!
    NaturalSmokeMovement = false -- Don't touch this..
}

-- 2.1 WEAPON JAMMING
Config.Jamming = {
    Enabled = true,             -- Enable the jamming system?
    Duration = 3000,            -- How many milliseconds the weapon will be jammed for? (YOU CAN EDIT FROM /SMOKEDEBUG WEAPON K LOGIC UI FOR EACH WEAPON)
    -- SOUND
    UseCustomSound = true,      -- TRUE: Uses your .ogg file and volume setting. FALSE: Uses the GTA beep sound.
    Volume = 0.2,               -- Volume (from 0.1 to 1.0). Works ONLY if UseCustomSound = true
    SoundFile = "jam.ogg",      -- Your file name (must be uploaded to the html folder)
    -- GTA DEFAULT SOUND (Works only if UseCustomSound = false)
    SoundName = "ERROR",        
    SoundDict = "HUD_FRONTEND_DEFAULT_SOUNDSET"
}


-- 3. DEFAULT PARTICLE SETTINGS
-- Fallback settings for unconfigured weapons.
Config.DefaultParticle = { 
    dict = "core",                        -- Meaning: GTA V particle dictionary name.
    name = "ent_anim_cig_exhale_nse", -- Meaning: Specific particle effect name.
    scale = 0.4,                          -- Meaning: Base size of the smoke.
    pos = vector3(0.0, 0.0, 0.0),         -- Meaning: Position offset (Left/Right, Forward/Back, Up/Down).
    rot = vector3(0.0, 0.0, 0.0)          -- Meaning: Rotation offset (Pitch, Roll, Yaw).
}

-- 4. EDITOR SPEED SETTINGS
-- Controls how fast objects move when editing.
Config.SpeedSettings = {
    [1] = { name = "SLOW",    move = 0.001, rot = 0.1, mouse = 0.0005 }, -- Precision mode
    [2] = { name = "FAST",    move = 0.05,  rot = 2.0, mouse = 0.008 },  -- Fast movement
    [3] = { name = "NORMAL",  move = 0.005, rot = 0.5, mouse = 0.0015 }  -- Standard mode
}

-- 5. WEAPON BLACKLIST
-- Weapons listed here will NEVER emit smoke.
Config.Blacklist = {
    [GetHashKey("WEAPON_STUNGUN")] = true,          -- Taser
    [GetHashKey("WEAPON_FLASHLIGHT")] = true,       -- Flashlight
    [GetHashKey("WEAPON_FIREEXTINGUISHER")] = true, -- Fire Extinguisher
    [GetHashKey("WEAPON_PETROLCAN")] = true,        -- Jerry Can
    [GetHashKey("WEAPON_HAZARDCAN")] = true,        -- Hazard Can
    [GetHashKey("WEAPON_SNOWBALL")] = true          -- Snowball
}

-- 6. WEAPON CONFIGURATION (NO NEED ADD, YOU CAN MANAGE EVERYTHING FROM THE GAME)
-- Individual settings for specific guns.
Config.Weapons = {
    [GetHashKey("WEAPON_PISTOL")] = {
        dict = "core", name = "ent_anim_cig_exhale_nse",
        scale = 0.50, pos = vector3(0.134, 0.000, 0.046), rot = vector3(0.0, 0.0, 0.0),
        heatPerShot = 0.1,        -- Meaning: Heat added per 1 bullet.
        maxHeat = 0.5,            -- Meaning: Max smoke size for this gun.
        SmokeDuration = 5.0       -- Meaning: Cooldown time in seconds.
    },
    [GetHashKey("WEAPON_SMG")] = {
        dict = "core", name = "ent_anim_cig_exhale_nse",
        scale = 0.50, pos = vector3(0.439, -0.001, 0.034), rot = vector3(0.0, 0.0, 0.0),
        heatPerShot = 0.04, 
        maxHeat = 0.7, 
        SmokeDuration = 12.0 
    }
}

-- EDITABLE TEXT & COMMAND
Config.Command = "smokedebug" -- Command to use

Config.Text = "SAVED"
Config.Text_2 = "Settings saved and applied!"
Config.Text_3 = "INFO"
Config.Text_4 = "Restored to the saved position!"
Config.Text_5 = "ERROR"
Config.Text_6 = "Take the weapon in your hands!"
Config.Text_7 = "Logic and Particle settings updated!"

-- 7. CONTROLS / KEYS
-- You can change all control keys here. 
-- Codes found here: https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    OpenMenu      = 311, -- [K] Open Logic/Settings Menu
    Exit          = 200, -- [ESC] Exit Editor Mode
    
    CamLook       = 25,  -- [RMB] Right Mouse Button to rotate camera
    ObjRotate     = 36,  -- [LCTRL] Rotate the weapon object itself (not smoke)
    
    SwitchMode    = 137,  -- [CAPSLOCK] Switch between Move / Rotate mode
    ChangeSpeed   = 21,  -- [LSHIFT] Cycle movement speeds (Slow/Normal/Fast)
    ToggleGizmo   = 26,  -- [C] Show/Hide helper lines (Gizmo)
    ToggleAuto    = 182, -- [L] Toggle Auto-Play (Automatic shooting)
    ToggleMouse   = 73,  -- [X] Enable/Disable mouse cursor
    
    ScaleUp       = 314, -- [Numpad +] Increase smoke size
    ScaleDown     = 315, -- [Numpad -] Decrease smoke size
    
    ResetPos      = 45,  -- [R] Reset to last saved position
    TestFire      = 19,  -- [LALT] Manual smoke test fire
    Save          = 191, -- [ENTER] Save all settings
    
    -- MOVEMENT (Arrows)
    MoveUp        = 172, -- Arrow Up (Move Up/Forward)
    MoveDown      = 173, -- Arrow Down (Move Down/Back)
    MoveLeft      = 174, -- Arrow Left
    MoveRight     = 175, -- Arrow Right
    MoveZUp       = 10,  -- Page Up (Move Vertically Up)
    MoveZDown     = 11,  -- Page Down (Move Vertically Down)

    -- CAMERA PRESETS (Numpad)
    CamView1      = 157, -- [1] Rear View
    CamView2      = 158, -- [2] Side View
    CamView3      = 160, -- [3] Top View
    ZoomIn        = 14,  -- Scroll Up (Zoom In)
    ZoomOut       = 15   -- Scroll Down (Zoom Out)
}