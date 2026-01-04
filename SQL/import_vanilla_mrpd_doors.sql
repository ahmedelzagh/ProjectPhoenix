-- ============================================
-- Vanilla MRPD Doorlock Import Script
-- ============================================
-- This script imports vanilla (default) MRPD doors into ox_doorlock
-- These work with the default GTA V Mission Row Police Department
-- Run this AFTER you have run FreshSQL.sql
-- ============================================

-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Delete existing vanilla MRPD doors if they exist (to avoid duplicates)
DELETE FROM `ox_doorlock` WHERE `name` LIKE 'mrpd %' OR `name` LIKE 'mrpd locker%' OR `name` LIKE 'mrpd cell%' OR `name` LIKE 'mrpd back%' OR `name` LIKE 'mrpd cells%' OR `name` LIKE 'mrpd captain%' OR `name` LIKE 'mrpd gate%' OR `name` LIKE 'mrpd armoury%';

-- Insert vanilla MRPD doors (default GTA V police station)
INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(1001, 'mrpd locker rooms', '{"maxDistance":2,"heading":90,"coords":{"x":450.1041259765625,"y":-985.7384033203125,"z":30.83930206298828},"groups":{"police":0},"state":1,"model":1557126584,"hideUi":false}'),
	(1002, 'mrpd cells/briefing', '{"maxDistance":2,"coords":{"x":444.7078552246094,"y":-989.4454345703125,"z":30.83930206298828},"doors":[{"model":185711165,"coords":{"x":446.0079345703125,"y":-989.4454345703125,"z":30.83930206298828},"heading":0},{"model":185711165,"coords":{"x":443.40777587890627,"y":-989.4454345703125,"z":30.83930206298828},"heading":180}],"groups":{"police":0},"state":1,"hideUi":false}'),
	(1003, 'mrpd cell 3', '{"maxDistance":2,"heading":90,"coords":{"x":461.8065185546875,"y":-1001.9515380859375,"z":25.06442832946777},"lockSound":"metal-locker","groups":{"police":0},"state":1,"unlockSound":"metallic-creak","model":631614199,"hideUi":false}'),
	(1004, 'mrpd back entrance', '{"maxDistance":2,"coords":{"x":468.6697692871094,"y":-1014.4520263671875,"z":26.5362319946289},"doors":[{"model":-2023754432,"coords":{"x":467.37164306640627,"y":-1014.4520263671875,"z":26.5362319946289},"heading":0},{"model":-2023754432,"coords":{"x":469.9678955078125,"y":-1014.4520263671875,"z":26.5362319946289},"heading":180}],"groups":{"police":0},"state":1,"hideUi":false}'),
	(1005, 'mrpd cells security door', '{"maxDistance":2,"heading":0,"coords":{"x":464.1282958984375,"y":-1003.5386962890625,"z":25.00598907470703},"autolock":5,"groups":{"police":0},"state":1,"model":-1033001619,"hideUi":false}'),
	(1006, 'mrpd cell 2', '{"maxDistance":2,"heading":90,"coords":{"x":461.8064880371094,"y":-998.3082885742188,"z":25.06442832946777},"lockSound":"metal-locker","groups":{"police":0},"state":1,"unlockSound":"metallic-creak","model":631614199,"hideUi":false}'),
	(1007, 'mrpd captain\'s office', '{"maxDistance":2,"heading":180,"coords":{"x":446.57281494140627,"y":-980.0105590820313,"z":30.83930206298828},"groups":{"police":0},"state":1,"model":-1320876379,"hideUi":false}'),
	(1008, 'mrpd gate', '{"maxDistance":6,"heading":90,"coords":{"x":488.894775390625,"y":-1017.2102661132813,"z":27.14714050292968},"groups":{"police":0},"auto":true,"state":1,"model":-1603817716,"hideUi":false}'),
	(1009, 'mrpd cell 1', '{"maxDistance":2,"heading":270,"coords":{"x":461.8065185546875,"y":-993.7586059570313,"z":25.06442832946777},"lockSound":"metal-locker","groups":{"police":0},"state":1,"unlockSound":"metallic-creak","model":631614199,"hideUi":false}'),
	(1010, 'mrpd cells main', '{"maxDistance":2,"heading":360,"coords":{"x":463.92010498046877,"y":-992.6640625,"z":25.06442832946777},"lockSound":"metal-locker","groups":{"police":0},"state":1,"unlockSound":"metallic-creak","model":631614199,"hideUi":false}'),
	(1011, 'mrpd armoury', '{"maxDistance":2,"heading":270,"coords":{"x":453.08428955078127,"y":-982.5794677734375,"z":30.81926536560058},"autolock":5,"groups":{"police":0},"state":1,"model":749848321,"hideUi":false}'),
	(1012, 'mrpd front entrance', '{"maxDistance":2,"coords":{"x":434.7478942871094,"y":-981.916748046875,"z":30.83926963806152},"groups":{"police":0,"offpolice":0},"state":0,"doors":[{"model":-1215222675,"coords":{"x":434.7478942871094,"y":-980.618408203125,"z":30.83926963806152},"heading":270},{"model":320433149,"coords":{"x":434.7478942871094,"y":-983.215087890625,"z":30.83926963806152},"heading":270}],"hideUi":false}'),
	(1013, 'mrpd garage door 1', '{"maxDistance":5,"heading":0,"coords":{"x":431.4056091308594,"y":-1001.1690063476563,"z":26.71261024475097},"groups":{"police":0},"auto":true,"lockSound":"button-remote","state":1,"model":-190780785,"hideUi":false}'),
	(1014, 'mrpd garage door 2', '{"maxDistance":5,"heading":0,"coords":{"x":436.223388671875,"y":-1001.1690063476563,"z":26.71261024475097},"groups":{"police":0},"auto":true,"lockSound":"button-remote","state":1,"model":-190780785,"hideUi":false}'),
	(1015, 'mrpd roof access', '{"maxDistance":2,"heading":90,"coords":{"x":464.36138916015627,"y":-984.677978515625,"z":43.83443832397461},"groups":{"police":0},"state":1,"model":-340230128,"hideUi":false}');

-- Verify import
SELECT COUNT(*) as imported_doors FROM `ox_doorlock` WHERE `name` LIKE 'mrpd%';

-- Expected result: 15 doors (vanilla MRPD)

