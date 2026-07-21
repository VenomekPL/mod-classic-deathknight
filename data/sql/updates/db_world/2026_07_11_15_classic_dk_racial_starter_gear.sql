-- Classic DK: per-race starter gear (clothes + immediate-proficiency weapons, no shields).
-- Acherus strip rows apply to all races (race 0); positive items are per race.

DELETE FROM `playercreateinfo_item` WHERE `class` = 6;

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `note`) VALUES
-- Strip Acherus CharStartOutfit (all races)
(0, 6, 38145, -1, 'Remove Deathweave Bag'),
(0, 6, 34652, -1, 'Remove Acherus Knight''s Hood'),
(0, 6, 34655, -1, 'Remove Acherus Knight''s Pauldrons'),
(0, 6, 34659, -1, 'Remove Acherus Knight''s Shroud'),
(0, 6, 34650, -1, 'Remove Acherus Knight''s Tunic'),
(0, 6, 34653, -1, 'Remove Acherus Knight''s Wristguard'),
(0, 6, 34649, -1, 'Remove Acherus Knight''s Gauntlets'),
(0, 6, 34651, -1, 'Remove Acherus Knight''s Girdle'),
(0, 6, 34656, -1, 'Remove Acherus Knight''s Legplates'),
(0, 6, 34648, -1, 'Remove Acherus Knight''s Greaves'),
(0, 6, 34657, -1, 'Remove Choker of Damnation'),
(0, 6, 34658, -1, 'Remove Plague Band'),
(0, 6, 38147, -1, 'Remove Corrupted Band'),
(0, 6, 41751, -1, 'Remove Black Mushroom'),
(0, 6, 40582, -1, 'Remove Scourgestone'),
(0, 6, 34666, -1, 'Remove The Sunbreaker'),
(0, 6, 34667, -1, 'Remove Archmage''s Guile'),
-- Human
(1, 6, 38, 1, 'Recruit''s Shirt'),
(1, 6, 39, 1, 'Recruit''s Pants'),
(1, 6, 40, 1, 'Recruit''s Boots'),
(1, 6, 49778, 1, 'Worn Greatsword'),
(1, 6, 117, 5, 'Tough Jerky'),
(1, 6, 159, 5, 'Refreshing Spring Water'),
-- Orc
(2, 6, 6125, 1, 'Brawler''s Harness'),
(2, 6, 139, 1, 'Brawler''s Pants'),
(2, 6, 140, 1, 'Brawler''s Boots'),
(2, 6, 12282, 1, 'Worn Battleaxe'),
(2, 6, 117, 5, 'Tough Jerky'),
(2, 6, 159, 5, 'Refreshing Spring Water'),
-- Dwarf
(3, 6, 38, 1, 'Recruit''s Shirt'),
(3, 6, 39, 1, 'Recruit''s Pants'),
(3, 6, 40, 1, 'Recruit''s Boots'),
(3, 6, 12282, 1, 'Worn Battleaxe'),
(3, 6, 117, 5, 'Tough Jerky'),
(3, 6, 159, 5, 'Refreshing Spring Water'),
-- Night Elf
(4, 6, 6120, 1, 'Squire''s Shirt'),
(4, 6, 6121, 1, 'Squire''s Pants'),
(4, 6, 6122, 1, 'Squire''s Boots'),
(4, 6, 49778, 1, 'Worn Greatsword'),
(4, 6, 117, 5, 'Tough Jerky'),
(4, 6, 159, 5, 'Refreshing Spring Water'),
-- Undead
(5, 6, 6125, 1, 'Brawler''s Harness'),
(5, 6, 139, 1, 'Brawler''s Pants'),
(5, 6, 140, 1, 'Brawler''s Boots'),
(5, 6, 49778, 1, 'Worn Greatsword'),
(5, 6, 117, 5, 'Tough Jerky'),
(5, 6, 159, 5, 'Refreshing Spring Water'),
-- Tauren
(6, 6, 6125, 1, 'Brawler''s Harness'),
(6, 6, 139, 1, 'Brawler''s Pants'),
(6, 6, 140, 1, 'Brawler''s Boots'),
(6, 6, 49778, 1, 'Worn Greatsword'),
(6, 6, 117, 5, 'Tough Jerky'),
(6, 6, 159, 5, 'Refreshing Spring Water'),
-- Gnome
(7, 6, 38, 1, 'Recruit''s Shirt'),
(7, 6, 39, 1, 'Recruit''s Pants'),
(7, 6, 40, 1, 'Recruit''s Boots'),
(7, 6, 49778, 1, 'Worn Greatsword'),
(7, 6, 117, 5, 'Tough Jerky'),
(7, 6, 159, 5, 'Refreshing Spring Water'),
-- Troll
(8, 6, 6125, 1, 'Brawler''s Harness'),
(8, 6, 139, 1, 'Brawler''s Pants'),
(8, 6, 140, 1, 'Brawler''s Boots'),
(8, 6, 12282, 1, 'Worn Battleaxe'),
(8, 6, 117, 5, 'Tough Jerky'),
(8, 6, 159, 5, 'Refreshing Spring Water'),
-- Blood Elf
(10, 6, 24143, 1, 'Initiate''s Shirt'),
(10, 6, 24145, 1, 'Initiate''s Pants'),
(10, 6, 24146, 1, 'Initiate''s Boots'),
(10, 6, 23346, 1, 'Battleworn Claymore'),
(10, 6, 117, 5, 'Tough Jerky'),
(10, 6, 159, 5, 'Refreshing Spring Water'),
-- Draenei
(11, 6, 23473, 1, 'Recruit''s Shirt'),
(11, 6, 23474, 1, 'Recruit''s Pants'),
(11, 6, 23475, 1, 'Recruit''s Boots'),
(11, 6, 23346, 1, 'Battleworn Claymore'),
(11, 6, 117, 5, 'Tough Jerky'),
(11, 6, 159, 5, 'Refreshing Spring Water');
