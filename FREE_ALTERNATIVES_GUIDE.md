# Free FiveM Server Setup Guide - Replacing Paid Gabz Scripts

## 🎯 Overview

This guide will help you replace all paid Gabz scripts with **100% FREE** alternatives. Gabz scripts are paid map/interior resources that enhance locations in your server.

## ✅ What We'll Do

1. Remove/comment out all Gabz resources
2. Use vanilla (default) GTA V locations
3. Set up free MRPD doorlocks for vanilla MRPD
4. Provide free map/interior alternatives
5. Update your server configuration

---

## 📋 Step 1: Free MRPD Setup (Vanilla)

The **vanilla MRPD** (default GTA V police station) is FREE and works perfectly! We just need to set up doorlocks for it.

### Option A: Use Existing Vanilla MRPD Doorlocks

Your `FreshSQL.sql` already has vanilla MRPD doorlocks! They're named `mrpd 1`, `mrpd 2`, etc. (not `gabz_mrpd`).

**To use vanilla MRPD:**
1. ✅ Don't import `gabz_mrpd.sql` 
2. ✅ The vanilla doors are already in your database
3. ✅ Just remove `ensure cfx-gabz-mrpd` from resources.cfg

### Option B: Import Vanilla MRPD Doorlocks

If you need to re-import, use: `resources/[oxlib]/ox_doorlock/sql/community_mrpd.sql`

---

## 🗺️ Free Map/Interior Alternatives

### Police Departments (FREE)

| Gabz Resource | Free Alternative | Download Link |
|---------------|------------------|---------------|
| `cfx-gabz-mrpd` | **Vanilla MRPD** (default) | Built-in GTA V |
| `cfx-gabz-davispd` | **Vanilla Davis PD** | Built-in GTA V |
| `cfx-gabz-paletopd` | **Vanilla Paleto PD** | Built-in GTA V |
| `cfx-gabz-sandypd` | **Vanilla Sandy Shores PD** | Built-in GTA V |
| `cfx-gabz-lamesapd` | **Vanilla La Mesa PD** | Built-in GTA V |

**Note:** All vanilla police stations work perfectly with ox_doorlock!

### Banks (FREE)

| Gabz Resource | Free Alternative | Download Link |
|---------------|------------------|---------------|
| `cfx-gabz-fleeca` | **Vanilla Fleeca Banks** | Built-in GTA V |
| `cfx-gabz-pacificbank` | **Vanilla Pacific Bank** | Built-in GTA V |
| `cfx-gabz-paletobank` | **Vanilla Paleto Bank** | Built-in GTA V |

### Shops & Businesses (FREE)

| Gabz Resource | Free Alternative | Notes |
|---------------|------------------|-------|
| `cfx-gabz-247` | **Vanilla 24/7 Stores** | Built-in GTA V |
| `cfx-gabz-ammunation` | **Vanilla Ammunation** | Built-in GTA V |
| `cfx-gabz-barber` | **Vanilla Barbers** | Built-in GTA V |
| `cfx-gabz-binco` | **Vanilla Clothing Stores** | Built-in GTA V |
| `cfx-gabz-pdm` | **Vanilla PDM** | Built-in GTA V |
| `cfx-gabz-tattoo` | **Vanilla Tattoo Shops** | Built-in GTA V |

### Other Locations (FREE)

| Gabz Resource | Free Alternative | Notes |
|---------------|------------------|-------|
| `cfx-gabz-pillbox` | **Vanilla Pillbox Medical** | Built-in GTA V |
| `cfx-gabz-prison` | **Vanilla Bolingbroke Prison** | Built-in GTA V |
| `cfx-gabz-bennys` | **Vanilla Los Santos Customs** | Built-in GTA V |

---

## 🔧 Step 2: Update resources.cfg

I'll create a new version of your resources.cfg with all Gabz resources commented out.

---

## 📦 Free Map/Interior Resources (Optional)

If you want enhanced locations beyond vanilla, here are **FREE** alternatives:

### Free MRPD Alternatives:
1. **Community MRPD** - Free on GitHub/Cfx.re
2. **Open Source MRPD** - Various free versions available
3. **Vanilla MRPD** - Default GTA V (recommended, works great!)

### Where to Find Free Maps:
- **Cfx.re Forum** - Search for "free MLO" or "free map"
- **GitHub** - Search "FiveM free MLO"
- **Toxic FiveM** - Has some free MRPD versions
- **Community Discord Servers** - Often share free resources

### Recommended Free Resources:
1. **Vanilla Locations** - Always work, no downloads needed
2. **Community-made free MLOs** - Check Cfx.re forums
3. **Open-source maps** - GitHub repositories

---

## 🚫 What to Remove

### Remove These from resources.cfg:
- All `cfx-gabz-*` resources (70+ lines)
- `cfx-gabz-mapdata` (if not using any Gabz resources)
- `cfx-gabz-pdprops` (if not using any Gabz PDs)
- `cfx-gabz-scenarios` (optional, can keep if you want)

### Keep These (They're Free):
- ✅ `ox_lib`, `ox_target`, `ox_doorlock`, `oxmysql`
- ✅ All `qb-*` resources
- ✅ All `[standalone]` resources
- ✅ All `[voice]` resources

---

## 🎮 Vanilla Locations Coordinates

### Vanilla MRPD:
- **Coordinates:** `441.71, -982.02, 30.2` (duty location)
- **Garage:** `448.15, -1017.4, 22.96`
- **Armory:** `482.55, -995.21, 29.89`

### Vanilla Police Stations:
- **Mission Row PD:** `441.71, -982.02, 30.2`
- **Davis PD:** `-448.0, 6009.0, 31.7`
- **Paleto Bay Sheriff:** `-448.0, 6009.0, 31.7`
- **Sandy Shores Sheriff:** `1853.0, 3689.0, 34.2`

---

## ✅ Benefits of Using Vanilla Locations

1. **100% Free** - No cost, no licenses
2. **Stable** - Built into GTA V, always works
3. **Compatible** - Works with all scripts
4. **No Updates Needed** - Never breaks
5. **Familiar** - Players know the locations
6. **Performance** - Better FPS (no extra map files)

---

## 🔄 Migration Steps

1. **Backup your current resources.cfg**
   ```bash
   copy resources.cfg resources.cfg.backup
   ```

2. **Replace resources.cfg with free version**
   - I've created `resources.cfg.free` for you
   - Rename it to `resources.cfg` or copy its contents

3. **Import vanilla MRPD doorlocks** (if needed)
   - Use `SQL/import_vanilla_mrpd_doors.sql`
   - OR your FreshSQL.sql already has them (named "mrpd 1", "mrpd 2", etc.)

4. **Restart your server**
   - All Gabz resources are now disabled
   - Vanilla locations will work automatically

5. **Test your server**
   - Join as police
   - Go to vanilla MRPD (coordinates: 441.71, -982.02, 30.2)
   - Use `/doorlock` command
   - Doors should work!

6. **Optional:** Add free community maps later if desired

---

## 📝 Notes

- **Vanilla MRPD works perfectly** with ox_doorlock
- **All door coordinates** are already configured in your database
- **No map files needed** - vanilla locations are built-in
- **Your police job config** already uses vanilla MRPD coordinates
- **Doorlocks will work immediately** after removing Gabz resources
- **Files created:**
  - `resources.cfg.free` - Free version of resources.cfg (all Gabz commented out)
  - `SQL/import_vanilla_mrpd_doors.sql` - Vanilla MRPD doorlocks SQL
  - `FREE_ALTERNATIVES_GUIDE.md` - This guide

---

## 🆘 Need Help?

If something doesn't work:
1. Check console for errors
2. Verify doorlocks in database: `SELECT * FROM ox_doorlock WHERE name LIKE 'mrpd%';`
3. Make sure you're using vanilla MRPD (not Gabz)
4. Check that ox_doorlock is started after oxmysql

---

## 🎉 Result

After following this guide, you'll have:
- ✅ 100% FREE server setup
- ✅ Working MRPD with doorlocks
- ✅ All vanilla locations functional
- ✅ No paid script dependencies
- ✅ Better server performance

