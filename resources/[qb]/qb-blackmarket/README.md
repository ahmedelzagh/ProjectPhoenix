# QB-BlackMarket

Black market dealer for illegal weapons, attachments, and ammunition.

## Features
- Discrete black market dealer with hidden blip
- Sells weapons, attachments, and ammo
- Supports qb-target and non-target interactions
- Configurable locations, prices, and stock
- Easy to add multiple dealer locations

## Installation

1. Ensure `qb-blackmarket` is in your `resources/[qb]/` folder
2. Add `ensure qb-blackmarket` to your `server.cfg`
3. Restart your server or run `ensure qb-blackmarket`

## Configuration

Edit `config.lua` to customize:

### Locations
```lua
Config.Locations = {
    [1] = {
        name = "blackmarket1",
        coords = vector4(x, y, z, heading), -- Change location
        ped = "g_m_m_chicold_01", -- Change ped model
        scenario = "WORLD_HUMAN_DRUG_DEALER_HARD",
        label = "Black Market Dealer",
        showblip = false, -- Keep false for illegal activity
        products = "blackmarket",
    },
}
```

### Products & Pricing
Located in `Config.Products["blackmarket"]`
- Adjust prices for each item
- Add or remove weapons/attachments
- Change stock amounts

### Current Location
The default location is at **coordinates: 309.09, -913.75, 29.29** (Downtown Los Santos alley)

## Usage

### With qb-target (recommended):
- Walk up to the dealer ped
- Press your target key (usually Left Alt)
- Click "Browse Black Market"

### Without qb-target:
- Walk up to the dealer ped (within 3m)
- Press **E** to browse

## Available Items

### Weapons:
- Standard: Pistol, Combat Pistol, SMG, Assault Rifle, Carbine Rifle
- Custom: AK-47, M4, HK-416, M110, MP9, MAC-10, UZI

### Attachments:
- Pistol: Clips, Suppressors, Flashlights
- SMG: Clips, Drums, Suppressors, Scopes
- Rifle: Clips, Drums, Suppressors, Flashlights, Grips, Scopes
- Sniper: Clips, Scopes

### Ammunition:
- Pistol, Rifle, SMG, Shotgun, MG, Sniper

## Adding More Locations

To add additional black market dealers:

```lua
[2] = {
    name = "blackmarket2",
    coords = vector4(x, y, z, heading),
    ped = "g_m_m_armboss_01",
    scenario = "WORLD_HUMAN_SMOKING",
    label = "Arms Dealer",
    showblip = false,
    products = "blackmarket",
},
```

## Future Enhancements

You can add:
- Gang requirements (edit `server/main.lua`)
- Police online checks
- Dynamic pricing based on time/events
- Rep system for better prices
- Special items for high-tier customers

## Support

This is a custom resource. Adjust prices and restrictions as needed for your server's economy.

