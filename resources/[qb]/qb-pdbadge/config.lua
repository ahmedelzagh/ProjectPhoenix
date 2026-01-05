Config = {}

Config.SendLog = true  --Set to true to send a discord log.
-- Load webhook from environment variable (set in server.env.cfg)
-- Falls back to empty string if not set
Config.Webhook = GetConvar('qb_pdbadge_webhook', '') -- Set in server.env.cfg: set qb_pdbadge_webhook "YOUR_WEBHOOK_URL"
