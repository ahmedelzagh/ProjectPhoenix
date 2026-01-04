# 🚀 Quick Migration Guide - Remove Paid Gabz Scripts

## ⚡ Quick Steps (5 minutes)

### Step 1: Backup Current Config
```bash
# In your server folder
copy resources.cfg resources.cfg.backup
```

### Step 2: Use Free Resources Config
**Option A (Recommended):** Copy the free version
```bash
copy resources.cfg.free resources.cfg
```

**Option B:** Manually edit `resources.cfg` and comment out all `cfx-gabz-*` lines (add `#` at the start)

### Step 3: Import Vanilla MRPD Doors (If Needed)
Your `FreshSQL.sql` already has vanilla MRPD doors! Check with:
```sql
SELECT * FROM ox_doorlock WHERE name LIKE 'mrpd%';
```

If you see results, you're good! If not, import:
```sql
-- Run: SQL/import_vanilla_mrpd_doors.sql
```

### Step 4: Restart Server
```bash
restart ox_doorlock
restart qb-policejob
```

### Step 5: Test
1. Join server as police officer
2. Go to MRPD: `/tp 441.71 -982.02 30.2`
3. Use `/doorlock` command
4. Doors should work! ✅

---

## ✅ What Changed?

### Removed (Paid):
- ❌ All `cfx-gabz-*` resources (70+ paid scripts)
- ❌ Gabz MRPD (paid version)

### Using Now (Free):
- ✅ Vanilla MRPD (default GTA V - FREE!)
- ✅ Vanilla police stations (FREE!)
- ✅ Vanilla banks, shops, etc. (FREE!)
- ✅ All doorlocks work with vanilla locations

---

## 🎯 Result

- ✅ **100% FREE** server setup
- ✅ **Working MRPD** with doorlocks
- ✅ **Better performance** (no extra map files)
- ✅ **No paid dependencies**
- ✅ **Stable** (vanilla locations never break)

---

## 🆘 Troubleshooting

### Doors Not Working?
1. Check database: `SELECT * FROM ox_doorlock WHERE name LIKE 'mrpd%';`
2. Make sure `ox_doorlock` is started
3. Verify you have `police` job
4. Check console for errors

### MRPD Not Loading?
- Vanilla MRPD is built into GTA V - it always loads!
- No map files needed
- Coordinates: `441.71, -982.02, 30.2`

### Server Errors?
- Make sure you commented out ALL `cfx-gabz-*` resources
- Check that `oxmysql` starts before `ox_doorlock`
- Verify database connection in `server.cfg`

---

## 📞 Need Help?

Check these files:
- `FREE_ALTERNATIVES_GUIDE.md` - Full guide
- `MRPD_FIX_GUIDE.md` - MRPD setup guide
- `resources.cfg.free` - Free resources config

---

## 🎉 You're Done!

Your server is now **100% FREE** and using vanilla GTA V locations. Everything should work perfectly!

